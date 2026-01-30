
extends Node





static func _extract_primary_from_special_merits(merits: Array[String]) -> Array[String]:
    var out: Array[String] = []
    for m_any in merits:
        var m: String = String(m_any).to_lower()


        if m.findn("blessed by st. gustav") != -1:
            out.append(canon_any("Auspex"))


        if m.findn("warrior's heart") != -1 or m.findn("warriors heart") != -1:
            out.append(canon_any("Obeah"))
    return _dedupe_ci(out)


static func canon_any(raw: String) -> String:
    var s: String = raw.strip_edges()
    var lower: String = s.to_lower()

    for d in COMMON_DISCIPLINES:
        if String(d).to_lower() == lower:
            return String(d)
    for d in CLAN_DISCIPLINES:
        if String(d).to_lower() == lower:
            return String(d)

    if THAUMATURGY.to_lower() == lower:
        return THAUMATURGY
    if NECROMANCY.to_lower() == lower:
        return NECROMANCY

    for clan in CLAN_DISCIPLINE_MAP.keys():
        for di in CLAN_DISCIPLINE_MAP[clan]:
            var ds: String = String(di)
            if ds.to_lower() == lower:
                return ds
    return s

static func _dedupe_ci(arr: Array[String]) -> Array[String]:
    var seen: Dictionary = {}
    var out: Array[String] = []
    for v in arr:
        var k: String = String(v).to_lower()
        if not seen.has(k):
            seen[k] = true
            out.append(String(v))
    return out

static func _arr_has_ci(arr: Array[String], raw: String) -> bool:
    var key: String = raw.to_lower()
    for v in arr:
        if String(v).to_lower() == key:
            return true
    return false



const CLAN_DISCIPLINE_MAP: = {
    "Assamite Antitribu": ["Celerity", "Obfuscate", "Quietus"], 
    "Brujah": ["Celerity", "Potence", "Presence"], 
    "Brujah Antitribu": ["Celerity", "Potence", "Presence"], 
    "Daughters of Cacophony": ["Fortitude", "Melpominee", "Presence"], 
    "Gangrel": ["Animalism", "Fortitude", "Protean"], 
    "Country Gangrel": ["Animalism", "Fortitude", "Protean"], 
    "City Gangrel": ["Celerity", "Obfuscate", "Protean"], 
    "Malkavian": ["Auspex", "Dementation", "Obfuscate"], 
    "Malkavian Antitribu": ["Auspex", "Dementation", "Obfuscate"], 
    "Nosferatu": ["Animalism", "Obfuscate", "Potence"], 
    "Nosferatu Antitribu": ["Animalism", "Obfuscate", "Potence"], 
    "Ravnos Antitribu": ["Animalism", "Chimerstry", "Fortitude"], 
    "Toreador": ["Auspex", "Celerity", "Presence"], 
    "Toreador Antitribu": ["Auspex", "Celerity", "Presence"], 
    "Salubri Antitribu": ["Auspex", "Fortitude", "Valeren"], 
    "Serpents of the Light": ["Presence", "Obfuscate", "Serpentis"], 
    "Tremere": ["Auspex", "Dominate", "Thaumaturgy"], 
    "Tremere Antitribu": ["Auspex", "Dominate", "Thaumaturgy"], 
    "Ventrue": ["Dominate", "Fortitude", "Presence"], 
    "Ventrue Antitribu": ["Dominate", "Fortitude", "Presence"], 
    "Lasombra": ["Dominate", "Obtenebration", "Potence"], 
    "Tzimisce": ["Animalism", "Auspex", "Vicissitude"], 
}


const COMMON_DISCIPLINES: Array[String] = [
    "Animalism", 
    "Auspex", 
    "Celerity", 
    "Dominate", 
    "Fortitude", 
    "Obfuscate", 
    "Potence", 
    "Presence", 
]


const CLAN_DISCIPLINES: Array[String] = [
    "Abombwe", 
    "Bardo", 
    "Chimerstry", 
    "Daimoinon", 
    "Dementation", 
    "Flight", 
    "Melpominee", 
    "Mytherceria", 
    "Obeah", 
    "Obtenebration", 
    "Ogham", 
    "Protean", 
    "Quietus", 
    "Sanguinus", 
    "Serpentis", 
    "Spiritus", 
    "Temporis", 
    "Thanatosis", 
    "Valeren", 
    "Vicissitude", 
    "Visceratika", 
]


