extends Node

const CHAT_DIVIDER: String = "[color=gray]────────────────────[/color]\n"




func process_heal_bash_lethal(character_name: String) -> void :
    if not GameManager.character_data_by_name.has(character_name):
        return

    var data: CharacterData = GameManager.character_data_by_name[character_name]

    var blood_ok: bool = data.blood_pool > 1
    var agg_count: int = (data.aggravated_wounds.size() if "aggravated_wounds" in data else 0)
    var all_aggravated: bool = (agg_count == data.health_index)

    if ( not blood_ok) or all_aggravated:
        var peer_id: int = GameManager.character_peers.get(character_name, -1)
        if peer_id != -1:
            var reason: String = ""
            if not blood_ok:
                reason = "You cannot heal with only 1 blood remaining."
            elif all_aggravated:
                reason = "All current wounds are aggravated. Bash/Lethal heal will not work."
            var packet_fail: Dictionary = {
                "message": "[i]Healing failed:[/i] " + reason, 
                "speaker": character_name
            }
            get_node("/root/NetworkManager").rpc_id(peer_id, "receive_message", packet_fail)
        return


    data.health_index = max(0, data.health_index - 1)
    data.blood_pool = max(0, data.blood_pool - 1)


    var idx: int = clamp(data.health_index, 0, max(0, data.health_levels.size() - 1))
    var new_level: String = (data.health_levels[idx] if data.health_levels.size() > 0 else "Healthy")


    var zone_name: String = data.current_zone
    var zone_data: Dictionary = ZoneManager.zones.get(zone_name, {})
    var characters_in_zone: Array = zone_data.get("characters", [])

    var msg: String = CHAT_DIVIDER + "[b]%s[/b] focuses vitae to mend a wound. (blood -1)" % character_name
    var packet_success: Dictionary = {
        "message": msg, 
        "speaker": character_name
    }

    var notified: Dictionary = {}
    for char_data in characters_in_zone:
        if not char_data or not char_data.has_method("get"):
            continue
        var char_name: String = char_data.name
        var pid: int = GameManager.character_peers.get(char_name, -1)
        if pid != -1 and not notified.has(pid):
            get_node("/root/NetworkManager").rpc_id(pid, "receive_message", packet_success)
            notified[pid] = true


    var actor_pid: int = GameManager.character_peers.get(character_name, -1)
    if actor_pid != -1:
        var packet_private: Dictionary = {
            "message": CHAT_DIVIDER + "[b]Health[/b]: You are now [u]%s[/u]." % new_level, 
            "speaker": character_name
        }
        get_node("/root/NetworkManager").rpc_id(actor_pid, "receive_message", packet_private)





