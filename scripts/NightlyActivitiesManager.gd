
extends Node

const CHAT_DIVIDER: = "[color=gray]────────────────────[/color]\n"

func perform_willpower_recovery(character: CharacterData) -> void :
    var peer_id: int = GameManager.name_to_peer.get(character.name, -1)

    if character.action_points_current <= 0:
        if peer_id != -1:
            NetworkManager.rpc_id(peer_id, "receive_message", {
                "message": "[color=gray]────────────────────[/color]\nYou've done all you could for now.", 
                "speaker": "Nightly Activities", 
                "jingle": true
            })
        print("❌", character.name, "has no AP left.")
        return

    var before_wp: int = character.willpower_current
    character.willpower_current = min(character.willpower_current + 1, character.willpower_max)
    character.action_points_current = max(0, character.action_points_current - 1)

    var gained: int = character.willpower_current - before_wp
    print("🧠", character.name, "recovered", gained, "WP. New total:", character.willpower_current)

    if peer_id != -1:
        var message: String = "[color=gray]────────────────────[/color]\nYou centered yourself. You recover [b]%d[/b] Willpower." % gained
        NetworkManager.rpc_id(peer_id, "receive_message", {
            "message": message, 
            "speaker": "Nightly Activities", 
            "jingle": true
        })

        var update_data: Dictionary = {
            "zone": character.current_zone, 
            "ap_current": character.action_points_current, 
            "ap_max": character.action_points_max, 
            "blood_current": character.blood_pool, 
            "blood_max": character.blood_pool_max, 
            "wp_current": character.willpower_current, 
            "wp_max": character.willpower_max
        }
        NetworkManager.rpc_id(peer_id, "receive_nightly_activities_data", update_data)


    if multiplayer.get_unique_id() == 1:
        GameManager.character_data_by_name[character.name] = character
        print("💾 Updated server-side CharacterData for:", character.name)


const ATTRIBUTES: Array[String] = [
    "strength", "dexterity", "stamina", 
    "charisma", "manipulation", "appearance", 
    "perception", "intelligence", "wits"
]

const TALENTS: Array[String] = [
    "alertness", "athletics", "awareness", "brawl", "empathy", 
    "expression", "intimidation", "leadership", "streetwise", "subterfuge"
]
const SKILLS: Array[String] = [
    "animal_ken", "crafts", "drive", "etiquette", "firearms", 
    "larceny", "melee", "performance", "stealth", "survival"
]
const KNOWLEDGES: Array[String] = [
    "academics", "computer", "finance", "investigation", "law", 
    "medicine", "occult", "politics", "science", "technology"
]


var ABILITIES: Array[String] = TALENTS + SKILLS + KNOWLEDGES

const BACKGROUNDS: Array[String] = [
    "allies", "contacts", "domain", "fame", "generation_background", 
    "haven", "herd", "influence", "mentor", "resources", 
    "retainers", "rituals", "status"
]


const VIRTUES: Array[String] = ["conscience", "self_control", "courage", "conviction", "instinct"]


const BASE_INCREMENTS: Array[int] = [500, 350, 175, 88, 44]

enum ProgressState{START, RESOLVE_CATEGORY, READ_VALUES, COMPUTE_INCREMENT, APPLY, COMPLETE, ERROR}

