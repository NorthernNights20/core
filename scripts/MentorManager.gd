
extends Node


const CHAT_DIVIDER: String = "[color=gray]────────────────────[/color]\n"


const SAVE_DIR: String = "user://mentor_sessions/"








var sessions_by_teacher: Dictionary = {}

func _ready() -> void :
    DirAccess.make_dir_recursive_absolute(SAVE_DIR)
    _load_sessions_from_disk()
    if CalendarManager.has_signal("day_changed"):
        CalendarManager.connect("day_changed", Callable(self, "_on_ic_day_changed"))





func get_eligible_targets(teacher_name: String) -> Array[String]:
    var gm: Node = get_node_or_null("/root/GameManager")
    var grp: Node = get_node_or_null("/root/GroupManager")
    var net: Node = get_node_or_null("/root/NetworkManager")
    if gm == null or grp == null:
        return []

    var group_name: String = String(grp.call("get_group_of", teacher_name))
    if group_name == "":
        return []

    var teacher_cd: CharacterData = gm.character_data_by_name.get(teacher_name, null) as CharacterData
    if teacher_cd == null:
        return []


    var primed: Dictionary = sessions_by_teacher.get(teacher_name, {}) as Dictionary
    var force_student: String = ""
    if not primed.is_empty():
        var primed_date: String = String(primed.get("ic_date", ""))
        var today: String = CalendarManager.get_current_date_string()
        if primed_date == today and String(primed.get("stage", "")) == "primed":
            force_student = String(primed.get("student", ""))
        else:

            sessions_by_teacher.erase(teacher_name)
            _delete_session_file(teacher_name)

    var out: Array[String] = []
    var members_v: Variant = grp.call("get_group_members", group_name)
    var members: Array[String] = []
    if members_v is Array:
        for m in (members_v as Array):
            members.append(String(m))

    for candidate in members:
        if candidate == teacher_name:
            continue
        if force_student != "" and candidate != force_student:
            continue

        var cd: CharacterData = gm.character_data_by_name.get(candidate, null) as CharacterData
        if cd == null:
            continue


        if String(cd.current_zone) != String(teacher_cd.current_zone):
            continue


        var na_ok: bool = true
        if net != null and net.has_method("is_na_panel_open_for"):
            na_ok = bool(net.call("is_na_panel_open_for", candidate))
        if not na_ok:
            continue

        out.append(candidate)

    return out


func get_teachable_disciplines(teacher_name: String, student_name: String) -> Array[String]:
    var out: Array[String] = []

    var t: CharacterData = GameManager.character_data_by_name.get(teacher_name, null) as CharacterData
    var s: CharacterData = GameManager.character_data_by_name.get(student_name, null) as CharacterData
    if t == null or s == null:
        return out

    var dm: Script = DisciplineManager.get_script()

    for d_key: Variant in t.disciplines.keys():
        var dname: String = String(d_key)


        if dname == "Thaumaturgy" or dname == "Necromancy":
            continue

        var t_rating: int = int(t.disciplines.get(dname, 0))
        if t_rating <= 0:
            continue

        var s_rating: int = int(s.disciplines.get(dname, 0))
        var s_prog: int = int(s.discipline_progress.get(dname, 0))
        if s_rating == 0 and s_prog == 0:
            out.append(dname)


    var path_labels: Dictionary = {}
    for entry in t.thaumaturgy_paths:
        var parts: PackedStringArray = String(entry).split(":", false, 1)
        var raw_name: String = parts[0].strip_edges()
        var path_label: String = String(dm.canon_thaum_path(raw_name))
        path_labels[path_label.to_lower()] = path_label
    for key in t.thaumaturgy_path_progress.keys():
        var path_label: String = String(dm.canon_thaum_path(String(key)))
        path_labels[path_label.to_lower()] = path_label

    for path_label in path_labels.values():
        var t_path_rating: int = int(dm.get_thaum_path_rating(t, path_label))
        var t_path_prog: int = int(dm.get_thaum_path_progress(t, path_label))
        if t_path_rating <= 0 and t_path_prog <= 0:
            continue
        var s_path_rating: int = int(dm.get_thaum_path_rating(s, path_label))
        var s_path_prog: int = int(dm.get_thaum_path_progress(s, path_label))
        if s_path_rating == 0 and s_path_prog == 0:
            out.append(path_label)


    var necro_path_labels: Dictionary = {}
    for entry in t.necromancy_paths:
        var necro_parts: PackedStringArray = String(entry).split(":", false, 1)
        var necro_raw_name: String = necro_parts[0].strip_edges()
        var necro_label: String = String(dm.canon_necromancy_path(necro_raw_name))
        necro_path_labels[necro_label.to_lower()] = necro_label
    for key in t.necromancy_path_progress.keys():
        var necro_label: String = String(dm.canon_necromancy_path(String(key)))
        necro_path_labels[necro_label.to_lower()] = necro_label

    for necro_label in necro_path_labels.values():
        var t_necro_rating: int = int(dm.get_necromancy_path_rating(t, necro_label))
        var t_necro_prog: int = int(dm.get_necromancy_path_progress(t, necro_label))
        if t_necro_rating <= 0 and t_necro_prog <= 0:
            continue

        var s_necro_rating: int = int(dm.get_necromancy_path_rating(s, necro_label))
        var s_necro_prog: int = int(dm.get_necromancy_path_progress(s, necro_label))
        if s_necro_rating == 0 and s_necro_prog == 0:
            out.append(necro_label)

    out.sort_custom( func(a, b): return String(a) < String(b))
    return out

