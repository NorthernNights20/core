extends Node

const HERD_DIR: String = "user://Herd/"
const DOT_CAPACITY: Dictionary = {0: 0, 1: 3, 2: 7, 3: 12, 4: 18, 5: 25}


const VICTIM_BLOOD_POOL_BP: = 10
const COOLDOWN_DAYS: = 7

var rand: RandomNumberGenerator = RandomNumberGenerator.new()

func _ready() -> void :
    DirAccess.make_dir_recursive_absolute(HERD_DIR)
    print("🩸 HerdManager ready; dir:", HERD_DIR)

    if CalendarManager and CalendarManager.has_signal("day_changed"):
        CalendarManager.day_changed.connect(_on_day_changed)


func _cap_for(dots: int) -> int:
    return int(DOT_CAPACITY.get(clamp(dots, 0, 5), 0))

func _file_path(character_name: String) -> String:
    return HERD_DIR + character_name + ".txt"

func _load_raw(character_name: String) -> Dictionary:
    var path: String = _file_path(character_name)
    if not FileAccess.file_exists(path):
        return {"members": []}

    var f: FileAccess = FileAccess.open(path, FileAccess.READ)
    var txt: String = f.get_as_text()
    f.close()

    var parsed: = JSON.new()
    var err: int = parsed.parse(txt)
    if err != OK:
        print("⚠️ Herd JSON parse error for", character_name, ":", parsed.get_error_message())
        return {"members": []}

    var root_v: Variant = parsed.data
    if root_v is Dictionary:
        return root_v as Dictionary
    return {"members": []}

func _save_raw(character_name: String, data: Dictionary) -> void :
    var path: String = _file_path(character_name)
    var f: FileAccess = FileAccess.open(path, FileAccess.WRITE)
    f.store_string(JSON.stringify(data, "\t"))
    f.close()


func _slot(member: Dictionary) -> Dictionary:
    var nm: String = String(member.get("name", ""))

    var st: String = String(member.get("status", "Healthy"))
    var bl: int = clamp(int(member.get("blood", 10)), 0, 10)
    var unlock_date: String = String(member.get("unlock_date", ""))
    return {
        "name": nm, 
        "status": st, 
        "blood": bl, 
        "unlock_date": unlock_date, 
    }

func _ensure_slots_for(character_name: String, capacity: int) -> Dictionary:
    var cur: Dictionary = _load_raw(character_name)
    var members: Array[Dictionary] = []

    if cur.has("members") and cur["members"] is Array:
        for m_v in (cur["members"] as Array):
            if m_v is Dictionary:
                members.append(_slot(m_v as Dictionary))


    while members.size() > capacity:
        members.pop_back()
    while members.size() < capacity:
        members.append(_slot({}))

    var norm: Dictionary = {"members": members}
    _save_raw(character_name, norm)
    return norm


func _today_str() -> String:
    return CalendarManager.get_current_date_string()

func _add_days(date_str: String, days: int) -> String:
    return CalendarManager.date_plus_days(date_str, days)

func _date_geq(a: String, b: String) -> bool:
    if a == "" or b == "": return false
    var pa: = a.split("-"); var pb: = b.split("-")
    if pa.size() != 3 or pb.size() != 3: return false
    var ay: = pa[0].to_int(); var am: = pa[1].to_int(); var ad: = pa[2].to_int()
    var by: = pb[0].to_int(); var bm: = pb[1].to_int(); var bd: = pb[2].to_int()
    if ay != by: return ay > by
    if am != bm: return am > bm
    return ad >= bd

func _lock_dead_slot(m: Dictionary) -> void :
    var unlock_on: = _add_days(_today_str(), COOLDOWN_DAYS)
    m["unlock_date"] = unlock_on