func progress_trait(character: CharacterData, trait_name: String) -> Dictionary:
    var ctx: = {
        "trait_in": trait_name, 
        "trait_key": "", 
        "category": "", 
        "rating_before": 0, 
        "progress_before": 0, 
        "increment": 0, 
        "leveled_up": false, 
        "rating_after": 0, 
        "progress_after": 0, 
        "error": ""
    }

    var state: ProgressState = ProgressState.START
    while true:
        match state:
            ProgressState.START:
                ctx.trait_key = trait_name.strip_edges()
                state = ProgressState.RESOLVE_CATEGORY

            ProgressState.RESOLVE_CATEGORY:
                var lower: String = ctx.trait_key.to_lower()
                if ATTRIBUTES.has(lower):
                    ctx.category = "attribute"
                    ctx.trait_key = lower
                elif ABILITIES.has(lower):
                    ctx.category = "ability"
                    ctx.trait_key = lower
                elif BACKGROUNDS.has(lower):
                    ctx.category = "background"
                    ctx.trait_key = lower
                elif VIRTUES.has(lower):
                    ctx.category = "virtue"
                    ctx.trait_key = lower
                elif lower == "path":
                    ctx.category = "path"
                    ctx.trait_key = "path"
                elif lower == "willpower_max":
                    ctx.category = "willpower"
                    ctx.trait_key = "willpower_max"
                else:

                    var canonical: String = _canonical_discipline_name(ctx.trait_key, character)
                    if canonical != "":
                        var DM_SCRIPT: Script = DisciplineManager.get_script()
                        if canonical.to_lower() == String(DM_SCRIPT.THAUMATURGY).to_lower():
                            ctx.error = "Study a Thaumaturgy Path instead of the base discipline."
                            state = ProgressState.ERROR
                            continue
                        if canonical.to_lower() == String(DM_SCRIPT.NECROMANCY).to_lower():
                            ctx.error = "Study a Necromancy Path instead of the base discipline."
                            state = ProgressState.ERROR
                            continue
                        ctx.category = "discipline"
                        ctx.trait_key = canonical
                    else:
                        ctx.error = "Unknown trait: %s" % ctx.trait_key
                        state = ProgressState.ERROR
                        continue
                state = ProgressState.READ_VALUES

            ProgressState.READ_VALUES:
                match ctx.category:
                    "discipline":
                        ctx.rating_before = int(character.disciplines.get(ctx.trait_key, 0))
                        ctx.progress_before = int(character.discipline_progress.get(ctx.trait_key, 0))
                    "path":
                        ctx.rating_before = int(character.path)
                        ctx.progress_before = int(character.path_progress)
                    "willpower":

                        if not _has_property(character, "willpower_max") or not _has_property(character, "willpower_max_progress"):
                            ctx.error = "Character missing fields for willpower_max / willpower_max_progress"
                            state = ProgressState.ERROR
                            continue
                        ctx.rating_before = int(character.willpower_max)
                        ctx.progress_before = int(character.willpower_max_progress)
                    _:
                        var prog_name: String = "%s_progress" % ctx.trait_key
                        if not _has_property(character, ctx.trait_key) or not _has_property(character, prog_name):
                            ctx.error = "Character missing fields for %s" % ctx.trait_key
                            state = ProgressState.ERROR
                            continue
                        ctx.rating_before = int(character.get(ctx.trait_key))
                        ctx.progress_before = int(character.get(prog_name))
                state = ProgressState.COMPUTE_INCREMENT

            ProgressState.COMPUTE_INCREMENT:
                var inc: int
                if ctx.category == "path" or ctx.category == "willpower":
                    var tier: int = clamp(int(ctx.rating_before / 2), 0, 4)
                    inc = BASE_INCREMENTS[tier] * 2
                elif ctx.category == "discipline":
                    var idx: int = clamp(ctx.rating_before, 0, 4)
                    var base_inc: int = BASE_INCREMENTS[idx]
                    var mult: float = _discipline_progress_multiplier(character, ctx.trait_key)
                    inc = max(1, int(ceil(base_inc * mult)))
                else:
                    var idx2: int = clamp(ctx.rating_before, 0, 4)
                    inc = BASE_INCREMENTS[idx2]
                    if ctx.category == "background":
                        @warning_ignore("narrowing_conversion")
                        inc *= 2.0
                ctx.increment = inc
                state = ProgressState.APPLY

            ProgressState.APPLY:
                var new_prog: int = ctx.progress_before + ctx.increment
                var new_rating: int = ctx.rating_before
                var did_level: bool = false

                while new_prog >= 10000:
                    new_prog -= 10000
                    new_rating += 1
                    did_level = true

                match ctx.category:
                    "discipline":
                        character.discipline_progress[ctx.trait_key] = new_prog
                        character.disciplines[ctx.trait_key] = new_rating
                    "path":
                        if new_rating > 10:
                            new_rating = 10
                            new_prog = min(new_prog, 9999)
                        character.path_progress = new_prog
                        character.path = new_rating
                    "willpower":
                        if new_rating > 10:
                            new_rating = 10
                            new_prog = min(new_prog, 9999)
                        character.willpower_max_progress = new_prog
                        character.willpower_max = new_rating
                    _:
                        var prog_name2: String = "%s_progress" % ctx.trait_key
                        character.set(prog_name2, new_prog)
                        character.set(ctx.trait_key, new_rating)

                ctx.leveled_up = did_level
                ctx.rating_after = new_rating
                ctx.progress_after = new_prog
                state = ProgressState.COMPLETE

            ProgressState.COMPLETE:
                return {
                    "ok": true, 
                    "category": ctx.category, 
                    "trait": ctx.trait_key, 
                    "rating_before": ctx.rating_before, 
                    "progress_before": ctx.progress_before, 
                    "increment": ctx.increment, 
                    "leveled_up": ctx.leveled_up, 
                    "rating_after": ctx.rating_after, 
                    "progress_after": ctx.progress_after
                }

            ProgressState.ERROR:
                return {"ok": false, "error": ctx.error}

    return {"ok": false, "error": "Unknown failure in progression machine"}