func get_teaching_options(teacher_name: String, student_name: String, subject: String) -> Dictionary:
    var t: CharacterData = GameManager.character_data_by_name.get(teacher_name, null) as CharacterData
    var s: CharacterData = GameManager.character_data_by_name.get(student_name, null) as CharacterData
    if t == null or s == null:
        return {"options": []}

    var options: Array[Dictionary] = []
    var auto_select: = false
    var auto_value: = ""
    var auto_label: = ""

    var subject_key: String = subject.strip_edges().to_lower()
    match subject_key:
        "ability":
            for ability in NightlyActivitiesManager.ABILITIES:
                var ability_key: String = String(ability)
                var rating: int = int(t.get(ability_key))
                if rating <= 0:
                    continue
                options.append({
                    "label": _title_case(ability_key.replace("_", " ")), 
                    "value": ability_key
                })
        "discipline":
            var dm: Script = DisciplineManager.get_script()
            for d_key in t.disciplines.keys():
                var dname: String = String(d_key)
                var rating2: int = int(t.disciplines.get(dname, 0))
                if rating2 <= 0:
                    continue
                if dname == String(dm.THAUMATURGY) or dname == String(dm.NECROMANCY):
                    continue
                options.append({"label": dname, "value": dname})

            for entry in t.thaumaturgy_paths:
                var parts: PackedStringArray = String(entry).split(":", false, 1)
                var raw_name: String = parts[0].strip_edges()
                var canon: String = String(dm.canon_thaum_path(raw_name))
                if int(dm.get_thaum_path_rating(t, canon)) <= 0:
                    continue
                options.append({"label": canon, "value": canon})

            for entry2 in t.necromancy_paths:
                var n_parts: PackedStringArray = String(entry2).split(":", false, 1)
                var n_raw: String = n_parts[0].strip_edges()
                var n_canon: String = String(dm.canon_necromancy_path(n_raw))
                if int(dm.get_necromancy_path_rating(t, n_canon)) <= 0:
                    continue
                options.append({"label": n_canon, "value": n_canon})

        "path":
            var t_path_name: String = String(t.path_name).strip_edges()
            var s_path_name: String = String(s.path_name).strip_edges()
            var label: String = _format_path_label(t_path_name)
            if t_path_name != "" and s_path_name != "" and t_path_name.to_lower() == s_path_name.to_lower():
                auto_select = true
                auto_value = "path"
                auto_label = label
            else:
                options.append({"label": label, "value": "path"})

    options.sort_custom( func(a: Dictionary, b: Dictionary) -> bool:
        return String(a.get("label", "")).to_lower() < String(b.get("label", "")).to_lower()
    )

    return {
        "options": options, 
        "auto_select": auto_select, 
        "auto_value": auto_value, 
        "auto_label": auto_label
    }