func process_heal_aggravated(character_name: String) -> void :
    if not GameManager.character_data_by_name.has(character_name):
        return

    var data: CharacterData = GameManager.character_data_by_name[character_name]
    var calendar: Node = get_node("/root/CalendarManager")
    var current_date: String = calendar.get_current_date_string()

    if not ("aggravated_wounds" in data) or typeof(data.aggravated_wounds) != TYPE_ARRAY:
        var pid_missing: int = GameManager.character_peers.get(character_name, -1)
        if pid_missing != -1:
            var pkt_missing: Dictionary = {
                "message": "[i]Healing failed:[/i] No aggravated wound tracking available.", 
                "speaker": character_name
            }
            get_node("/root/NetworkManager").rpc_id(pid_missing, "receive_message", pkt_missing)
        return

    if data.last_aggravated_heal_date == current_date:
        var pid_lock: int = GameManager.character_peers.get(character_name, -1)
        if pid_lock != -1:
            var pkt_lock: Dictionary = {
                "message": "[i]Healing failed:[/i] You already healed aggravated damage today.", 
                "speaker": character_name
            }
            get_node("/root/NetworkManager").rpc_id(pid_lock, "receive_message", pkt_lock)
        return

    var eligible_indices: Array[int] = []
    for i in data.aggravated_wounds.size():
        var d: String = String(data.aggravated_wounds[i])
        if d < current_date:
            eligible_indices.append(i)

    if eligible_indices.is_empty():
        var pid_none: int = GameManager.character_peers.get(character_name, -1)
        if pid_none != -1:
            var pkt_none: Dictionary = {
                "message": "[i]Healing failed:[/i] You cannot heal aggravated wounds from the same day, or you have none.", 
                "speaker": character_name
            }
            get_node("/root/NetworkManager").rpc_id(pid_none, "receive_message", pkt_none)
        return

    if data.blood_pool < 5:
        var pid_blood: int = GameManager.character_peers.get(character_name, -1)
        if pid_blood != -1:
            var pkt_blood: Dictionary = {
                "message": "[i]Healing failed:[/i] You do not have enough blood (need 5).", 
                "speaker": character_name
            }
            get_node("/root/NetworkManager").rpc_id(pid_blood, "receive_message", pkt_blood)
        return


    var oldest_idx: int = eligible_indices[0]
    var oldest_date: String = String(data.aggravated_wounds[oldest_idx])
    for idx in eligible_indices:
        var d: String = String(data.aggravated_wounds[idx])
        if d < oldest_date:
            oldest_date = d
            oldest_idx = idx

    data.aggravated_wounds.remove_at(oldest_idx)
    data.health_index = max(0, data.health_index - 1)
    data.blood_pool = max(0, data.blood_pool - 5)
    data.last_aggravated_heal_date = current_date


    var idx: int = clamp(data.health_index, 0, data.health_levels.size() - 1)
    var new_level: String = data.health_levels[idx]


    var zone_name: String = data.current_zone
    var zone_data: Dictionary = ZoneManager.zones.get(zone_name, {})
    var characters_in_zone: Array = zone_data.get("characters", [])

    var msg_zone: String = CHAT_DIVIDER + "[b]%s[/b] channels vitae to mend a grievous wound. (blood -5)" % character_name
    var pkt_zone: Dictionary = {
        "message": msg_zone, 
        "speaker": character_name
    }

    var notified: Dictionary = {}
    for cd in characters_in_zone:
        if not cd or not cd.has_method("get"):
            continue
        var char_name: String = cd.name
        var pid: int = GameManager.character_peers.get(char_name, -1)
        if pid != -1 and not notified.has(pid):
            get_node("/root/NetworkManager").rpc_id(pid, "receive_message", pkt_zone)
            notified[pid] = true


    var actor_pid: int = GameManager.character_peers.get(character_name, -1)
    if actor_pid != -1:
        var remaining: int = data.aggravated_wounds.size()
        var pkt_priv: Dictionary = {
            "message": CHAT_DIVIDER + "[b]Aggravated[/b]: Healed 1 from %s. Remaining: %d.\nYou are now [u]%s[/u]."
                %[oldest_date, remaining, new_level], 
            "speaker": character_name
        }
        get_node("/root/NetworkManager").rpc_id(actor_pid, "receive_message", pkt_priv)





func process_st_heal_aggravated(character_name: String, amount: int) -> void :
    if not GameManager.character_data_by_name.has(character_name):
        return

    var data: CharacterData = GameManager.character_data_by_name[character_name]
    if typeof(data.aggravated_wounds) != TYPE_ARRAY or data.aggravated_wounds.is_empty():
        var pid: int = GameManager.character_peers.get(character_name, -1)
        if pid != -1:
            var pkt: Dictionary = {
                "message": "[i]Healing failed:[/i] No aggravated wounds to heal.", 
                "speaker": character_name
            }
            get_node("/root/NetworkManager").rpc_id(pid, "receive_message", pkt)
        return

    var heal_count: int = min(amount, data.aggravated_wounds.size())
    data.aggravated_wounds.sort()
    for i in heal_count:
        if data.aggravated_wounds.is_empty():
            break
        data.aggravated_wounds.remove_at(0)
        data.health_index = max(0, data.health_index - 1)


    var zone_name: String = data.current_zone
    var zone_data: Dictionary = ZoneManager.zones.get(zone_name, {})
    var chars_in_zone: Array = zone_data.get("characters", [])

    var msg_zone: String = CHAT_DIVIDER + "[b]%s[/b] restores %d aggravated wounds with the power of vitae." % [character_name, heal_count]
    var pkt_zone: Dictionary = {
        "message": msg_zone, 
        "speaker": character_name
    }

    var notified: Dictionary = {}
    for cd in chars_in_zone:
        if not cd or not cd.has_method("get"):
            continue
        var cname: String = cd.name
        var pid: int = GameManager.character_peers.get(cname, -1)
        if pid != -1 and not notified.has(pid):
            get_node("/root/NetworkManager").rpc_id(pid, "receive_message", pkt_zone)
            notified[pid] = true


    var actor_pid: int = GameManager.character_peers.get(character_name, -1)
    if actor_pid != -1:
        var remaining: int = data.aggravated_wounds.size()
        var pkt_priv: Dictionary = {
            "message": CHAT_DIVIDER + "[b]Aggravated[/b]: Healed %d wounds. Remaining: %d." % [heal_count, remaining], 
            "speaker": character_name
        }
        get_node("/root/NetworkManager").rpc_id(actor_pid, "receive_message", pkt_priv)