const THAUMATURGY: String = "Thaumaturgy"
const NECROMANCY: String = "Necromancy"



const THAUM_BASE_INCREMENTS: Array[int] = [500, 350, 175, 88, 44]




const THAUMATURGY_PATHS: Array[String] = [
    "The Path of Blood", 
    "The Blessings of the Great Dark Mother", 
    "Elemental Mastery", 
    "The Green Path", 
    "Hands of Destruction", 
    "The Lure of Flames", 
    "Mastery of the Mortal Shell", 
    "Movement of the Mind", 
    "Neptune's Might", 
    "The Path of Conjuring", 
    "The Path of Corruption", 
    "The Path of Mars", 
    "Path of Spirit Manipulation", 
    "The Path of Technomancy", 
    "The Path of the Father's Vengeance", 
    "Path of the Focused Mind", 
    "Path of the Levinbolt", 
    "Potestas Motus (Power of Motion)", 
    "Thaumaturgical Countermagic", 
    "Weather Control", 
    "Cammano-deuonertos", 
]



const NECROMANCY_PATHS: Array[String] = [
    "Cenotaph", 
    "Sepulchre", 
    "Bone", 
    "Corpse in the Monster", 
    "Grave's Decay", 
    "Haunting"
]


static func canon_thaum_path(raw: String) -> String:
    var s: String = raw.strip_edges()
    var lower: String = s.to_lower()
    for p in THAUMATURGY_PATHS:
        var ps: String = String(p)
        if ps.to_lower() == lower:
            return ps
    return s

static func canon_necromancy_path(raw: String) -> String:
    var s: String = raw.strip_edges()
    var lower: String = s.to_lower()
    for p in NECROMANCY_PATHS:
        var ps: String = String(p)
        if ps.to_lower() == lower:
            return ps
    return s


static func _find_thaum_path_index_ci(cd: CharacterData, path_label: String) -> int:
    var key: String = path_label.strip_edges().to_lower()
    for i in range(cd.thaumaturgy_paths.size()):
        var entry: String = String(cd.thaumaturgy_paths[i])
        var parts: PackedStringArray = entry.split(":", false, 1)
        var nm: String = parts[0].strip_edges()
        if nm.to_lower() == key:
            return i
    return -1

static func _find_necromancy_path_index_ci(cd: CharacterData, path_label: String) -> int:
    var key: String = path_label.strip_edges().to_lower()
    for i in range(cd.necromancy_paths.size()):
        var entry: String = String(cd.necromancy_paths[i])
        var parts: PackedStringArray = entry.split(":", false, 1)
        var nm: String = parts[0].strip_edges()
        if nm.to_lower() == key:
            return i
    return -1


static func get_thaum_path_rating(cd: CharacterData, path_label: String) -> int:
    var idx: int = _find_thaum_path_index_ci(cd, path_label)
    if idx == -1:
        return 0
    var parts: PackedStringArray = String(cd.thaumaturgy_paths[idx]).split(":", false, 1)
    return (int(parts[1]) if parts.size() > 1 else 0)

static func get_necromancy_path_rating(cd: CharacterData, path_label: String) -> int:
    var idx: int = _find_necromancy_path_index_ci(cd, path_label)
    if idx == -1:
        return 0
    var parts: PackedStringArray = String(cd.necromancy_paths[idx]).split(":", false, 1)
    return (int(parts[1]) if parts.size() > 1 else 0)

static func _set_thaum_path_rating_ci(cd: CharacterData, path_label: String, rating: int) -> void :
    rating = clamp(rating, 0, 5)
    var canon: String = canon_thaum_path(path_label)
    var idx: int = _find_thaum_path_index_ci(cd, canon)
    var entry: String = "%s:%d" % [canon, rating]
    if idx == -1:
        cd.thaumaturgy_paths.append(entry)
    else:
        cd.thaumaturgy_paths[idx] = entry