func accept_teach_invite(teacher_name: String, student_name: String, discipline: String) -> Dictionary:
    var t: CharacterData = GameManager.character_data_by_name.get(teacher_name, null) as CharacterData
    var s: CharacterData = GameManager.character_data_by_name.get(student_name, null) as CharacterData
    if t == null or s == null:
        return {"ok": false, "code": "no_char"}

    var dm: Script = DisciplineManager.get_script()
    var is_thaum_path: bool = int(dm.get_thaum_path_rating(t, discipline)) > 0 or int(dm.get_thaum_path_progress(t, discipline)) > 0
    var is_necro_path: bool = int(dm.get_necromancy_path_rating(t, discipline)) > 0 or int(dm.get_necromancy_path_progress(t, discipline)) > 0
    if is_thaum_path:
        discipline = String(dm.canon_thaum_path(discipline))
    elif is_necro_path:
        discipline = String(dm.canon_necromancy_path(discipline))


    var t_group: String = String(GroupManager.get_group_of(teacher_name))
    var s_group: String = String(GroupManager.get_group_of(student_name))
    if t_group == "" or t_group != s_group:
        return {"ok": false, "code": "not_same_group"}
    if String(t.current_zone) != String(s.current_zone):
        return {"ok": false, "code": "not_same_zone"}


    if is_thaum_path:
        if int(dm.get_thaum_path_rating(t, discipline)) <= 0:
            return {"ok": false, "code": "teacher_lacks_discipline"}
        if int(dm.get_thaum_path_rating(s, discipline)) > 0 or int(dm.get_thaum_path_progress(s, discipline)) > 0:
            return {"ok": false, "code": "student_already_started"}
    elif is_necro_path:
        if int(dm.get_necromancy_path_rating(t, discipline)) <= 0:
            return {"ok": false, "code": "teacher_lacks_discipline"}
        if int(dm.get_necromancy_path_rating(s, discipline)) > 0 or int(dm.get_necromancy_path_progress(s, discipline)) > 0:
            return {"ok": false, "code": "student_already_started"}
    else:
        if int(t.disciplines.get(discipline, 0)) <= 0:
            return {"ok": false, "code": "teacher_lacks_discipline"}
        if int(s.disciplines.get(discipline, 0)) > 0 or int(s.discipline_progress.get(discipline, 0)) > 0:
            return {"ok": false, "code": "student_already_started"}

    var date_str: String = CalendarManager.get_current_date_string()
    var is_late: bool = CalendarManager.is_second_half

    var existing: Dictionary = sessions_by_teacher.get(teacher_name, {}) as Dictionary




    if existing.is_empty():
        if is_late:
            return {"ok": false, "code": "It it too late for a class."}


        if (t.action_points_current != t.action_points_max) or (s.action_points_current != s.action_points_max) or (t.action_points_max <= 0) or (s.action_points_max <= 0):
            return {"ok": false, "code": "Both of you need to be at your peak."}


        if int(t.blood_pool) <= 0:
            return {"ok": false, "code": "The mentor is lacking the blood."}
        if int(s.blood_pool) >= int(s.blood_pool_max):
            return {"ok": false, "code": "The student cannot take the blood."}


        if _has_active_session_for(teacher_name) or _student_is_primed(student_name):
            return {"ok": false, "code": "The mentor is already teaching someone else."}


        _spend_all_ap(t)
        _spend_all_ap(s)


        t.blood_pool = max(0, int(t.blood_pool) - 1)
        s.blood_pool = min(int(s.blood_pool_max), int(s.blood_pool) + 1)


        _apply_blood_bond_point(teacher_name, student_name)


        var sess: Dictionary = {
            "teacher": teacher_name, 
            "student": student_name, 
            "discipline": discipline, 
            "ic_date": date_str, 
            "stage": "primed"
        }
        sessions_by_teacher[teacher_name] = sess
        _save_session_to_disk(teacher_name, sess)

        _refresh_na_for([t, s])
        _send_dual_messages(
            t.name, s.name, 
            "[b]Teaching started[/b]: %s begins instructing %s in [b]%s[/b]." % [t.name, s.name, discipline], 
            "Step 1 complete. Meet again [b]later this IC night (Late)[/b] to finish."
        )
        return {"ok": true, "code": "started"}




    var sess2: Dictionary = existing
    var sess_student: String = String(sess2.get("student", ""))
    var sess_disc: String = String(sess2.get("discipline", ""))
    if sess_student != student_name or sess_disc != discipline:
        return {"ok": false, "code": "mismatch_session"}

    if not is_late:
        return {"ok": false, "code": "must_finish_in_late"}

    var started_str: String = String(sess2.get("ic_date", ""))
    if started_str == "":
        return {"ok": false, "code": "invalid_session"}


    if date_str != started_str:
        return {"ok": false, "code": "wrong_ic_date"}


    if (t.action_points_current != t.action_points_max) or (s.action_points_current != s.action_points_max) or (t.action_points_max <= 0) or (s.action_points_max <= 0):
        return {"ok": false, "code": "both_need_full_ap"}


    _spend_all_ap(t)
    _spend_all_ap(s)


    if is_thaum_path:
        dm.progress_thaum_path_with_increment(s, discipline, 100)
    elif is_necro_path:
        dm.progress_necromancy_path_with_increment(s, discipline, 100)
    else:
        var cur_prog: int = int(s.discipline_progress.get(discipline, 0))
        s.discipline_progress[discipline] = min(9999, cur_prog + 100)


    sessions_by_teacher.erase(teacher_name)
    _delete_session_file(teacher_name)

    _refresh_na_for([t, s])
    _push_student_discipline_refresh(s)

    _send_dual_messages(
        t.name, s.name, 
        "[b]Teaching finished[/b]: %s completes a lesson in [b]%s[/b] with %s." % [t.name, discipline, s.name], 
        "%s gains [b]+1%%[/b] progress in [b]%s[/b]." % [s.name, discipline]
    )
    return {"ok": true, "code": "finished"}