func _title_case(s: String) -> String:
    var parts: = s.split(" ", false)
    for i in parts.size():
        if parts[i].length() > 0:
            parts[i] = parts[i][0].to_upper() + parts[i].substr(1)
    return " ".join(parts)

func _has_property(obj: Object, prop_name: String) -> bool:
    for p in obj.get_property_list():
        if p.name == prop_name:
            return true
    return false

func process_trait_increase(character: CharacterData, trait_name: String) -> void :
    var result: Dictionary = progress_trait(character, trait_name)
    var peer_id: int = GameManager.name_to_peer.get(character.name, -1)

    if not result.get("ok", false):
        print("⛔ Trait increase failed:", result.get("error", "Unknown error"))
        if peer_id != -1:
            NetworkManager.rpc_id(peer_id, "receive_message", {
                "message": CHAT_DIVIDER + "[b]Error:[/b] %s" % str(result.get("error", "Unknown error")), 
                "speaker": "Nightly Activities", 
                "jingle": true
            })
        return


    character.action_points_current = max(0, character.action_points_current - 1)


    var trait_key: String = str(result.get("trait", "unknown"))
    var category: String = String(result.get("category", "unknown"))
    var leveled_up: bool = bool(result.get("leveled_up", false))
    var rating_after: int = int(result.get("rating_after", 0))


    var message: String = CHAT_DIVIDER + "You improved [b]" + trait_key.capitalize() + "[/b]."
    if leveled_up:
        message += "\n[b]" + trait_key.capitalize() + "[/b] has increased to " + str(rating_after) + "!"


    if peer_id != -1:
        NetworkManager.rpc_id(peer_id, "receive_message", {
            "message": message, 
            "speaker": "Nightly Activities", 
            "jingle": true
        })

        var update_data: Dictionary = {
            "zone": character.current_zone, 
            "ap_current": character.action_points_current, 
            "ap_max": character.action_points_max, 
            "blood_current": character.blood_pool, 
            "blood_max": character.blood_pool_max, 
            "wp_current": character.willpower_current, 
            "wp_max": character.willpower_max
        }
        NetworkManager.rpc_id(peer_id, "receive_nightly_activities_data", update_data)

        match category:
            "attribute":
                NetworkManager.rpc_id(peer_id, "receive_attribute_upgrade_data", character.serialize_to_dict())
            "ability":
                NetworkManager.rpc_id(peer_id, "receive_ability_upgrade_data", character.serialize_to_dict())
            "virtue", "path", "willpower":
                NetworkManager.rpc_id(peer_id, "receive_virtue_upgrade_data", character.serialize_to_dict())
            "discipline":
                var payload: Dictionary = NetworkManager._build_discipline_upgrade_payload(character)
                NetworkManager.rpc_id(peer_id, "receive_discipline_upgrade_data", payload)


    if multiplayer.get_unique_id() == 1:
        GameManager.character_data_by_name[character.name] = character


