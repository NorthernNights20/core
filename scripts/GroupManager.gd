extends Node

const CHAT_DIVIDER: = "[color=gray]────────────────────[/color]\n"



var groups: Dictionary = {}


var pending_invites: Dictionary = {}


signal group_updated(group_name: String, member_names: Array[String])
signal group_disbanded(group_name: String)


func get_group_of(member_name: String) -> String:
    for gname in groups.keys():
        var members: Array = groups[gname].get("members", []) as Array
        if member_name in members:
            return gname
    return ""

func is_in_any_group(char_name: String) -> bool:
    return get_group_of(char_name) != ""

func is_group_founder(char_name: String, group_name: String) -> bool:
    if not groups.has(group_name):
        return false
    return str(groups[group_name].get("founder", "")) == char_name

func _send_system(target_name: String, text: String) -> void :
    var pid: int = GameManager.name_to_peer.get(target_name, -1)
    if pid != -1:
        var msg_packet: Dictionary = {
            "message": CHAT_DIVIDER + "[i]%s[/i]" % text, 
            "speaker": "System", 
            "jingle": true
        }
        NetworkManager.rpc_id(pid, "receive_message", msg_packet)

func _broadcast_to_zone(zone: Dictionary, packet: Dictionary) -> void :
    if zone == null:
        return
    var characters: Array = zone.get("characters", []) as Array
    for char_data in characters:
        if not char_data or not char_data.has_method("get"):
            continue
        var peer_id: int = GameManager.character_peers.get(char_data.name, -1)
        if peer_id != -1:
            NetworkManager.rpc_id(peer_id, "receive_message", packet)


func create_group(founder_name: String, group_name: String) -> void :
    group_name = str(group_name).strip_edges()
    if group_name == "":
        print("❌ Invalid group name")
        return

    if groups.has(group_name):
        print("❌ Group already exists:", group_name)
        return

    if not GameManager.character_data_by_name.has(founder_name):
        print("❌ Founder not found:", founder_name)
        return


    if is_in_any_group(founder_name):
        print("❌ Founder already in a group:", get_group_of(founder_name))
        _send_system(founder_name, "You must leave your current group before creating a new one.")
        return

    var founder_data: CharacterData = GameManager.character_data_by_name[founder_name]
    var zone_name: String = founder_data.current_zone
    var zone: Dictionary = ZoneManager.zones.get(zone_name, null)
    if zone == null:
        print("❌ Zone not found for founder:", zone_name)
        return

    groups[group_name] = {
        "founder": founder_name, 
        "members": [founder_name], 
        "created_at": Time.get_unix_time_from_system()
    }

    print("👥 Group created:", group_name, "by", founder_name)


    var packet_create: Dictionary = {
        "message": CHAT_DIVIDER + "[i]%s has created the group \"%s\".[/i]" % [founder_name, group_name], 
        "speaker": "System", 
        "jingle": true
    }
    _broadcast_to_zone(zone, packet_create)

    var typed_members: Array[String] = []
    for n in groups[group_name]["members"]:
        typed_members.append(str(n))

    emit_signal("group_updated", group_name, typed_members)
    debug_print_groups()


func join_group(member_name: String, group_name: String) -> void :
    if not groups.has(group_name):
        print("❌ Group not found:", group_name)
        return

    if not GameManager.character_data_by_name.has(member_name):
        print("❌ Character not found:", member_name)
        return


    if is_in_any_group(member_name):
        print("❌", member_name, "is already in another group:", get_group_of(member_name))
        _send_system(member_name, "You are already in a group and must leave it before joining another.")
        return

    var data: Dictionary = groups[group_name]


    var raw_members: Array = data.get("members", []) as Array
    var members: Array[String] = []
    for x in raw_members:
        members.append(str(x))

    if member_name in members:
        print("ℹ️", member_name, "is already in group:", group_name)
        return

    members.append(member_name)
    data["members"] = members
    groups[group_name] = data
    print("➕", member_name, "joined group:", group_name)


    var founder_name: String = str(data.get("founder", ""))
    var founder_data: CharacterData = GameManager.character_data_by_name.get(founder_name, null)
    if founder_data != null:
        var zone_name: String = founder_data.current_zone
        var zone: Dictionary = ZoneManager.zones.get(zone_name, null)
        if zone != null:
            var packet_join: Dictionary = {
                "message": CHAT_DIVIDER + "[i]%s has joined the group \"%s\".[/i]" % [member_name, group_name], 
                "speaker": "System", 
                "jingle": true
            }
            _broadcast_to_zone(zone, packet_join)

    emit_signal("group_updated", group_name, members)
    debug_print_groups()


