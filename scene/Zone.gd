extends Node

const ZONES_FILE_PATH = "user://zones/zones.tres"
const ZonesDataClass = preload("res://ZonesData.gd")

@rpc("authority")
func receive_zone_category(category: String) -> void :
    MusicManager.set_ambiance_category(category)



# Default zones - will be overridden by external file if it exists
var zones: Dictionary = {}









func _ready():
    _load_zones_from_file()
    print("🧪 Zone list:", zones.keys())
    print("🌐 ZoneManager ready. Is server:", multiplayer.is_server())

func _load_zones_from_file() -> void:
    # Il client non ha bisogno di caricare le zone, le riceve dal server via RPC
    if not "--server" in OS.get_cmdline_args():
        print("ℹ️ [CLIENT] Client mode - zones will be received from server via RPC")
        return
    
    # SERVER: carica le zone dal file
    if FileAccess.file_exists(ZONES_FILE_PATH):
        print("📂 [SERVER] Loading zones from:", ZONES_FILE_PATH)
        var loaded_data = ResourceLoader.load(ZONES_FILE_PATH)
        if loaded_data and loaded_data is ZonesDataClass:
            zones = loaded_data.zones
            print("✅ [SERVER] Zones loaded from external file:", zones.size(), "zones")
        else:
            print("⚠️ [SERVER] External zones file has wrong format (not ZonesData)")
            print("❌ [SERVER] No zones available! Server cannot function properly.")
    else:
        print("❌ [SERVER] No zones file found at:", ZONES_FILE_PATH)
        print("ℹ️ [SERVER] Run export_zones_to_file.tscn to create the zones file")
        print("ℹ️ [SERVER] Zones dictionary is empty - server cannot manage zones!")


func move_character_to_zone(character: Resource, target_zone_name: String) -> void :
    var character_name: String = character.name
    var current_zone_name: String = character.current_zone

    print("🗺️ [Zone] move_character_to_zone():", character_name, " → ", target_zone_name, " (from:", current_zone_name, ")")


    if zones.has(current_zone_name):
        MessagesManager.notify_zone_change("departure", character_name, current_zone_name)

        zones[current_zone_name]["characters"] = zones[current_zone_name]["characters"].filter(
            func(c): return c.name != character_name
        )


    if not zones.has(target_zone_name):
        print("❌ Attempted to move to undefined zone:", target_zone_name)
        return

    var target_zone = zones[target_zone_name]


    if character not in target_zone["characters"]:
        target_zone["characters"].append(character)
        MessagesManager.notify_zone_change("arrival", character_name, target_zone_name)


    character.current_zone = target_zone_name
    character.current_viewpoint = target_zone["default_viewpoint"]


    character.current_zone_category = target_zone.get("category", "")


    var net: = get_node("/root/NetworkManager")
    if net and net.has_method("request_reset_physical_blood_bonuses"):
        print("🩸 [Zone] Resetting blood buffs for:", character_name)

        net.request_reset_physical_blood_bonuses(character_name)
    else:
        print("⚠️ [Zone] NetworkManager missing or method not found; skip blood reset")


    var peer_id = GameManager.character_peers.get(character_name, -1)

    if peer_id == -1:
        print("👻", character_name, "is unassigned (NPC or inactive player). No peer updates sent.")
        return


    rpc_id(peer_id, "receive_zone_category", character.current_zone_category)

    var characters = zones.get(target_zone_name, {}).get("characters", [])
    var names: Array[String] = []
    for other_char in characters:
        if other_char.name != character_name:
            names.append(other_char.name)

    rpc_id(peer_id, "receive_zone_character_list", names)
    NetworkManager.rpc_id(peer_id, "flush_typing_state")

    var vp_id = character.current_viewpoint
    var vp_data = target_zone.get("viewpoints", {}).get(vp_id, {})
    var img_path = vp_data.get("image_path", "")

    rpc_id(peer_id, "receive_viewpoint_image", {
        "image_path": img_path, 
        "char_name": character_name
    })

    NetworkManager.send_character_data_to_peer(character, peer_id)
    print("✅ [Zone] Move complete for", character_name, "→", target_zone_name)




@rpc("authority")
func receive_new_zone_data(zone_name: String, zone_data: Dictionary) -> void :
    ZoneManager.zones[zone_name] = zone_data


    if GameManager.character_data:
        NetworkManager.rpc("request_reset_physical_blood_bonuses", GameManager.character_data.name)



var temp_zone_timers: Dictionary = {}


func start_temp_zone_cleanup_timer(zone_name: String) -> void :
    if temp_zone_timers.has(zone_name):
        return

    var timer: = Timer.new()
    timer.wait_time = 3600.0
    timer.one_shot = false
    timer.autostart = true
    timer.name = "TempZoneTimer_" + zone_name
    timer.timeout.connect(_on_temp_zone_timer_timeout.bind(zone_name))
    add_child(timer)
    temp_zone_timers[zone_name] = timer

func _on_temp_zone_timer_timeout(zone_name: String) -> void :
    if not zones.has(zone_name):
        print("⛔ Temp zone no longer exists:", zone_name)
        _stop_and_remove_temp_timer(zone_name)
        return

    var zone_data: Dictionary = zones[zone_name]
    if zone_data.get("characters", []).is_empty():
        print("🧹 Removing empty temporary zone:", zone_name)
        zones.erase(zone_name)
        _stop_and_remove_temp_timer(zone_name)

func _stop_and_remove_temp_timer(zone_name: String) -> void :
    if temp_zone_timers.has(zone_name):
        var timer: Timer = temp_zone_timers[zone_name]
        timer.queue_free()
        temp_zone_timers.erase(zone_name)

@rpc("any_peer", "reliable")
func receive_zone_character_list(_names: PackedStringArray) -> void :


    pass

@rpc("any_peer", "reliable")
func receive_viewpoint_image(_image_path: String, _description: String, _sound_path: String = "") -> void :

    pass