func accept_training_invite(teacher_name: String, student_name: String, subject: String, topic_value: String, topic_label: String) -> Dictionary:
    var t: CharacterData = GameManager.character_data_by_name.get(teacher_name, null) as CharacterData
    var s: CharacterData = GameManager.character_data_by_name.get(student_name, null) as CharacterData
    if t == null or s == null:
        return {"ok": false, "code": "no_char"}


    var t_group: String = String(GroupManager.get_group_of(teacher_name))
    var s_group: String = String(GroupManager.get_group_of(student_name))
    if t_group == "" or t_group != s_group:
        return {"ok": false, "code": "not_same_group"}
    if String(t.current_zone) != String(s.current_zone):
        return {"ok": false, "code": "not_same_zone"}


    if t.action_points_current <= 0 or s.action_points_current <= 0:
        return {"ok": false, "code": "not_enough_ap"}

    var subject_key: String = subject.strip_edges().to_lower()
    var resolved: Dictionary = _resolve_training_topic(t, s, subject_key, topic_value, topic_label)
    if not bool(resolved.get("ok", false)):
        return {"ok": false, "code": String(resolved.get("code", "invalid_topic"))}

    var teacher_rating: int = int(resolved.get("teacher_rating", 0))
    var student_rating: int = int(resolved.get("student_rating", 0))
    var diff: int = teacher_rating - student_rating

    _spend_one_ap(t)
    _spend_one_ap(s)

    var base_inc_student: int = int(resolved.get("base_increment", 0))
    var bonus_mult: float = 1.0 + (float(diff) * 0.1)
    var student_inc: int = max(1, int(ceil(float(base_inc_student) * bonus_mult)))

    var base_inc_mentor: int = _compute_base_increment_for_character(t, resolved, subject_key)
    var penalty_mult: float = max(0.0, 1.0 - (0.2 * float(abs(diff))))
    var mentor_inc: int = max(0, int(ceil(float(base_inc_mentor) * penalty_mult)))
    var mentor_apply_res: Dictionary = _apply_training_progress(t, resolved, mentor_inc)

    if diff <= 0:
        var name_label: String = String(resolved.get("label", ""))
        if name_label == "":
            name_label = "this topic"
        var mentor_detail: = _format_mentor_progress_detail(mentor_apply_res, name_label, t.name)
        _send_dual_messages(
            t.name, 
            s.name, 
            "[b]Teaching attempt[/b]: %s tries to instruct %s in [b]%s[/b]." % [t.name, s.name, name_label], 
            "[i]You learned nothing.[/i]%s" % mentor_detail
        )
        _refresh_na_for([t, s])
        _push_training_refresh(t, subject_key, resolved)
        _persist_characters([t, s])
        return {"ok": true, "code": "no_learning"}

    var apply_res: Dictionary = _apply_training_progress(s, resolved, student_inc)
    var name_label2: String = String(resolved.get("label", ""))
    var msg: String = "[b]Teaching finished[/b]: %s mentors %s in [b]%s[/b]." % [t.name, s.name, name_label2]
    var detail: String = "%s gains [b]+%d[/b] progress." % [s.name, int(apply_res.get("increment", student_inc))]
    detail += _format_mentor_progress_detail(mentor_apply_res, name_label2, t.name)

    if bool(apply_res.get("leveled_up", false)):
        detail += "\n[b]%s[/b] increases to %d." % [name_label2, int(apply_res.get("rating_after", student_rating))]

    _send_dual_messages(t.name, s.name, msg, detail)
    _refresh_na_for([t, s])
    _push_training_refresh(s, subject_key, resolved)
    _push_training_refresh(t, subject_key, resolved)
    _persist_characters([t, s])
    return {"ok": true, "code": "finished"}


func has_primed_session(teacher_name: String) -> bool:
    var d: Dictionary = sessions_by_teacher.get(teacher_name, {}) as Dictionary
    return not d.is_empty()





func _teacher_path(teacher_name: String) -> String:
    return SAVE_DIR + _sanitize_filename(teacher_name) + ".txt"

func _sanitize_filename(s: String) -> String:
    var out: String = s
    var bad: Array[String] = ["/", "\\", ":", "*", "?", "\"", "<", ">", "|"]
    for ch: String in bad:
        out = out.replace(ch, "_")
    return out

