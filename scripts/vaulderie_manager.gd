extends Node


var active_rituals: Dictionary = {}


signal ritual_updated(zone_name: String, participant_names: Array[String])
signal ritual_canceled(zone_name: String)


func start_ritual(host_name: String, zone_name: String) -> void :
    if active_rituals.has(zone_name):
        print("❌ Ritual already active in zone:", zone_name)
        return

    if not GameManager.character_data_by_name.has(host_name):
        print("❌ Host not found:", host_name)
        return

    var zone: Dictionary = ZoneManager.zones.get(zone_name, {}) as Dictionary
    if zone.is_empty():
        print("❌ Zone not found:", zone_name)
        return

    active_rituals[zone_name] = {
        "host": host_name, 
        "participants": [host_name]
    }

    print("🔮 Vaulderie ritual started by %s in zone: %s" % [host_name, zone_name])


    var characters: Array = zone.get("characters", []) as Array
    var packet: Dictionary = {
        "message": "[i]%s has begun a Vaulderie Ritual![/i]" % host_name, 
        "speaker": "System", 
        "jingle": true
    }
    for char_data in characters:
        if not char_data or not char_data.has_method("get"):
            continue
        var peer_id: int = int(GameManager.character_peers.get(char_data.name, -1))
        if peer_id != -1:
            NetworkManager.rpc_id(peer_id, "receive_message", packet)

    var raw_list: Array = (active_rituals[zone_name]["participants"] as Array)
    var typed_participants: Array[String] = []
    for p in raw_list:
        typed_participants.append(str(p))

    emit_signal("ritual_updated", zone_name, typed_participants)
    debug_print_rituals()



func join_ritual(participant_name: String, zone_name: String) -> void :
    if not active_rituals.has(zone_name):
        print("❌ No active ritual in zone:", zone_name)
        return

    if not GameManager.character_data_by_name.has(participant_name):
        print("❌ Participant not found:", participant_name)
        return

    var zone: Dictionary = ZoneManager.zones.get(zone_name, {}) as Dictionary
    if zone.is_empty():
        print("❌ Zone not found:", zone_name)
        return

    var ritual: Dictionary = active_rituals[zone_name] as Dictionary
    var participants: Array = ritual["participants"] as Array

    if participant_name in participants:
        print("ℹ️ %s is already part of the ritual." % participant_name)
        return

    participants.append(participant_name)
    print("➕ %s joined the ritual in zone: %s" % [participant_name, zone_name])


    var characters: Array = zone.get("characters", []) as Array
    var host_name: String = String(ritual["host"])
    var packet: Dictionary = {
        "message": "[i]%s has joined the Vaulderie Ritual hosted by %s![/i]" % [participant_name, host_name], 
        "speaker": "System", 
        "jingle": true
    }
    for char_data in characters:
        if not char_data or not char_data.has_method("get"):
            continue
        var peer_id: int = int(GameManager.character_peers.get(char_data.name, -1))
        if peer_id != -1:
            NetworkManager.rpc_id(peer_id, "receive_message", packet)

    var typed_participants: Array[String] = []
    for p in participants:
        typed_participants.append(str(p))

    emit_signal("ritual_updated", zone_name, typed_participants)
    debug_print_rituals()



func leave_ritual(participant_name: String, zone_name: String) -> void :
    if not active_rituals.has(zone_name):
        print("❌ No ritual to leave in zone:", zone_name)
        return

    var ritual: Dictionary = active_rituals[zone_name] as Dictionary
    var participants: Array = ritual["participants"] as Array

    if participant_name not in participants:
        print("ℹ️ %s is not part of the ritual in zone: %s" % [participant_name, zone_name])
        return


    var previous_participants: Array[String] = []
    for p in participants:
        previous_participants.append(str(p))


    participants.erase(participant_name)
    print("👋 %s left the ritual in zone: %s" % [participant_name, zone_name])

    var zone: Dictionary = ZoneManager.zones.get(zone_name, {}) as Dictionary
    if zone.is_empty():
        print("❌ Zone not found for message broadcast:", zone_name)
        return

    var characters: Array = zone.get("characters", []) as Array

    if participant_name == String(ritual["host"]) or participants.is_empty():
        active_rituals.erase(zone_name)
        print("❌ Ritual canceled in zone: %s" % zone_name)
        emit_signal("ritual_canceled", zone_name)


        var cancel_packet: Dictionary = {
            "message": "[i]The Vaulderie Ritual has been canceled.[/i]", 
            "speaker": "System", 
            "jingle": true
        }
        for char_data in characters:
            if not char_data or not char_data.has_method("get"):
                continue
            var peer_id: int = int(GameManager.character_peers.get(char_data.name, -1))
            if peer_id != -1:
                NetworkManager.rpc_id(peer_id, "receive_message", cancel_packet)

    else:
        var updated: Array[String] = []
        for p in participants:
            updated.append(str(p))
        emit_signal("ritual_updated", zone_name, updated)


        var leave_packet: Dictionary = {
            "message": "[i]%s has left the Vaulderie Ritual.[/i]" % participant_name, 
            "speaker": "System", 
            "jingle": true
        }
        for char_data in characters:
            if not char_data or not char_data.has_method("get"):
                continue
            var peer_id: int = int(GameManager.character_peers.get(char_data.name, -1))
            if peer_id != -1:
                NetworkManager.rpc_id(peer_id, "receive_message", leave_packet)


    for prev in previous_participants:
        var peer_id: int = int(GameManager.name_to_peer.get(prev, -1))
        if peer_id != -1:
            NetworkManager.rpc_id(peer_id, "receive_vaulderie_participant_list", participants)

    debug_print_rituals()