func _try_unlock_expired_slots_for(character_name: String) -> void :
    var data: = _load_raw(character_name)
    var members_any: Variant = data.get("members", [])
    if not (members_any is Array):
        return
    var members: Array = members_any as Array
    var changed: = false
    var today: = _today_str()
    for i in range(members.size()):
        var m_v: Variant = members[i]
        if not (m_v is Dictionary):
            continue
        var m: Dictionary = m_v as Dictionary
        var status: String = String(m.get("status", "Healthy"))
        var unlock_date: String = String(m.get("unlock_date", ""))

        if status == "Dead" and unlock_date != "" and _date_geq(today, unlock_date):
            m["name"] = ""
            m["status"] = "Healthy"
            m["blood"] = 10
            m["unlock_date"] = ""
            members[i] = _slot(m)
            changed = true
    if changed:
        _save_raw(character_name, {"members": members})


func _control_virtue_name(character: CharacterData) -> String:

    return "self_control" if int(character.self_control) >= int(character.instinct) else "instinct"

func _control_virtue_value(character: CharacterData) -> int:
    return int(character.get(_control_virtue_name(character)))

func _hungry_for_frenzy(character: CharacterData) -> bool:
    var ctrl: int = clamp(_control_virtue_value(character), 0, 10)
    var threshold: int = 7 - ctrl
    return int(character.blood_pool) < threshold

func _roll_virtue_capped_by_path(character: CharacterData, difficulty: int = 6) -> Dictionary:
    var v_name: String = _control_virtue_name(character)
    var v_val: int = clamp(int(character.get(v_name)), 0, 10)
    var cap: int = clamp(int(character.path), 0, 10)
    var pool: int = min(v_val, cap)

    var rolls: Array[int] = []
    var succ: int = 0
    var ones: int = 0
    rand.randomize()
    for _i in range(pool):
        var r: int = rand.randi_range(1, 10)
        rolls.append(r)
        if r == 1:
            ones += 1
        elif r >= difficulty:
            succ += 1

    var net: int = succ - ones
    return {
        "virtue_name": v_name, 
        "virtue_val": v_val, 
        "path_cap": cap, 
        "pool_used": pool, 
        "difficulty": difficulty, 
        "rolls": rolls, 
        "successes": succ, 
        "ones": ones, 
        "net_successes": net, 
        "passed": net > 0
    }


func _roll_conscience_capped_by_path(character: CharacterData, difficulty: int = 8) -> Dictionary:
    var on_humanity: = String(character.path_name) == "Humanity"
    var use_conviction: = ( not on_humanity) or int(character.conscience) <= 0

    var virtue_key: = "conviction" if use_conviction else "conscience"
    var virtue_label: = "Conviction" if use_conviction else "Conscience"

    var v_val: int = clamp(int(character.get(virtue_key)), 0, 10)
    var cap: int = clamp(int(character.path), 0, 10)
    var pool: int = min(v_val, cap)

    var rolls: Array[int] = []
    var succ: = 0
    var ones: = 0
    rand.randomize()
    for _i in range(pool):
        var r: = rand.randi_range(1, 10)
        rolls.append(r)
        if r == 1:
            ones += 1
        elif r >= difficulty:
            succ += 1

    var net: = succ - ones
    var passed: = net > 0

    print("🐛[HerdManager] Degeneration roll (%s) → pool=%d (virt=%d cap=%d) diff=%d rolls=%s net=%d passed=%s"
        %[virtue_label, pool, v_val, cap, difficulty, str(rolls), net, str(passed)])

    return {
        "virtue": virtue_label, 
        "pool_used": pool, 
        "difficulty": difficulty, 
        "rolls": rolls, 
        "successes": succ, 
        "ones": ones, 
        "net_successes": net, 
        "passed": passed
    }