func _save_session_to_disk(teacher_name: String, sess: Dictionary) -> void :
    var path: String = _teacher_path(teacher_name)
    var f: FileAccess = FileAccess.open(path, FileAccess.WRITE)
    if f == null:
        push_error("Failed to open mentor session file for write: " + path)
        return
    var json_text: String = JSON.stringify(sess)
    f.store_string(json_text)
    f.close()

func _delete_session_file(teacher_name: String) -> void :
    var path: String = _teacher_path(teacher_name)
    if FileAccess.file_exists(path):
        DirAccess.remove_absolute(path)

func _load_sessions_from_disk() -> void :
    var dir: DirAccess = DirAccess.open(SAVE_DIR)
    if dir == null:
        return
    dir.list_dir_begin()
    while true:
        var fname: String = dir.get_next()
        if fname == "":
            break
        if dir.current_is_dir():
            continue
        if not fname.ends_with(".txt"):
            continue
        if fname.begins_with("."):
            continue

        var path: String = SAVE_DIR + fname
        var f: FileAccess = FileAccess.open(path, FileAccess.READ)
        if f == null:
            continue
        var content: String = f.get_as_text()
        f.close()

        var parsed_v: Variant = JSON.parse_string(content)
        if typeof(parsed_v) == TYPE_DICTIONARY:
            var sess: Dictionary = parsed_v as Dictionary
            var teacher: String = String(sess.get("teacher", ""))
            var student: String = String(sess.get("student", ""))
            var disc: String = String(sess.get("discipline", ""))
            var icd: String = String(sess.get("ic_date", ""))
            var stg: String = String(sess.get("stage", ""))
            if teacher != "" and student != "" and disc != "" and icd != "" and stg == "primed":
                sessions_by_teacher[teacher] = sess
            else:
                DirAccess.remove_absolute(path)


    var current_date: String = CalendarManager.get_current_date_string()
    _on_ic_day_changed(current_date)





func _apply_blood_bond_point(source_name: String, target_name: String) -> void :

    var bbm: BloodBondManager = get_node_or_null("/root/BloodBondManager") as BloodBondManager
    if bbm == null:
        bbm = BloodBondManager.new()
        add_child(bbm)

    var _res: Dictionary = bbm.force_blood_bond_point(source_name, target_name)


    var target_cd: CharacterData = GameManager.character_data_by_name.get(target_name, null) as CharacterData
    if target_cd != null:
        var bonds: Dictionary = (target_cd.blood_bonds as Dictionary).duplicate(true)
        var target_pid: int = int(GameManager.name_to_peer.get(target_name, -1))
        if target_pid != -1:
            NetworkManager.rpc_id(target_pid, "receive_blood_bond_data", target_name, bonds)


func _has_active_session_for(teacher_name: String) -> bool:
    var sess: Dictionary = sessions_by_teacher.get(teacher_name, {}) as Dictionary
    return not sess.is_empty()


func _student_is_primed(student_name: String) -> bool:
    for k_v: Variant in sessions_by_teacher.keys():
        var k: String = String(k_v)
        var sess: Dictionary = sessions_by_teacher.get(k, {}) as Dictionary
        if sess.is_empty():
            continue
        if String(sess.get("student", "")) == student_name:
            return true
    return false

func _spend_all_ap(cd: CharacterData) -> void :
    cd.action_points_current = 0

func _spend_one_ap(cd: CharacterData) -> void :
    cd.action_points_current = max(0, int(cd.action_points_current) - 1)

func _send_message(to_name: String, body: String) -> void :
    var pid: int = int(GameManager.name_to_peer.get(to_name, -1))
    if pid == -1:
        return
    var packet: Dictionary = {
        "message": CHAT_DIVIDER + body, 
        "speaker": "Nightly Activities", 
        "jingle": true
    }
    NetworkManager.rpc_id(pid, "receive_message", packet)

func _send_dual_messages(a: String, b: String, line1: String, line2: String) -> void :
    _send_message(a, "%s\n%s" % [line1, line2])
    _send_message(b, "%s\n%s" % [line1, line2])

func _refresh_na_for(arr: Array) -> void :
    for cd_v: Variant in arr:
        var cd: CharacterData = cd_v as CharacterData
        if cd == null:
            continue
        var pid: int = int(GameManager.name_to_peer.get(cd.name, -1))
        if pid == -1:
            continue
        var update_data: Dictionary = {
            "zone": cd.current_zone, 
            "ap_current": cd.action_points_current, 
            "ap_max": cd.action_points_max, 
            "blood_current": cd.blood_pool, 
            "blood_max": cd.blood_pool_max, 
            "wp_current": cd.willpower_current, 
            "wp_max": cd.willpower_max
        }
        NetworkManager.rpc_id(pid, "receive_nightly_activities_data", update_data)

