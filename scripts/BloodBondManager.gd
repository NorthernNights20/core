
extends Node
class_name BloodBondManager

func _ready() -> void :

    pass

func _get_today_ic_date(target_data: CharacterData) -> String:

    var cal: Node = get_node_or_null("/root/CalendarManager")
    if cal and cal.has_method("get_current_date_string"):
        var date_str: String = String(cal.call("get_current_date_string"))
        return date_str

    var stamp: String = String(target_data.last_ap_reset_stamp)
    if "|" in stamp:
        return stamp.split("|")[0]
    return String(target_data.last_time_woken_up)

func force_blood_bond_point(source_name: String, target_name: String) -> Dictionary:

    if source_name == "" or target_name == "" or source_name == target_name:
        return {"changed": false, "code": "invalid_names", "bonds": {}}

    var target_data: CharacterData = GameManager.character_data_by_name.get(target_name, null) as CharacterData
    if target_data == null:
        return {"changed": false, "code": "no_target", "bonds": {}}

    var bonds: Dictionary = target_data.blood_bonds


    var existing_full_to: String = _find_full_bond_holder(bonds)
    if existing_full_to != "":
        if bonds.size() != 1 or int(bonds.get(existing_full_to, 0)) != 3:
            target_data.blood_bonds.clear()
            target_data.blood_bonds[existing_full_to] = 3
        var code_when_full: String = ("already_full_to_source" if existing_full_to == source_name else "blocked_full_to_other")
        return {
            "changed": false, 
            "code": code_when_full, 
            "bonds": target_data.blood_bonds.duplicate(true)
        }


    var today: String = _get_today_ic_date(target_data)
    var last_by_source: Dictionary = target_data.blood_bond_last_increment
    var last_date_for_source: String = String(last_by_source.get(source_name, ""))
    if last_date_for_source == today:
        return {
            "changed": false, 
            "code": "blocked_same_night", 
            "bonds": target_data.blood_bonds.duplicate(true)
        }


    var current: int = int(bonds.get(source_name, 0))
    var new_level: int = min(current + 1, 3)

    if new_level < 3:
        target_data.blood_bonds[source_name] = new_level
        last_by_source[source_name] = today
        target_data.blood_bond_last_increment = last_by_source
        return {
            "changed": true, 
            "code": "increased_to_%d" % new_level, 
            "bonds": target_data.blood_bonds.duplicate(true)
        }


    target_data.blood_bonds.clear()
    target_data.blood_bonds[source_name] = 3
    last_by_source[source_name] = today
    target_data.blood_bond_last_increment = last_by_source
    return {
        "changed": true, 
        "code": "reached_full_and_cleared_others", 
        "bonds": target_data.blood_bonds.duplicate(true)
    }

func _find_full_bond_holder(bonds: Dictionary) -> String:
    for k in bonds.keys():
        if int(bonds[k]) >= 3:
            return String(k)
    return ""