func leave_group(member_name: String, group_name: String) -> void :
    if not groups.has(group_name):
        print("❌ Group not found:", group_name)
        return

    var data: Dictionary = groups[group_name]
    var raw_members: Array = data.get("members", []) as Array

    var members: Array[String] = []
    for x in raw_members:
        members.append(str(x))

    if member_name not in members:
        print("ℹ️", member_name, "is not in group:", group_name)
        return


    var previous_members: Array[String] = []
    for n in members:
        previous_members.append(str(n))

    members.erase(member_name)
    print("👋", member_name, "left group:", group_name)

    var founder_name: String = data["founder"]


    var founder_data: CharacterData = GameManager.character_data_by_name.get(founder_name, null)
    var founder_zone_name: String = founder_data.current_zone if founder_data != null else ""


    if founder_zone_name == "":
        var leaver_data: CharacterData = GameManager.character_data_by_name.get(member_name, null)
        if leaver_data != null:
            founder_zone_name = leaver_data.current_zone

    var founder_zone: Dictionary = ZoneManager.zones.get(founder_zone_name, null)


    if members.is_empty():

        groups.erase(group_name)
        print("❌ Group disbanded:", group_name)
        emit_signal("group_disbanded", group_name)


        var cancel_packet: Dictionary = {
            "message": CHAT_DIVIDER + "[i]The group \"%s\" has been disbanded.[/i]" % group_name, 
            "speaker": "System", 
            "jingle": true
        }
        _broadcast_to_zone(founder_zone, cancel_packet)
    else:


        if member_name == founder_name:
            data["founder"] = members[0]
            _send_system(members[0], "You are now the host of \"%s\"." % group_name)

        data["members"] = members
        groups[group_name] = data

        var updated: Array[String] = []
        for n in members:
            updated.append(str(n))
        emit_signal("group_updated", group_name, updated)


        var leave_packet: Dictionary = {
            "message": CHAT_DIVIDER + "[i]%s has left the group \"%s\".[/i]" % [member_name, group_name], 
            "speaker": "System", 
            "jingle": true
        }
        _broadcast_to_zone(founder_zone, leave_packet)


    var current_members: Array[String] = groups.get(group_name, {}).get("members", []) as Array[String]
    for prev in previous_members:
        var peer_id: int = GameManager.name_to_peer.get(prev, -1)
        if peer_id != -1:
            NetworkManager.rpc_id(peer_id, "receive_group_member_list", current_members)

    debug_print_groups()


@rpc("any_peer")
func request_invite_to_group(inviter_name: String, target_name: String, group_name: String) -> void :

    var inviter_current_group: String = get_group_of(inviter_name)


    if group_name == "" or not groups.has(group_name):

        if inviter_current_group == "":
            var default_group_name: = "%s's Group" % inviter_name

            if groups.has(default_group_name):

                if not is_group_founder(inviter_name, default_group_name):
                    _send_system(inviter_name, "You cannot invite from someone else's group.")
                    return
                group_name = default_group_name
            else:
                create_group(inviter_name, default_group_name)
                group_name = default_group_name
                inviter_current_group = group_name
        else:

            group_name = inviter_current_group


    if not groups.has(group_name):
        print("❌ Group not found:", group_name)
        _send_system(inviter_name, "That group does not exist.")
        return


    if not is_group_founder(inviter_name, group_name):
        print("❌", inviter_name, "tried to invite but is not founder of", group_name)
        _send_system(inviter_name, "Only the group host can invite people.")
        return
    if get_group_of(inviter_name) != group_name:
        print("❌", inviter_name, "not actually in", group_name)
        _send_system(inviter_name, "You are not in that group.")
        return


    if not GameManager.character_data_by_name.has(target_name):
        print("❌ Target not found:", target_name)
        _send_system(inviter_name, "%s is not online." % target_name)
        return
    if is_in_any_group(target_name):
        print("❌", target_name, "is already in a group")
        _send_system(inviter_name, "%s is already in a group and cannot be invited." % target_name)
        return

    var target_pid: int = GameManager.name_to_peer.get(target_name, -1)
    if target_pid == -1:
        _send_system(inviter_name, "%s is not reachable right now." % target_name)
        return


    pending_invites[target_name] = {
        "group_name": group_name, 
        "inviter": inviter_name, 
        "created_at": Time.get_unix_time_from_system()
    }

    var invite_packet: Dictionary = {
        "type": "group_invite", 
        "group_name": group_name, 
        "inviter": inviter_name, 
        "speaker": "System", 
        "message": CHAT_DIVIDER + "[i]%s has invited you to join the group \"%s\". Accept?[/i]" % [inviter_name, group_name], 
        "jingle": true
    }
    NetworkManager.rpc_id(target_pid, "receive_group_invite", invite_packet)
    _send_system(inviter_name, "Invite sent to %s." % target_name)

@rpc("any_peer")
func request_respond_group_invite(target_name: String, accept: bool) -> void :
    var invite: Dictionary = pending_invites.get(target_name, {}) as Dictionary
    if invite.is_empty():
        _send_system(target_name, "No pending invite found.")
        return

    var group_name: String = str(invite.get("group_name", ""))
    var inviter_name: String = str(invite.get("inviter", ""))


    pending_invites.erase(target_name)

    if not accept:
        _send_system(target_name, "You declined the invite to \"%s\"." % group_name)
        if inviter_name != "":
            _send_system(inviter_name, "%s declined the invite." % target_name)
        return


    if not groups.has(group_name):
        _send_system(target_name, "That group no longer exists.")
        return
    if is_in_any_group(target_name):
        _send_system(target_name, "You are already in a group.")
        return

    join_group(target_name, group_name)


func debug_print_groups() -> void :
    print("📜 Active Groups:")
    if groups.is_empty():
        print("  (None)")
        return

    for gname in groups.keys():
        var g: Dictionary = groups[gname]
        var founder: String = g.get("founder", "")
        var members_raw: Array = g.get("members", []) as Array
        var members: Array[String] = []
        for m in members_raw:
            members.append(str(m))
        print("  • Name: %s | Founder: %s | Members: %s" % [gname, founder, str(members)])

func get_group_members(group_name: String) -> Array[String]:
    var out: Array[String] = []
    if not groups.has(group_name):
        return out
    for n in groups[group_name]["members"]:
        out.append(str(n))
    return out

func send_group_members_to_requester(group_name: String, requester_name: String) -> void :
    var members: Array[String] = get_group_members(group_name)
    var formatted: = CHAT_DIVIDER + "[i]Members of [b]%s[/b]:\n• %s[/i]" % [group_name, "\n• ".join(members)]

    var packet: Dictionary = {
        "message": formatted, 
        "speaker": "System", 
        "jingle": true
    }
    var pid: int = GameManager.name_to_peer.get(requester_name, -1)
    if pid != -1:
        NetworkManager.rpc_id(pid, "receive_message", packet)