func study_thaumaturgy_path(character: CharacterData, path_label: String) -> void :
    var peer_id: int = GameManager.name_to_peer.get(character.name, -1)

    if character.action_points_current <= 0:
        if peer_id != -1:
            NetworkManager.rpc_id(peer_id, "receive_message", {
                "message": CHAT_DIVIDER + "You've done all you could for now.", 
                "speaker": "Nightly Activities", 
                "jingle": true
            })
        print("❌", character.name, "has no AP left (Path study).")
        return

    var DM_SCRIPT: Script = DisciplineManager.get_script()
    var res: Dictionary = DM_SCRIPT.progress_thaum_path_for_character(character, path_label)


    character.action_points_current = max(0, character.action_points_current - 1)

    var used_increment: int = int(res.get("used_increment", 0))
    var dots_gained: int = int(res.get("dots_gained", 0))
    var rating_after: int = int(res.get("rating_after", 0))
    var is_primary: bool = bool(res.get("is_primary", false))

    var msg: String = CHAT_DIVIDER + "You study [b]%s[/b]. (+%d progress%s)" % [
        String(res.get("path", path_label)), 
        used_increment, 
        (" at normal speed" if is_primary else " at sorcery pace")
    ]
    if dots_gained > 0:
        msg += "\n[b]%s[/b] increases to %d." % [String(res.get("path", path_label)), rating_after]
        msg += "\nYour [b]Thaumaturgy[/b] also rises by %d." % dots_gained

    if peer_id != -1:
        NetworkManager.rpc_id(peer_id, "receive_message", {
            "message": msg, 
            "speaker": "Nightly Activities", 
            "jingle": true
        })

        var update_data: Dictionary = {
            "zone": character.current_zone, 
            "ap_current": character.action_points_current, 
            "ap_max": character.action_points_max, 
            "blood_current": character.blood_pool, 
            "blood_max": character.blood_pool_max, 
            "wp_current": character.willpower_current, 
            "wp_max": character.willpower_max
        }
        NetworkManager.rpc_id(peer_id, "receive_nightly_activities_data", update_data)

        var paths_payload: Array[Dictionary] = DM_SCRIPT.build_thaum_path_payload(character)
        NetworkManager.rpc_id(peer_id, "receive_thaumaturgy_paths_data", paths_payload)

        if dots_gained > 0:
            var disc_payload: Dictionary = NetworkManager._build_discipline_upgrade_payload(character)
            NetworkManager.rpc_id(peer_id, "receive_discipline_upgrade_data", disc_payload)


    if multiplayer.get_unique_id() == 1:
        GameManager.character_data_by_name[character.name] = character


func study_necromancy_path(character: CharacterData, path_label: String) -> void :
    var peer_id: int = GameManager.name_to_peer.get(character.name, -1)

    if character.action_points_current <= 0:
        if peer_id != -1:
            NetworkManager.rpc_id(peer_id, "receive_message", {
                "message": CHAT_DIVIDER + "You've done all you could for now.", 
                "speaker": "Nightly Activities", 
                "jingle": true
            })
        print("❌", character.name, "has no AP left (Path study).")
        return

    var DM_SCRIPT: Script = DisciplineManager.get_script()
    var res: Dictionary = DM_SCRIPT.progress_necromancy_path_for_character(character, path_label)


    character.action_points_current = max(0, character.action_points_current - 1)

    var used_increment: int = int(res.get("used_increment", 0))
    var dots_gained: int = int(res.get("dots_gained", 0))
    var rating_after: int = int(res.get("rating_after", 0))
    var is_primary: bool = bool(res.get("is_primary", false))

    var msg: String = CHAT_DIVIDER + "You study [b]%s[/b]. (+%d progress%s)" % [
        String(res.get("path", path_label)), 
        used_increment, 
        (" at normal speed" if is_primary else " at sorcery pace")
    ]
    if dots_gained > 0:
        msg += "\n[b]%s[/b] increases to %d." % [String(res.get("path", path_label)), rating_after]
        msg += "\nYour [b]Necromancy[/b] also rises by %d." % dots_gained

    if peer_id != -1:
        NetworkManager.rpc_id(peer_id, "receive_message", {
            "message": msg, 
            "speaker": "Nightly Activities", 
            "jingle": true
        })

        var update_data: Dictionary = {
            "zone": character.current_zone, 
            "ap_current": character.action_points_current, 
            "ap_max": character.action_points_max, 
            "blood_current": character.blood_pool, 
            "blood_max": character.blood_pool_max, 
            "wp_current": character.willpower_current, 
            "wp_max": character.willpower_max
        }
        NetworkManager.rpc_id(peer_id, "receive_nightly_activities_data", update_data)

        var disc_payload: Dictionary = NetworkManager._build_discipline_upgrade_payload(character)
        NetworkManager.rpc_id(peer_id, "receive_discipline_upgrade_data", disc_payload)

        var necro_payload: Array[Dictionary] = DM_SCRIPT.build_necromancy_path_payload(character)
        NetworkManager.rpc_id(peer_id, "receive_necromancy_paths_data", necro_payload)


    if multiplayer.get_unique_id() == 1:
        GameManager.character_data_by_name[character.name] = character

func _discipline_progress_multiplier(character: CharacterData, disc_key: String) -> float:
    var DM_SCRIPT: Script = DisciplineManager.get_script()

    var prim_list: Array = DM_SCRIPT.get_in_clan_disciplines_for_character(character)
    var prim_set: Dictionary = {}
    for d in prim_list:
        prim_set[String(d)] = true

    var sorc_thaum: String = String(DM_SCRIPT.THAUMATURGY)
    var sorc_necro: String = String(DM_SCRIPT.NECROMANCY)

    if prim_set.has(disc_key):
        return 1.0
    if disc_key == sorc_thaum or disc_key == sorc_necro:
        return 1.0 / 2.5
    if (DM_SCRIPT.COMMON_DISCIPLINES as Array).has(disc_key):
        return 1.0 / 1.5
    if (DM_SCRIPT.CLAN_DISCIPLINES as Array).has(disc_key):
        return 0.5
    return 0.5