func _push_student_discipline_refresh(student: CharacterData) -> void :
    if student == null:
        return
    var pid: int = int(GameManager.name_to_peer.get(student.name, -1))
    if pid == -1:
        return

    var nam: Node = get_node_or_null("/root/NightlyActivitiesManager")
    if nam != null and nam.has_method("_build_discipline_upgrade_payload"):
        var payload: Dictionary = nam.call("_build_discipline_upgrade_payload", student)
        NetworkManager.rpc_id(pid, "receive_discipline_upgrade_data", payload)
    else:

        NetworkManager.rpc_id(pid, "receive_discipline_upgrade_data", student.serialize_to_dict())

func _push_training_refresh(character: CharacterData, subject_key: String, resolved: Dictionary) -> void :
    if character == null:
        return
    var pid: int = int(GameManager.name_to_peer.get(character.name, -1))
    if pid == -1:
        return

    match subject_key:
        "ability":
            NetworkManager.rpc_id(pid, "receive_ability_upgrade_data", character.serialize_to_dict())
        "path":
            NetworkManager.rpc_id(pid, "receive_virtue_upgrade_data", character.serialize_to_dict())
        "discipline":
            var dm: Script = DisciplineManager.get_script()
            var is_thaum: bool = bool(resolved.get("is_thaum_path", false))
            var is_necro: bool = bool(resolved.get("is_necro_path", false))
            if is_thaum:
                var path_payload: Array[Dictionary] = dm.build_thaum_path_payload(character)
                NetworkManager.rpc_id(pid, "receive_thaumaturgy_paths_data", path_payload)
                var disc_payload: Dictionary = NetworkManager._build_discipline_upgrade_payload(character)
                NetworkManager.rpc_id(pid, "receive_discipline_upgrade_data", disc_payload)
            elif is_necro:
                var necro_payload: Array[Dictionary] = dm.build_necromancy_path_payload(character)
                NetworkManager.rpc_id(pid, "receive_necromancy_paths_data", necro_payload)
                var disc_payload2: Dictionary = NetworkManager._build_discipline_upgrade_payload(character)
                NetworkManager.rpc_id(pid, "receive_discipline_upgrade_data", disc_payload2)
            else:
                var disc_payload3: Dictionary = NetworkManager._build_discipline_upgrade_payload(character)
                NetworkManager.rpc_id(pid, "receive_discipline_upgrade_data", disc_payload3)

func _resolve_training_topic(t: CharacterData, s: CharacterData, subject_key: String, topic_value: String, topic_label: String) -> Dictionary:
    var label: String = topic_label
    if label == "":
        label = topic_value

    match subject_key:
        "ability":
            var ability_key: String = topic_value.to_lower()
            if not NightlyActivitiesManager.ABILITIES.has(ability_key):
                return {"ok": false, "code": "invalid_ability"}
            var t_rating: int = int(t.get(ability_key))
            var s_rating: int = int(s.get(ability_key))
            if t_rating <= 0:
                return {"ok": false, "code": "teacher_lacks_ability"}
            var base_inc: int = _compute_base_increment_for_rating(s_rating)
            return {
                "ok": true, 
                "subject": "ability", 
                "key": ability_key, 
                "label": label if label != "" else _title_case(ability_key.replace("_", " ")), 
                "teacher_rating": t_rating, 
                "student_rating": s_rating, 
                "base_increment": base_inc
            }

        "discipline":
            var dm: Script = DisciplineManager.get_script()
            var is_thaum_path: bool = int(dm.get_thaum_path_rating(t, topic_value)) > 0
            var is_necro_path: bool = int(dm.get_necromancy_path_rating(t, topic_value)) > 0
            if is_thaum_path:
                var t_path_rating: int = int(dm.get_thaum_path_rating(t, topic_value))
                var s_path_rating: int = int(dm.get_thaum_path_rating(s, topic_value))
                var base_inc2: int = int(dm.compute_thaum_path_increment(s, topic_value))
                return {
                    "ok": true, 
                    "subject": "discipline", 
                    "key": String(dm.canon_thaum_path(topic_value)), 
                    "label": label, 
                    "teacher_rating": t_path_rating, 
                    "student_rating": s_path_rating, 
                    "base_increment": base_inc2, 
                    "is_thaum_path": true
                }
            if is_necro_path:
                var t_necro_rating: int = int(dm.get_necromancy_path_rating(t, topic_value))
                var s_necro_rating: int = int(dm.get_necromancy_path_rating(s, topic_value))
                var base_inc3: int = int(dm.compute_necromancy_path_increment(s, topic_value))
                return {
                    "ok": true, 
                    "subject": "discipline", 
                    "key": String(dm.canon_necromancy_path(topic_value)), 
                    "label": label, 
                    "teacher_rating": t_necro_rating, 
                    "student_rating": s_necro_rating, 
                    "base_increment": base_inc3, 
                    "is_necro_path": true
                }

            var disc_key: String = String(topic_value)
            var t_disc: int = int(t.disciplines.get(disc_key, 0))
            if t_disc <= 0:
                return {"ok": false, "code": "teacher_lacks_discipline"}
            var s_disc: int = int(s.disciplines.get(disc_key, 0))
            var base_inc4: int = _compute_base_increment_for_discipline(s, disc_key)
            return {
                "ok": true, 
                "subject": "discipline", 
                "key": disc_key, 
                "label": label, 
                "teacher_rating": t_disc, 
                "student_rating": s_disc, 
                "base_increment": base_inc4
            }

        "path":
            var t_path: int = int(t.path)
            var s_path: int = int(s.path)
            var t_path_name: String = String(t.path_name).strip_edges()
            var s_path_name: String = String(s.path_name).strip_edges()
            if t_path_name == "" or s_path_name == "" or t_path_name.to_lower() != s_path_name.to_lower():
                return {"ok": false, "code": "path_mismatch"}
            var base_inc5: int = _compute_base_increment_for_path(s_path)
            var path_label: String = _format_path_label(s_path_name)
            return {
                "ok": true, 
                "subject": "path", 
                "key": "path", 
                "label": path_label, 
                "teacher_rating": t_path, 
                "student_rating": s_path, 
                "base_increment": base_inc5
            }

    return {"ok": false, "code": "unknown_subject"}