func get_state(character_name: String) -> Dictionary:
    if not GameManager.character_data_by_name.has(character_name):
        return {"ok": false, "error": "Character not found."}


    _try_unlock_expired_slots_for(character_name)

    var cd: CharacterData = GameManager.character_data_by_name[character_name]
    var cap: int = _cap_for(int(cd.herd))
    var data: Dictionary = _ensure_slots_for(character_name, cap)

    var members_any: Variant = data.get("members", [])
    var members: Array = members_any if members_any is Array else []
    var packed: Array[Dictionary] = []
    var defined_count: int = 0

    for i in range(members.size()):
        var m_v: Variant = members[i]
        var m: Dictionary = (m_v as Dictionary) if (m_v is Dictionary) else {}
        var nm: String = String(m.get("name", ""))
        var has_member: bool = not nm.strip_edges().is_empty()
        if has_member:
            defined_count += 1
        packed.append({
            "index": i, 
            "has_member": has_member, 
            "name": nm, 
            "status": String(m.get("status", "Healthy")), 
            "blood": int(m.get("blood", 10)), 
            "unlock_date": String(m.get("unlock_date", "")), 
        })

    return {
        "ok": true, 
        "capacity": cap, 
        "herd_count": defined_count, 
        "members": packed
    }

func create_member(character_name: String, index: int, member_name: String) -> Dictionary:
    if not GameManager.character_data_by_name.has(character_name):
        return {"ok": false, "error": "Character not found."}

    var cd: CharacterData = GameManager.character_data_by_name[character_name]
    var cap: int = _cap_for(int(cd.herd))
    if index < 0 or index >= cap:
        return {"ok": false, "error": "Invalid slot."}

    var data: Dictionary = _ensure_slots_for(character_name, cap)
    var members: Array = data["members"] as Array
    var n: String = member_name.strip_edges()
    if n.is_empty():
        return {"ok": false, "error": "Empty name."}

    var at_v: Variant = members[index]
    var at: Dictionary = (at_v as Dictionary) if (at_v is Dictionary) else {}



    if String(at.get("name", "")).strip_edges() != "":
        return {"ok": false, "error": "Slot is not empty."}

    at["name"] = n
    at["status"] = "Healthy"
    at["blood"] = 10
    at["unlock_date"] = ""
    members[index] = _slot(at)
    _save_raw(character_name, {"members": members})
    return get_state(character_name)