func _build_discipline_upgrade_payload(cd: CharacterData) -> Dictionary:
    var DM_SCRIPT: Script = DisciplineManager.get_script()

    var prim_list_any: Array = DM_SCRIPT.get_in_clan_disciplines_for_character(cd)
    var prim_list: Array[String] = []
    for v in prim_list_any:
        prim_list.append(String(v))

    var prim_set: Dictionary = {}
    for d in prim_list:
        prim_set[d] = true

    var primary: Array[Dictionary] = []
    var out_common: Array[Dictionary] = []
    var out_clan: Array[Dictionary] = []
    var sorcery: Array[Dictionary] = []

    for d in prim_list:
        var e0: Dictionary = _make_disc_entry(cd, d, true)
        if not e0.is_empty():
            primary.append(e0)

    for d in (DM_SCRIPT.COMMON_DISCIPLINES as Array):
        var dn: String = String(d)
        if prim_set.has(dn):
            continue
        var e1: Dictionary = _make_disc_entry(cd, dn, false)
        if not e1.is_empty():
            out_common.append(e1)

    for d in (DM_SCRIPT.CLAN_DISCIPLINES as Array):
        var dn2: String = String(d)
        if prim_set.has(dn2):
            continue
        var e2: Dictionary = _make_disc_entry(cd, dn2, false)
        if not e2.is_empty():
            out_clan.append(e2)

    var sorc_names: Array[String] = [String(DM_SCRIPT.THAUMATURGY), String(DM_SCRIPT.NECROMANCY)]
    for dn3 in sorc_names:
        if prim_set.has(dn3):
            continue
        var e3: Dictionary = _make_disc_entry(cd, dn3, false)
        if not e3.is_empty():
            sorcery.append(e3)


    for d_name in cd.disciplines.keys():
        var dn4: String = String(d_name)
        if prim_set.has(dn4):
            continue
        if (DM_SCRIPT.COMMON_DISCIPLINES as Array).has(dn4)\
or (DM_SCRIPT.CLAN_DISCIPLINES as Array).has(dn4)\
or dn4 == String(DM_SCRIPT.THAUMATURGY)\
or dn4 == String(DM_SCRIPT.NECROMANCY):
            continue
        var e4: Dictionary = _make_disc_entry(cd, dn4, false)
        if not e4.is_empty():
            out_clan.append(e4)

    return {
        "primary": primary, 
        "out_common": out_common, 
        "out_clan": out_clan, 
        "sorcery": sorcery
    }

func _make_disc_entry(cd: CharacterData, disc_key: String, include_zero: bool) -> Dictionary:
    var rating: int = int(cd.disciplines.get(disc_key, 0))
    if rating <= 0 and not include_zero:
        return {}
    var prog: int = int(cd.discipline_progress.get(disc_key, 0))
    return {"name": disc_key, "rating": rating, "progress": prog}

func _canonical_discipline_name(raw_name: String, character: CharacterData) -> String:
    var key: = raw_name.strip_edges()

    if character.disciplines.has(key):
        return key

    var title: = _title_case(key.to_lower())
    if character.disciplines.has(title):
        return title

    var DM_SCRIPT: Script = DisciplineManager.get_script()

    var prim_any: Array = DM_SCRIPT.get_in_clan_disciplines_for_character(character)
    for v in prim_any:
        var d: String = String(v)
        if d.to_lower() == key.to_lower():
            return d

    for d0 in (DM_SCRIPT.COMMON_DISCIPLINES as Array):
        var dcs: String = String(d0)
        if dcs.to_lower() == key.to_lower():
            return dcs
    for d1 in (DM_SCRIPT.CLAN_DISCIPLINES as Array):
        var dcs2: String = String(d1)
        if dcs2.to_lower() == key.to_lower():
            return dcs2

    var th: String = String(DM_SCRIPT.THAUMATURGY)
    var ne: String = String(DM_SCRIPT.NECROMANCY)
    if th.to_lower() == key.to_lower():
        return th
    if ne.to_lower() == key.to_lower():
        return ne

    for existing_name in character.disciplines.keys():
        var en: String = String(existing_name)
        if en.to_lower() == key.to_lower():
            return en

    return ""