static func _set_necromancy_path_rating_ci(cd: CharacterData, path_label: String, rating: int) -> void :
    rating = clamp(rating, 0, 5)
    var canon: String = canon_necromancy_path(path_label)
    var idx: int = _find_necromancy_path_index_ci(cd, canon)
    var entry: String = "%s:%d" % [canon, rating]
    if idx == -1:
        cd.necromancy_paths.append(entry)
    else:
        cd.necromancy_paths[idx] = entry


static func get_thaum_path_progress(cd: CharacterData, path_label: String) -> int:
    var canon: String = canon_thaum_path(path_label)

    for k in cd.thaumaturgy_path_progress.keys():
        var kk: String = String(k)
        if kk.to_lower() == canon.to_lower():
            return int(cd.thaumaturgy_path_progress[kk])
    return 0

static func get_necromancy_path_progress(cd: CharacterData, path_label: String) -> int:
    var canon: String = canon_necromancy_path(path_label)

    for k in cd.necromancy_path_progress.keys():
        var kk: String = String(k)
        if kk.to_lower() == canon.to_lower():
            return int(cd.necromancy_path_progress[kk])
    return 0

static func _set_thaum_path_progress_ci(cd: CharacterData, path_label: String, value: int) -> void :
    var canon: String = canon_thaum_path(path_label)
    var store_key: String = canon
    for k in cd.thaumaturgy_path_progress.keys():
        var kk: String = String(k)
        if kk.to_lower() == canon.to_lower():
            store_key = kk
            break
    cd.thaumaturgy_path_progress[store_key] = clamp(value, 0, 9999)

static func _set_necromancy_path_progress_ci(cd: CharacterData, path_label: String, value: int) -> void :
    var canon: String = canon_necromancy_path(path_label)
    var store_key: String = canon
    for k in cd.necromancy_path_progress.keys():
        var kk: String = String(k)
        if kk.to_lower() == canon.to_lower():
            store_key = kk
            break
    cd.necromancy_path_progress[store_key] = clamp(value, 0, 9999)


static func build_thaum_path_payload(cd: CharacterData) -> Array[Dictionary]:
    var out: Array[Dictionary] = []
    var primary_name: String = ""
    if cd.thaumaturgy_paths.size() > 0:
        primary_name = canon_thaum_path(String(cd.thaumaturgy_paths[0]).split(":", false, 1)[0].strip_edges())
    for entry in cd.thaumaturgy_paths:
        var parts: PackedStringArray = String(entry).split(":", false, 1)
        var label: String = canon_thaum_path(parts[0].strip_edges())
        var rating: int = (clamp(int(parts[1]), 0, 5) if parts.size() > 1 else 0)
        var prog: int = get_thaum_path_progress(cd, label)
        out.append({
            "name": label, 
            "rating": rating, 
            "progress": prog, 
            "primary": (label == primary_name)
        })
    return out

static func build_necromancy_path_payload(cd: CharacterData) -> Array[Dictionary]:
    var out: Array[Dictionary] = []
    var primary_name: String = ""
    if cd.necromancy_paths.size() > 0:
        primary_name = canon_necromancy_path(String(cd.necromancy_paths[0]).split(":", false, 1)[0].strip_edges())
    for entry in cd.necromancy_paths:
        var parts: PackedStringArray = String(entry).split(":", false, 1)
        var label: String = canon_necromancy_path(parts[0].strip_edges())
        var rating: int = (clamp(int(parts[1]), 0, 5) if parts.size() > 1 else 0)
        var prog: int = get_necromancy_path_progress(cd, label)
        out.append({
            "name": label, 
            "rating": rating, 
            "progress": prog, 
            "primary": (label == primary_name)
        })
    return out


static func is_thaum_primary_for_character(cd: CharacterData) -> bool:
    return is_primary_for_character(cd, THAUMATURGY)

static func is_necromancy_primary_for_character(cd: CharacterData) -> bool:
    return is_primary_for_character(cd, NECROMANCY)

static func compute_thaum_path_multiplier(cd: CharacterData) -> float:

    return 1.0 if is_thaum_primary_for_character(cd) else 1.0 / 2.5

static func compute_necromancy_path_multiplier(cd: CharacterData) -> float:

    return 1.0 if is_necromancy_primary_for_character(cd) else 1.0 / 2.5