func feed(character_name: String, index: int, mode: String) -> Dictionary:
    if not GameManager.character_data_by_name.has(character_name):
        return {"ok": false, "error": "Character not found."}

    var cd: CharacterData = GameManager.character_data_by_name[character_name]
    var cap: int = _cap_for(int(cd.herd))
    if index < 0 or index >= cap:
        return {"ok": false, "error": "Invalid slot."}


    if int(cd.action_points_current) <= 0:
        return {"ok": false, "error": "Not enough Activity Points."}

    var data: Dictionary = _ensure_slots_for(character_name, cap)
    var members: Array = data["members"] as Array
    var m_v: Variant = members[index]
    if not (m_v is Dictionary):
        return {"ok": false, "error": "Malformed member slot."}
    var m: Dictionary = m_v as Dictionary

    var nm: String = String(m.get("name", "")).strip_edges()
    if nm == "":
        return {"ok": false, "error": "Empty slot."}

    var member_status_before: String = String(m.get("status", "Healthy"))
    if member_status_before == "Dead":
        return {"ok": false, "error": "This herd member is dead."}

    var member_blood_before: int = clamp(int(m.get("blood", 10)), 0, 10)

    var choice: String = String(mode).to_lower()
    var char_before: int = int(cd.blood_pool)
    var char_max: int = int(cd.blood_pool_max)

    var result: Dictionary = {
        "phase": "herd_feed_result", 
        "herd_member_index": index, 
        "herd_member_name": nm, 
        "herd_blood_before": member_blood_before, 
        "herd_blood_after": member_blood_before, 
        "herd_status_before": member_status_before, 
        "herd_status_after": member_status_before, 
        "choice": choice, 
        "forced_frenzy": false, 
        "frenzy_roll": {}, 
        "conscience_trigger": "", 
        "conscience_check": {}, 
        "path_before": int(cd.path), 
        "path_after": int(cd.path), 
        "path_lost": 0, 
        "blood_before": char_before, 
        "blood_after": char_before, 
        "blood_max": char_max, 
        "blood_gained": 0, 
        "victim_died": false, 
        "message": "", 
        "notes": [], 
        "unlock_date": "", 
    }




    if _hungry_for_frenzy(cd):
        result["forced_frenzy"] = true
        var ctrl_first: Dictionary = _roll_virtue_capped_by_path(cd, 6)
        result["frenzy_roll"] = ctrl_first

        if not bool(ctrl_first.get("passed", false)):
            var drained: int = 0
            var victim_bp: int = member_blood_before
            var regained: bool = false
            var last_check: Dictionary = ctrl_first

            while (cd.blood_pool < cd.blood_pool_max) and (drained < victim_bp) and ( not regained):
                cd.blood_pool += 1
                drained += 1
                last_check = _roll_virtue_capped_by_path(cd, 6)
                regained = bool(last_check.get("passed", false))

            result["frenzy_roll"] = last_check


            var died: bool = false
            if drained > 6:
                died = true
            elif drained >= 5:
                rand.randomize()
                died = (rand.randi() % 2) == 1

            result["victim_died"] = died

            var herd_after: int = max(0, member_blood_before - drained)
            var new_status: String = "Dead" if died else ("Recovering" if drained > 0 else member_status_before)


            m["blood"] = 0 if died else herd_after
            m["status"] = new_status
            if died:
                _lock_dead_slot(m)
                result["unlock_date"] = String(m.get("unlock_date", ""))
            members[index] = _slot(m)
            _save_raw(character_name, {"members": members})

            if GameManager.has_signal("character_updated"):
                GameManager.emit_signal("character_updated", cd.name)


            var cons_trigger: String = ""
            if died:
                var pn: String = String(cd.path_name)
                var pv: int = int(cd.path)
                if pn == "Humanity" and pv >= 6:
                    cons_trigger = "frenzy_death"
                elif pn == "Path of the Beast" and pv >= 4:
                    cons_trigger = "beast_death"
                elif pn == "Path of Cathari" and pv >= 5:
                    cons_trigger = "cathari_death"
                elif pn == "Path of Feral Heart" and pv >= 4:
                    cons_trigger = "feral_heart_death"
                elif pn == "Path of Honorable Accord" and pv >= 2:
                    cons_trigger = "honorable_accord_death"
                elif pn == "Path of Lilith" and pv >= 4:
                    cons_trigger = "lilith_death"
                elif pn == "Path of Night" and pv >= 4:
                    cons_trigger = "night_death"
                elif pn == "Path of the Scorched Heart" and pv == 5:
                    cons_trigger = "scorched_heart_death"
                elif pn == "Path of Redemption" and pv >= 2:
                    cons_trigger = "redemption_death"
            if cons_trigger == "" and String(cd.path_name) == "Path of Caine" and int(cd.path) >= 6:
                cons_trigger = "cainite_frenzy"

            if cons_trigger != "":
                var cons_block: Dictionary = _roll_conscience_capped_by_path(cd, 8)
                result["conscience_trigger"] = cons_trigger
                result["conscience_check"] = cons_block
                if not bool(cons_block.get("passed", false)):
                    var before_path: int = int(cd.path)
                    var after_path: int = max(0, before_path - 1)
                    cd.path = after_path
                    if GameManager.has_signal("character_updated"):
                        GameManager.emit_signal("character_updated", cd.name)
                    result["path_before"] = before_path
                    result["path_after"] = after_path
                    result["path_lost"] = before_path - after_path


            result["blood_after"] = int(cd.blood_pool)
            result["blood_gained"] = int(cd.blood_pool) - char_before
            result["herd_blood_after"] = int(m.get("blood", 0))
            result["herd_status_after"] = String(m.get("status", "Healthy"))
            result["message"] = (
                "Hunger frenzy erupts. You gorge until the herd member dies."
                if died
                else ("Hunger frenzy erupts. You regain control."
                    if int(cd.blood_pool) < cd.blood_pool_max
                    else "Hunger frenzy erupts. You gorge until fully sated.")
            )

            result["notes"].append("Hunger frenzy triggered.")
            if result["victim_died"]:
                result["notes"].append("Herd member died during frenzy.")
                if String(result["unlock_date"]) != "":
                    result["notes"].append("Replacement available on %s (in-game)." % String(result["unlock_date"]))
            else:
                result["notes"].append("You regained control while feeding.")
            result["notes"].append("Blood pool %d → %d / %d." % [char_before, int(cd.blood_pool), char_max])
            result["notes"].append("Herd %s: blood %d → %d / 10, status %s." %
                [nm, member_blood_before, int(m.get("blood", 0)), String(m.get("status", ""))])


            cd.action_points_current = max(0, int(cd.action_points_current) - 1)
            if GameManager.has_signal("character_updated"):
                GameManager.emit_signal("character_updated", cd.name)

            return {"ok": true, "state": get_state(character_name), "result": result}




    var requested: int = 3
    if choice == "risk":
        rand.randomize()
        requested = rand.randi_range(5, 6)
    elif choice == "gorge":
        requested = 10

    var capacity: int = max(0, char_max - char_before)
    var drain_from_member: int = min(requested, member_blood_before)
    var gained: int = min(drain_from_member, capacity)


    cd.blood_pool = char_before + gained
    if GameManager.has_signal("character_updated"):
        GameManager.emit_signal("character_updated", cd.name)


    var died2: bool = false
    if choice == "gorge":
        died2 = true
    else:
        if drain_from_member > 6:
            died2 = true
        elif drain_from_member >= 5:
            rand.randomize()
            died2 = (rand.randi() % 2) == 1


    var member_after: int = max(0, member_blood_before - drain_from_member)
    var status_after: String = "Dead" if died2 else ("Recovering" if drain_from_member > 0 else member_status_before)
    m["blood"] = 0 if died2 else member_after
    m["status"] = status_after
    if died2:
        _lock_dead_slot(m)
        result["unlock_date"] = String(m.get("unlock_date", ""))
    members[index] = _slot(m)
    _save_raw(character_name, {"members": members})


    var cons_trigger2: String = ""
    var pn2: String = String(cd.path_name)
    var pv2: int = int(cd.path)

    if pn2 == "Humanity":
        if pv2 == 3:
            if choice == "gorge":
                cons_trigger2 = "gorge"
        elif pv2 == 4 or pv2 == 5:
            if choice == "gorge":
                cons_trigger2 = "gorge"
            elif choice == "risk" and died2:
                cons_trigger2 = "risk_death"
        elif pv2 >= 6:
            if choice == "gorge":
                cons_trigger2 = "gorge"
            elif choice == "risk" and died2:
                cons_trigger2 = "risk_death"
    elif pn2 == "Path of the Beast":
        if died2 and pv2 >= 4:
            cons_trigger2 = "beast_death"
    elif pn2 == "Path of Cathari":
        if died2 and pv2 >= 5:
            cons_trigger2 = "cathari_death"
    elif pn2 == "Path of Feral Heart":
        if died2 and pv2 >= 4:
            cons_trigger2 = "feral_heart_death"
    elif pn2 == "Path of Honorable Accord":
        if died2 and pv2 >= 2:
            cons_trigger2 = "honorable_accord_death"
    elif pn2 == "Path of Lilith":
        if died2 and pv2 >= 4:
            cons_trigger2 = "lilith_death"
    elif pn2 == "Path of Night":
        if died2 and pv2 >= 4:
            cons_trigger2 = "night_death"
    elif pn2 == "Path of the Scorched Heart":
        if died2 and pv2 == 5:
            cons_trigger2 = "scorched_heart_death"
    elif pn2 == "Path of Redemption":
        if died2 and pv2 >= 2:
            cons_trigger2 = "redemption_death"

    if cons_trigger2 != "":
        var cons_block2: Dictionary = _roll_conscience_capped_by_path(cd, 8)
        result["conscience_trigger"] = cons_trigger2
        result["conscience_check"] = cons_block2
        if not bool(cons_block2.get("passed", false)):
            var before_path2: int = int(cd.path)
            var after_path2: int = max(0, before_path2 - 1)
            cd.path = after_path2
            if GameManager.has_signal("character_updated"):
                GameManager.emit_signal("character_updated", cd.name)
            result["path_before"] = before_path2
            result["path_after"] = after_path2
            result["path_lost"] = before_path2 - after_path2


    result["blood_after"] = int(cd.blood_pool)
    result["blood_gained"] = gained
    result["victim_died"] = died2
    result["herd_blood_after"] = int(m.get("blood", 0))
    result["herd_status_after"] = String(m.get("status", ""))

    if choice == "safe":
        result["message"] = "You feed cautiously and sate your hunger a little."
    elif choice == "risk":
        result["message"] = "You push your luck and take more than you should."
    else:
        result["message"] = "You drink deep until nothing remains to give."


    result["notes"].append("Feeding: %s • +%d BP (pool %d → %d / %d)." %
        [choice.to_upper(), gained, char_before, int(cd.blood_pool), char_max])
    result["notes"].append("Herd %s: drained %d • blood %d → %d / 10 • status %s." %
        [nm, min(drain_from_member, member_blood_before), member_blood_before, int(m.get("blood", 0)), String(m.get("status", ""))])
    if died2:
        result["notes"].append("Victim dies.")
        if String(result["unlock_date"]) != "":
            result["notes"].append("Replacement available on %s (in-game)." % String(result["unlock_date"]))
    if result["conscience_trigger"] != "":
        var cc: Dictionary = result["conscience_check"]
        var pass_txt: String = "passed" if bool(cc.get("passed", false)) else "failed"
        result["notes"].append("Degeneration (%s) %s. Pool %d @ diff %d, rolls %s." %
            [result["conscience_trigger"], pass_txt, int(cc.get("pool_used", 0)), int(cc.get("difficulty", 8)), str(cc.get("rolls", []))])
    if int(result.get("path_lost", 0)) > 0:
        result["notes"].append("Path drops %d → %d." % [int(result.get("path_before", 0)), int(result.get("path_after", 0))])


    cd.action_points_current = max(0, int(cd.action_points_current) - 1)
    if GameManager.has_signal("character_updated"):
        GameManager.emit_signal("character_updated", cd.name)

    return {"ok": true, "state": get_state(character_name), "result": result}