func debug_print_rituals() -> void :
    print("📜 Active Vaulderie Rituals:")
    if active_rituals.is_empty():
        print("  (None)")
        return

    for zone_name in active_rituals.keys():
        var ritual: Dictionary = active_rituals[zone_name] as Dictionary
        var host: String = String(ritual["host"])
        var participants: Array = ritual["participants"] as Array
        print("  • Zone: %s | Host: %s | Participants: %s" % [zone_name, host, str(participants)])





func perform_vaulderie(zone_name: String) -> void :
    if not active_rituals.has(zone_name):
        print("❌ No active ritual in zone:", zone_name)
        return

    var ritual: Dictionary = active_rituals[zone_name] as Dictionary
    var raw_participants: Array = ritual.get("participants", []) as Array
    var participants: Array[String] = []
    for p in raw_participants:
        participants.append(str(p))


    var calendar: Node = get_node("/root/CalendarManager")
    var today: String = String(calendar.call("get_current_date_string"))


    var zone: Dictionary = ZoneManager.zones.get(zone_name, {}) as Dictionary
    if not zone.is_empty():
        var characters: Array = zone.get("characters", []) as Array
        var performer_name: String = String(ritual.get("host", "Someone"))
        var announce_packet: Dictionary = {
            "message": "[i]%s has performed the Vaulderie Ritual![/i]" % performer_name, 
            "speaker": "System", 
            "jingle": true
        }
        for char_data in characters:
            if not char_data or not char_data.has_method("get"):
                continue
            var peer_id: int = int(GameManager.character_peers.get(char_data.name, -1))
            if peer_id != -1:
                NetworkManager.rpc_id(peer_id, "receive_message", announce_packet)

    for a_name in participants:
        var a_data: CharacterData = GameManager.character_data_by_name.get(a_name, null) as CharacterData
        if a_data == null:
            print("❌ Character data not found for", a_name)
            continue


        var bonds_cleared: bool = false
        if a_data.blood_bonds.size() > 0:
            a_data.blood_bonds.clear()
            bonds_cleared = true

        var message_lines: Array[String] = []
        message_lines.append("Your Vinculum ratings have changed:")
        if bonds_cleared:
            message_lines.append("• All Blood Bonds have been dissolved by the Vaulderie.")

        for b_name in participants:
            if b_name == a_name:
                continue

            var current_rating: int = int(a_data.vinculum.get(b_name, -1))
            var lock_until_str: String = String(a_data.vinculum_lock_until.get(b_name, ""))


            if lock_until_str != "" and today <= lock_until_str:
                if current_rating == -1:
                    message_lines.append("• %s: (unchanged; locked until %s)" % [b_name, lock_until_str])
                else:
                    message_lines.append("• %s: %d → %d (unchanged; locked until %s)" % [b_name, current_rating, current_rating, lock_until_str])
                print("🔒 [%s → %s] Vinculum locked until %s. Skipping change." % [a_name, b_name, lock_until_str])
                continue

            if current_rating == -1:
                var roll_new: int = randi() % 10 + 1
                a_data.vinculum[b_name] = roll_new


                var unlock_date_internal: String = String(calendar.call("date_plus_days", today, 3))
                var unlock_date_display: String = String(calendar.call("date_plus_days", today, 4))
                a_data.vinculum_lock_until[b_name] = unlock_date_internal
                message_lines.append("• %s: %d (new, locked until %s)" % [b_name, roll_new, unlock_date_display])
            else:
                var roll: int = randi() % 10 + 1
                var new_rating: int = current_rating

                if roll > current_rating:
                    new_rating = clamp(current_rating + 1, 1, 10)
                    message_lines.append("• %s: %d → %d" % [b_name, current_rating, new_rating])
                elif roll == 1:
                    new_rating = clamp(current_rating - 1, 1, 10)
                    message_lines.append("• %s: %d → %d" % [b_name, current_rating, new_rating])
                else:
                    message_lines.append("• %s: %d → %d (unchanged)" % [b_name, current_rating, current_rating])

                a_data.vinculum[b_name] = new_rating


                if new_rating != current_rating:
                    var unlock_date_internal: String = String(calendar.call("date_plus_days", today, 3))
                    var unlock_date_display: String = String(calendar.call("date_plus_days", today, 4))
                    a_data.vinculum_lock_until[b_name] = unlock_date_internal
                    message_lines.append("• %s: (locked until %s)" % [b_name, unlock_date_display])

        if GameManager.character_peers.has(a_name):
            var peer_id: int = int(GameManager.character_peers[a_name])
            var dict: Dictionary = a_data.serialize_to_dict()
            NetworkManager.rpc_id(peer_id, "receive_edited_character_data", dict)


            NetworkManager.rpc_id(peer_id, "receive_blood_bond_data", a_name, a_data.blood_bonds.duplicate(true))

            var message_packet: Dictionary = {
                "message": "[b]Vaulderie Results:[/b]\n" + "\n".join(message_lines), 
                "speaker": "Vaulderie", 
                "jingle": true
            }
            NetworkManager.rpc_id(peer_id, "receive_message", message_packet)


            NetworkManager.rpc_id(peer_id, "close_vaulderie_panels")


    active_rituals.erase(zone_name)
    print("🧼 Vaulderie ritual concluded and removed for zone:", zone_name)