static func compute_thaum_path_increment(cd: CharacterData, path_label: String) -> int:
    var cur_rating: int = get_thaum_path_rating(cd, path_label)
    var tier: int = clamp(cur_rating, 0, 4)
    var base_val: int = THAUM_BASE_INCREMENTS[tier]
    var mult: float = compute_thaum_path_multiplier(cd)
    var inc: int = int(ceil(float(base_val) * mult))
    return max(1, inc)

static func compute_necromancy_path_increment(cd: CharacterData, path_label: String) -> int:
    var cur_rating: int = get_necromancy_path_rating(cd, path_label)
    var tier: int = clamp(cur_rating, 0, 4)
    var base_val: int = THAUM_BASE_INCREMENTS[tier]
    var mult: float = compute_necromancy_path_multiplier(cd)
    var inc: int = int(ceil(float(base_val) * mult))
    return max(1, inc)



static func progress_thaum_path_for_character(cd: CharacterData, path_label: String) -> Dictionary:
    var inc: int = compute_thaum_path_increment(cd, path_label)
    var res: Dictionary = progress_thaum_path_with_increment(cd, path_label, inc)
    res["used_increment"] = inc
    res["multiplier"] = compute_thaum_path_multiplier(cd)
    res["is_primary"] = is_thaum_primary_for_character(cd)
    return res

static func progress_necromancy_path_for_character(cd: CharacterData, path_label: String) -> Dictionary:
    var inc: int = compute_necromancy_path_increment(cd, path_label)
    var res: Dictionary = progress_necromancy_path_with_increment(cd, path_label, inc)
    res["used_increment"] = inc
    res["multiplier"] = compute_necromancy_path_multiplier(cd)
    res["is_primary"] = is_necromancy_primary_for_character(cd)
    return res






static func progress_thaum_path_with_increment(cd: CharacterData, path_label: String, increment: int) -> Dictionary:
    var canon: String = canon_thaum_path(path_label)

    if _find_thaum_path_index_ci(cd, canon) == -1:
        cd.thaumaturgy_paths.append("%s:%d" % [canon, 0])
    if not cd.thaumaturgy_path_progress.has(canon):
        cd.thaumaturgy_path_progress[canon] = 0

    var rating_before: int = get_thaum_path_rating(cd, canon)
    var prog_before: int = get_thaum_path_progress(cd, canon)

    var inc_clamped: int = max(0, increment)
    var new_prog: int = prog_before + inc_clamped
    var new_rating: int = rating_before
    var dots_gained: int = 0


    while new_prog >= 10000 and new_rating < 5:
        new_prog -= 10000
        new_rating += 1
        dots_gained += 1


    if new_rating >= 5 and new_prog > 9999:
        new_prog = 9999


    _set_thaum_path_rating_ci(cd, canon, new_rating)
    _set_thaum_path_progress_ci(cd, canon, new_prog)


    if dots_gained > 0:
        var th_old: int = int(cd.disciplines.get(THAUMATURGY, 0))
        cd.disciplines[THAUMATURGY] = th_old + dots_gained


    return {
        "ok": true, 
        "path": canon, 
        "increment": inc_clamped, 
        "rating_before": rating_before, 
        "progress_before": prog_before, 
        "rating_after": new_rating, 
        "progress_after": new_prog, 
        "dots_gained": dots_gained, 
        "thaumaturgy_after": int(cd.disciplines.get(THAUMATURGY, 0))
    }