func _on_day_changed(_date_str: String) -> void :
    _increment_all_herd_files_by_one()
    _unlock_all_expired_dead_slots()

func _unlock_all_expired_dead_slots() -> void :
    var d: = DirAccess.open(HERD_DIR)
    if d == null:
        return
    d.list_dir_begin()
    while true:
        var fn: String = d.get_next()
        if fn == "":
            break
        if d.current_is_dir() or not fn.ends_with(".txt"):
            continue
        var character_name: String = fn.substr(0, fn.length() - 4)
        _try_unlock_expired_slots_for(character_name)
    d.list_dir_end()

func _increment_all_herd_files_by_one() -> void :
    var d: DirAccess = DirAccess.open(HERD_DIR)
    if d == null:
        return

    d.list_dir_begin()
    while true:
        var fn: String = d.get_next()
        if fn == "":
            break
        if d.current_is_dir():
            continue
        if not fn.ends_with(".txt"):
            continue

        var character_name: String = fn.substr(0, fn.length() - 4)
        var data: Dictionary = _load_raw(character_name)

        var members_any: Variant = data.get("members", [])
        var members: Array = []
        if members_any is Array:
            members = members_any as Array

        for i in range(members.size()):
            var m_v: Variant = members[i]
            if not (m_v is Dictionary):
                continue
            var m: Dictionary = m_v as Dictionary
            var nm: String = String(m.get("name", "")).strip_edges()
            var status: String = String(m.get("status", "Healthy"))


            if nm != "" and status != "Dead":
                var b: int = int(m.get("blood", 10))
                var b2: int = min(b + 1, 10)
                m["blood"] = b2
                if status == "Recovering" and b2 >= 10:
                    m["status"] = "Healthy"

            members[i] = m

        data["members"] = members
        _save_raw(character_name, data)
    d.list_dir_end()