func _apply_training_progress(student: CharacterData, resolved: Dictionary, increment: int) -> Dictionary:
    var subject_key: String = String(resolved.get("subject", ""))
    var key: String = String(resolved.get("key", ""))
    var rating_before: int = _get_training_rating(student, resolved, subject_key, key)
    var leveled_up: = false
    var rating_after: = rating_before
    var progress_after: = 0

    match subject_key:
        "ability":
            var prog_name: String = "%s_progress" % key
            var cur_prog: int = int(student.get(prog_name))
            var new_prog: int = cur_prog + increment
            while new_prog >= 10000:
                new_prog -= 10000
                rating_after += 1
                leveled_up = true
            student.set(prog_name, new_prog)
            student.set(key, rating_after)
            progress_after = new_prog

        "path":
            var cur_prog2: int = int(student.path_progress)
            var new_prog2: int = cur_prog2 + increment
            while new_prog2 >= 10000:
                new_prog2 -= 10000
                rating_after += 1
                leveled_up = true
            if rating_after > 10:
                rating_after = 10
                new_prog2 = min(new_prog2, 9999)
            student.path_progress = new_prog2
            student.path = rating_after
            progress_after = new_prog2

        "discipline":
            var is_thaum: bool = bool(resolved.get("is_thaum_path", false))
            var is_necro: bool = bool(resolved.get("is_necro_path", false))
            if is_thaum:
                var dm: Script = DisciplineManager.get_script()
                var res_t: Dictionary = dm.progress_thaum_path_with_increment(student, key, increment)
                rating_after = int(res_t.get("rating_after", rating_before))
                progress_after = int(res_t.get("progress_after", 0))
                leveled_up = rating_after > rating_before
            elif is_necro:
                var dm2: Script = DisciplineManager.get_script()
                var res_n: Dictionary = dm2.progress_necromancy_path_with_increment(student, key, increment)
                rating_after = int(res_n.get("rating_after", rating_before))
                progress_after = int(res_n.get("progress_after", 0))
                leveled_up = rating_after > rating_before
            else:
                var cur_prog3: int = int(student.discipline_progress.get(key, 0))
                var new_prog3: int = cur_prog3 + increment
                while new_prog3 >= 10000:
                    new_prog3 -= 10000
                    rating_after += 1
                    leveled_up = true
                student.discipline_progress[key] = new_prog3
                student.disciplines[key] = rating_after
                progress_after = new_prog3

    return {
        "increment": increment, 
        "rating_after": rating_after, 
        "progress_after": progress_after, 
        "leveled_up": leveled_up
    }

func _get_training_rating(character: CharacterData, resolved: Dictionary, subject_key: String, key: String) -> int:
    match subject_key:
        "ability":
            return int(character.get(key))
        "path":
            return int(character.path)
        "discipline":
            var dm: Script = DisciplineManager.get_script()
            if bool(resolved.get("is_thaum_path", false)):
                return int(dm.get_thaum_path_rating(character, key))
            if bool(resolved.get("is_necro_path", false)):
                return int(dm.get_necromancy_path_rating(character, key))
            return int(character.disciplines.get(key, 0))
    return 0