static func progress_necromancy_path_with_increment(cd: CharacterData, path_label: String, increment: int) -> Dictionary:
    var canon: String = canon_necromancy_path(path_label)

    if _find_necromancy_path_index_ci(cd, canon) == -1:
        cd.necromancy_paths.append("%s:%d" % [canon, 0])
    if not cd.necromancy_path_progress.has(canon):
        cd.necromancy_path_progress[canon] = 0

    var rating_before: int = get_necromancy_path_rating(cd, canon)
    var prog_before: int = get_necromancy_path_progress(cd, canon)

    var inc_clamped: int = max(0, increment)
    var new_prog: int = prog_before + inc_clamped
    var new_rating: int = rating_before
    var dots_gained: int = 0


    while new_prog >= 10000 and new_rating < 5:
        new_prog -= 10000
        new_rating += 1
        dots_gained += 1


    if new_rating >= 5 and new_prog > 9999:
        new_prog = 9999


    _set_necromancy_path_rating_ci(cd, canon, new_rating)
    _set_necromancy_path_progress_ci(cd, canon, new_prog)


    if dots_gained > 0:
        var ne_old: int = int(cd.disciplines.get(NECROMANCY, 0))
        cd.disciplines[NECROMANCY] = ne_old + dots_gained


    return {
        "ok": true, 
        "path": canon, 
        "increment": inc_clamped, 
        "rating_before": rating_before, 
        "progress_before": prog_before, 
        "rating_after": new_rating, 
        "progress_after": new_prog, 
        "dots_gained": dots_gained, 
        "necromancy_after": int(cd.disciplines.get(NECROMANCY, 0))
    }




static func extract_additional_disciplines_from_merits(merits: Array[String]) -> Array[String]:
    var seen: Dictionary = {}
    var out: Array[String] = []
    for m: String in merits:
        if not m.begins_with("Additional Discipline"):
            continue
        var open: int = m.rfind("(")
        var close: int = m.rfind(")")
        if open == -1 or close == -1 or close <= open:
            continue
        var disc_name: String = m.substr(open + 1, close - open - 1).strip_edges()
        if _is_digits(disc_name) or disc_name.is_empty():
            continue
        disc_name = canon_any(disc_name)
        var key: String = disc_name.to_lower()
        if not seen.has(key):
            seen[key] = true
            out.append(disc_name)
    return out

static func _is_digits(s: String) -> bool:
    if s.is_empty():
        return false
    for i in s.length():
        var c: String = s[i]
        if c < "0" or c > "9":
            return false
    return true



static func get_in_clan_disciplines(clan: String, merits: Array[String]) -> Array[String]:
    var result: Array[String] = []
    var seen: Dictionary = {}


    if CLAN_DISCIPLINE_MAP.has(clan):
        var trio_any: Variant = CLAN_DISCIPLINE_MAP.get(clan, [])
        if trio_any is Array:
            for di in (trio_any as Array):
                var d: String = canon_any(String(di))
                var k: String = d.to_lower()
                if not seen.has(k):
                    seen[k] = true
                    result.append(d)


    for d in extract_additional_disciplines_from_merits(merits):
        var k: String = d.to_lower()
        if not seen.has(k):
            seen[k] = true
            result.append(d)


    for d2 in _extract_primary_from_special_merits(merits):
        var k2: String = d2.to_lower()
        if not seen.has(k2):
            seen[k2] = true
            result.append(d2)

    return result


static func get_in_clan_disciplines_for_character(cd: CharacterData) -> Array[String]:
    var clan: String = ""
    var merits_list: Array[String] = []
    if cd != null:
        clan = String(cd.clan)
        for v in cd.merits:
            merits_list.append(String(v))
    return get_in_clan_disciplines(clan, merits_list)




static func group_disciplines_for_upgrade(cd: CharacterData) -> Dictionary:
    var prim_list: Array[String] = get_in_clan_disciplines_for_character(cd)


    var prim_set_lc: Dictionary = {}
    for d in prim_list:
        prim_set_lc[String(d).to_lower()] = true
    var included_lc: Dictionary = {}

    var primary: Array[Dictionary] = []
    var out_common: Array[Dictionary] = []
    var out_clan: Array[Dictionary] = []
    var sorcery: Array[Dictionary] = []


    for d in prim_list:
        var disc: String = String(d)
        var e0: Dictionary = _mk_entry(cd, disc, true)
        primary.append(e0)
        included_lc[disc.to_lower()] = true


    for d in COMMON_DISCIPLINES:
        var disc: String = String(d)
        if prim_set_lc.has(disc.to_lower()):
            continue
        var e1: Dictionary = _mk_entry(cd, disc, false)
        if not e1.is_empty():
            out_common.append(e1)
            included_lc[disc.to_lower()] = true


    for d in CLAN_DISCIPLINES:
        var disc: String = String(d)
        if prim_set_lc.has(disc.to_lower()):
            continue
        var e2: Dictionary = _mk_entry(cd, disc, false)
        if not e2.is_empty():
            out_clan.append(e2)
            included_lc[disc.to_lower()] = true


    for d in [THAUMATURGY, NECROMANCY]:
        var disc: String = String(d)
        if prim_set_lc.has(disc.to_lower()):
            continue
        var e3: Dictionary = _mk_entry(cd, disc, false)
        if not e3.is_empty():
            sorcery.append(e3)
            included_lc[disc.to_lower()] = true


    for d_name in cd.disciplines.keys():
        var dn: String = String(d_name)
        var key_lc: String = dn.to_lower()
        if included_lc.has(key_lc) or prim_set_lc.has(key_lc):
            continue
        if _arr_has_ci(COMMON_DISCIPLINES, dn) or _arr_has_ci(CLAN_DISCIPLINES, dn) or dn.to_lower() == THAUMATURGY.to_lower() or dn.to_lower() == NECROMANCY.to_lower():
            continue
        var e4: Dictionary = _mk_entry(cd, dn, false)
        if not e4.is_empty():
            out_clan.append(e4)
            included_lc[key_lc] = true


    for p_name in cd.discipline_progress.keys():
        var raw: String = String(p_name)
        var raw_lc: String = raw.to_lower()
        if included_lc.has(raw_lc):
            continue
        var prog_val: int = int(cd.discipline_progress.get(raw, 0))
        if prog_val <= 0:
            continue


        var canon: String = _canon_from_lists(raw, prim_list)
        var canon_lc: String = canon.to_lower()
        if included_lc.has(canon_lc):
            continue

        if prim_set_lc.has(canon_lc):
            primary.append(_mk_entry(cd, canon, true))
        elif _arr_has_ci(COMMON_DISCIPLINES, canon):
            out_common.append(_mk_entry(cd, canon, true))
        elif _arr_has_ci(CLAN_DISCIPLINES, canon):
            out_clan.append(_mk_entry(cd, canon, true))
        elif canon.to_lower() == THAUMATURGY.to_lower() or canon.to_lower() == NECROMANCY.to_lower():
            sorcery.append(_mk_entry(cd, canon, true))
        else:
            out_clan.append(_mk_entry(cd, canon, true))

        included_lc[canon_lc] = true

    return {
        "primary": primary, 
        "out_common": out_common, 
        "out_clan": out_clan, 
        "sorcery": sorcery
    }


static func is_primary_for_character(cd: CharacterData, discipline_name: String) -> bool:
    var prim_list: Array[String] = get_in_clan_disciplines_for_character(cd)
    var key: String = discipline_name.to_lower()
    for d in prim_list:
        if String(d).to_lower() == key:
            return true
    return false

static func is_common_discipline(discipline_name: String) -> bool:
    return _arr_has_ci(COMMON_DISCIPLINES, discipline_name)

static func is_clan_discipline(discipline_name: String) -> bool:
    return _arr_has_ci(CLAN_DISCIPLINES, discipline_name)

static func is_sorcery(discipline_name: String) -> bool:
    var key: String = discipline_name.to_lower()
    return key == THAUMATURGY.to_lower() or key == NECROMANCY.to_lower()



static func _mk_entry(cd: CharacterData, disc_name: String, include_zero: bool) -> Dictionary:
    var rating: int = int(cd.disciplines.get(disc_name, 0))
    var prog: int = int(cd.discipline_progress.get(disc_name, 0))
    if rating <= 0 and prog <= 0 and not include_zero:
        return {}
    return {"name": disc_name, "rating": rating, "progress": prog}



static func _canon_from_lists(raw_name: String, prim_list: Array[String]) -> String:
    var lower: String = raw_name.to_lower()

    for d: String in prim_list:
        var ds: String = String(d)
        if ds.to_lower() == lower:
            return ds

    for d: String in COMMON_DISCIPLINES:
        var ds2: String = String(d)
        if ds2.to_lower() == lower:
            return ds2

    for d: String in CLAN_DISCIPLINES:
        var ds3: String = String(d)
        if ds3.to_lower() == lower:
            return ds3

    if THAUMATURGY.to_lower() == lower:
        return THAUMATURGY
    if NECROMANCY.to_lower() == lower:
        return NECROMANCY

    return raw_name