func _compute_base_increment_for_rating(rating: int) -> int:
    var idx: int = clamp(rating, 0, 4)
    return int(NightlyActivitiesManager.BASE_INCREMENTS[idx])

func _compute_base_increment_for_character(character: CharacterData, resolved: Dictionary, subject_key: String) -> int:
    match subject_key:
        "ability":
            var rating: int = int(character.get(String(resolved.get("key", ""))))
            return _compute_base_increment_for_rating(rating)
        "path":
            return _compute_base_increment_for_path(int(character.path))
        "discipline":
            var disc_key: String = String(resolved.get("key", ""))
            var is_thaum: bool = bool(resolved.get("is_thaum_path", false))
            var is_necro: bool = bool(resolved.get("is_necro_path", false))
            var dm: Script = DisciplineManager.get_script()
            if is_thaum:
                return int(dm.compute_thaum_path_increment(character, disc_key))
            if is_necro:
                return int(dm.compute_necromancy_path_increment(character, disc_key))
            return _compute_base_increment_for_discipline_for_character(character, disc_key)
    return 0

func _compute_base_increment_for_discipline(student: CharacterData, disc_key: String) -> int:
    var idx: int = clamp(int(student.disciplines.get(disc_key, 0)), 0, 4)
    var base_inc: int = int(NightlyActivitiesManager.BASE_INCREMENTS[idx])
    var mult: float = NightlyActivitiesManager._discipline_progress_multiplier(student, disc_key)
    return max(1, int(ceil(float(base_inc) * mult)))

func _compute_base_increment_for_discipline_for_character(character: CharacterData, disc_key: String) -> int:
    var idx: int = clamp(int(character.disciplines.get(disc_key, 0)), 0, 4)
    var base_inc: int = int(NightlyActivitiesManager.BASE_INCREMENTS[idx])
    var mult: float = NightlyActivitiesManager._discipline_progress_multiplier(character, disc_key)
    return max(1, int(ceil(float(base_inc) * mult)))

func _compute_base_increment_for_path(rating: int) -> int:
    var tier: int = clamp(int(rating / 2), 0, 4)
    return int(NightlyActivitiesManager.BASE_INCREMENTS[tier]) * 2

func _format_path_label(path_name: String) -> String:
    if path_name == "":
        return "Path"
    return "Path of %s" % path_name

func _title_case(s: String) -> String:
    var parts: = s.split(" ", false)
    for i in parts.size():
        if parts[i].length() > 0:
            parts[i] = parts[i][0].to_upper() + parts[i].substr(1)
    return " ".join(parts)

func _format_mentor_progress_detail(mentor_apply_res: Dictionary, label: String, mentor_name: String) -> String:
    var inc_val: int = int(mentor_apply_res.get("increment", 0))
    if inc_val <= 0:
        return ""
    var out: = "\n%s gains [b]+%d[/b] progress in [b]%s[/b]." % [mentor_name, inc_val, label]
    if bool(mentor_apply_res.get("leveled_up", false)):
        out += "\n[b]%s[/b] increases to %d." % [label, int(mentor_apply_res.get("rating_after", 0))]
    return out

func _persist_characters(characters: Array) -> void :
    if multiplayer.get_unique_id() != 1:
        return
    for cd_v: Variant in characters:
        var cd: CharacterData = cd_v as CharacterData
        if cd == null:
            continue
        GameManager.character_data_by_name[cd.name] = cd






func _on_ic_day_changed(current_date: String) -> void :
    if sessions_by_teacher.is_empty():
        return

    var to_delete: Array[String] = []
    for teacher_k_v: Variant in sessions_by_teacher.keys():
        var teacher_key: String = String(teacher_k_v)
        var sess: Dictionary = sessions_by_teacher.get(teacher_key, {}) as Dictionary
        if sess.is_empty():
            to_delete.append(teacher_key)
            continue

        var started: String = String(sess.get("ic_date", ""))
        if started == "":
            to_delete.append(teacher_key)
            continue


        if current_date > started:
            to_delete.append(teacher_key)

    for tname: String in to_delete:
        var sdict: Dictionary = sessions_by_teacher.get(tname, {}) as Dictionary
        var teacher_display: String = String(sdict.get("teacher", ""))
        var student_display: String = String(sdict.get("student", ""))
        if teacher_display != "":
            _send_message(teacher_display, "[i]Your teaching session with %s has expired and must be started again.[/i]" % student_display)
        if student_display != "":
            _send_message(student_display, "[i]The teaching session with %s has expired and must be started again.[/i]" % teacher_display)
        sessions_by_teacher.erase(tname)
        _delete_session_file(tname)
