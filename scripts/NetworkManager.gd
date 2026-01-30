extends Node

signal zone_character_list_received(names: Array)

signal all_character_names_received(names: Array)

const CHAT_DIVIDER: = "[color=gray]────────────────────[/color]\n"

const EDIT_LOG_DIR: = "user://logs/"
const EDIT_LOG_PATH: = EDIT_LOG_DIR + "character_edits.txt"

func _ready():
    print("🌐 NetworkManager _ready() called")
    print("🌐 Multiplayer ID:", multiplayer.get_unique_id())
    print("🌐 Is Server:", multiplayer.is_server())
    print("🌐 Node Path:", get_path())
    DirAccess.make_dir_recursive_absolute(EDIT_LOG_DIR)


    VaulderieManager.ritual_updated.connect(_on_ritual_updated)
    VaulderieManager.ritual_canceled.connect(_on_ritual_canceled)


@rpc("any_peer")
func register_character(char_name: String, is_storyteller: bool):
    print("Register_Character_Called_Offline")
    if not multiplayer.is_server():
        return

    print("📥 register_character() CALLED")
    print("🔐 Is server?:", multiplayer.is_server())
    print("Registering character:")
    print("  - Name: ", char_name)
    print("  - Is Storyteller: ", is_storyteller)


    var char_data = CharacterData.new()
    print("🧪 CharacterData type:", typeof(char_data))
    print("🧪 Is character_data a Resource?", char_data is Resource)
    print("🧪 Is character_data a Node?", char_data is Node)

    char_data.name = char_name
    char_data.is_storyteller = is_storyteller
    char_data.current_zone = "OOC"
    char_data.is_vampire = true


    GameManager.character_data_by_name[char_name] = char_data
    var peer_id = multiplayer.get_remote_sender_id()
    GameManager.character_peers[char_name] = peer_id
    GameManager.peer_to_character_name[peer_id] = char_name
    print("🧠 Mapping peer → name:", peer_id, "→", GameManager.peer_to_character_name[peer_id])
    print("📜 Full peer_to_character_name:", GameManager.peer_to_character_name)


    ZoneManager.zones["OOC"]["characters"].append(char_data)
    print("✅ Server added", char_data.name, "to OOC")
    print("📋 Server characters in OOC:", ZoneManager.zones["OOC"]["characters"])


signal message_received(data: Dictionary)

@rpc("authority")
func receive_message(data: Dictionary):
    if multiplayer.is_server():
        print("📨 [Server] Received message (not emitting)")
        return

    var content = data.get("message", "")


    var char_data = GameManager.character_data
    if char_data:
        var ui = GameManager.character_uis.get(char_data.name, null)
        if ui and ui.has_method("display_message"):
            ui.display_message(content)


    emit_signal("message_received", data)






@rpc("any_peer")
func handle_incoming_message(data: Dictionary):
    if not multiplayer.is_server():
        return

    var message_type = data.get("type", "")

    match message_type:
        "speak":
            MessagesManager.process_speak(data)
        "whisper":
            MessagesManager.process_whisper(data)
        "emote":
            MessagesManager.process_emote(data)
        "ooc":
            MessagesManager.process_ooc(data)
        "tell":
            MessagesManager.process_tell(data)
        "describe":
            MessagesManager.process_describe(data)
        _:
            print("❌ Unknown message type received:", message_type)




signal zone_name_received(zone_name: String)
signal zone_description_received(desc: String)

@rpc("any_peer")
func request_zone_name(char_name: String):
    if not GameManager.character_data_by_name.has(char_name):
        return
    var zone_name = GameManager.character_data_by_name[char_name].current_zone
    var peer_id = GameManager.character_peers.get(char_name, -1)
    if peer_id != -1:
        rpc_id(peer_id, "receive_zone_name", zone_name)

@rpc("any_peer")
func request_zone_character_list(char_name: String):
    if not GameManager.character_data_by_name.has(char_name):
        print("❌ Unknown character")
        return

    var peer_id = GameManager.character_peers.get(char_name, -1)
    if peer_id == -1:
        print("❌ No peer found for", char_name)
        return

    var mode = GameManager.current_mode_by_peer.get(peer_id, "whisper")
    print("🛰️  Mode for", char_name, "is", mode)
    var zone_name = GameManager.character_data_by_name[char_name].current_zone
    var zone_data = ZoneManager.zones.get(zone_name, {})
    var characters = zone_data.get("characters", [])
    var is_neighborhood = zone_data.get("is_neighborhood", false)

    if is_neighborhood:
        rpc_id(peer_id, "receive_zone_character_list", ["The city stretches all around you."])
        return

    print("🗺️  Characters in zone '%s':" % zone_name)
    for character in characters:
        print("  -", character.name, "| is_storyteller:", character.is_storyteller)

    var names: = []
    for char_data in characters:
        if char_data.name == char_name:
            continue

        if mode == "possess":
            if not char_data.is_storyteller and not GameManager.possessed_characters.has(char_data.name):
                names.append(char_data.name)
        else:
            names.append(char_data.name)

    print("🎯 Final selectable names:", names)
    rpc_id(peer_id, "receive_zone_character_list", names)


@rpc("any_peer")
func request_zone_description(char_name: String):
    if not GameManager.character_data_by_name.has(char_name):
        print("❌ Unknown character:", char_name)
        return

    var char_data = GameManager.character_data_by_name[char_name]
    var zone_id = char_data.current_zone
    var viewpoint_id = char_data.current_viewpoint

    if not ZoneManager.zones.has(zone_id):
        print("❌ Unknown zone:", zone_id)
        return

    var zone_data = ZoneManager.zones[zone_id]
    var viewpoints_dict = zone_data.get("viewpoints", {})

    var viewpoint_data = viewpoints_dict.get(viewpoint_id, null)

    var description = ""
    var sound_path = ""

    if viewpoint_data != null:
        description = viewpoint_data.get("description", "No description available.")
        sound_path = viewpoint_data.get("sound_path", "")
    else:
        description = "(This viewpoint has no description.)"
        print("⚠ Viewpoint missing from zone definition.")

    var peer_id = GameManager.character_peers.get(char_name, -1)
    if peer_id != -1:
        var packet = {
            "description": description, 
            "sound_path": sound_path
        }
        rpc_id(peer_id, "receive_zone_description", packet)
    else:
        print("⚠ No peer ID found for", char_name)



@rpc("authority")
func receive_zone_name(zone_name: String):
    emit_signal("zone_name_received", zone_name)

@rpc("authority")
func receive_zone_character_list(names: Array):
    emit_signal("zone_character_list_received", names)

@rpc("authority")
func receive_zone_description(data: Dictionary):
    emit_signal("zone_description_received", data)

signal zone_info_received(zone_name: String, zone_info: Dictionary)

@rpc("any_peer")
func request_zone_info(char_name: String, zone_name: String):
    if not GameManager.character_data_by_name.has(char_name):
        print("❌ Unknown character:", char_name)
        return
    
    var peer_id = GameManager.character_peers.get(char_name, -1)
    if peer_id == -1:
        print("❌ No peer found for", char_name)
        return
    
    var zone_info = ZoneManager.zones.get(zone_name, {})
    if zone_info.is_empty():
        print("❌ Unknown zone:", zone_name)
        return
    
    # Invia solo i dati necessari, non i personaggi per evitare sovraccarico
    var safe_zone_info = {
        "is_neighborhood": zone_info.get("is_neighborhood", false),
        "category": zone_info.get("category", ""),
        "default_viewpoint": zone_info.get("default_viewpoint", ""),
        "connected_zones": zone_info.get("connected_zones", [])
    }
    
    rpc_id(peer_id, "receive_zone_info", zone_name, safe_zone_info)

@rpc("authority")
func receive_zone_info(zone_name: String, zone_info: Dictionary):
    emit_signal("zone_info_received", zone_name, zone_info)

@rpc("any_peer")
func request_zone_move_to(character_name: String, target_zone_or_character: String, move_reason: String = "standard") -> void :
    if not GameManager.character_data_by_name.has(character_name):
        print("❌ Move request from unknown character:", character_name)
        return

    var char_data = GameManager.character_data_by_name[character_name]
    var old_zone = char_data.current_zone
    var final_target_zone: = ""

    match move_reason:
        "standard":
            var current_zone_data: Dictionary = ZoneManager.zones.get(old_zone, {}) as Dictionary
            var connected_zones: Array = current_zone_data.get("connected_zones", []) as Array
            if target_zone_or_character not in connected_zones:
                print("❌ Illegal move from", old_zone, "to", target_zone_or_character)
                return
            final_target_zone = target_zone_or_character

        "spawn", "teleport":
            final_target_zone = target_zone_or_character

        "load":
            var current_zone_data_load: Dictionary = ZoneManager.zones.get(old_zone, {}) as Dictionary
            var _connected_zones: Array = current_zone_data_load.get("connected_zones", []) as Array
            print("📥 Load move: skipping connection check between", old_zone, "and", target_zone_or_character)
            final_target_zone = target_zone_or_character

        "to_character":
            if not GameManager.character_data_by_name.has(target_zone_or_character):
                print("❌ Cannot teleport to unknown character:", target_zone_or_character)
                return
            var target_char = GameManager.character_data_by_name[target_zone_or_character]
            final_target_zone = target_char.current_zone

        "summon":
            var summon_peer_id = multiplayer.get_remote_sender_id()
            var summoner_name = GameManager.peer_to_character_name.get(summon_peer_id, "")
            var summoner_data = GameManager.character_data_by_name.get(summoner_name, null)

            if summoner_data == null or not summoner_data.is_storyteller:
                print("❌ Summon denied - not a storyteller")
                return

            final_target_zone = summoner_data.current_zone

        "secret":
            var password: = target_zone_or_character.to_lower()
            var match_found: = false

            for zone_name in ZoneManager.zones:
                var zone: Dictionary = ZoneManager.zones[zone_name] as Dictionary
                var passwords: Array = zone.get("secret_entry_passwords", []) as Array
                var allowed_origins: Array = zone.get("accessible_from_zones", []) as Array

                for pw in passwords:
                    if String(pw).to_lower() == password and old_zone in allowed_origins:
                        final_target_zone = zone_name
                        match_found = true
                        break
                if match_found:
                    break

            if not match_found:
                print("❌ Invalid secret move attempt from", old_zone, "with password:", password)
                return
        _:
            print("❌ Unknown move reason:", move_reason)
            return


    ZoneManager.move_character_to_zone(char_data, final_target_zone)


    var zone_dict_for_vp: Dictionary = ZoneManager.zones.get(final_target_zone, {}) as Dictionary
    var viewpoints_dict: Dictionary = zone_dict_for_vp.get("viewpoints", {}) as Dictionary
    var valid_viewpoints: Array = viewpoints_dict.keys() as Array
    if valid_viewpoints.find(char_data.current_viewpoint) == -1:
        if valid_viewpoints.size() > 0:
            char_data.current_viewpoint = String(valid_viewpoints[0])
            print("🔄 Auto-switched viewpoint to:", char_data.current_viewpoint)
        else:
            char_data.current_viewpoint = ""
            print("⚠ No valid viewpoints in zone:", final_target_zone)

    print("📦 Moved", character_name, "from", old_zone, "to", final_target_zone, "due to", move_reason)

    var peer_id = GameManager.character_peers.get(character_name, -1)
    if peer_id != -1:
        rpc_id(peer_id, "receive_zone_name", final_target_zone)

        var zone_dict: Dictionary = ZoneManager.zones.get(final_target_zone, {}) as Dictionary


        var category: String = zone_dict.get("category", "")
        var is_neighborhood: bool = zone_dict.get("is_neighborhood", false)
        rpc_id(peer_id, "receive_zone_meta", {
            "category": category, 
            "is_neighborhood": is_neighborhood
        })

        if not zone_dict.get("is_neighborhood", false):
            var characters: Array = zone_dict.get("characters", []) as Array
            var names: Array[String] = []
            for other_char in characters:
                if other_char and other_char.name != character_name:
                    names.append(other_char.name)
            rpc_id(peer_id, "receive_zone_character_list", names)

        var vp_id: String = String(char_data.current_viewpoint)
        var vp_data: Dictionary = viewpoints_dict.get(vp_id, {}) as Dictionary
        var img_path: String = vp_data.get("image_path", "") as String

        rpc_id(peer_id, "receive_viewpoint_image", {
            "image_path": img_path, 
            "char_name": character_name
        })

        send_character_data_to_peer(char_data, peer_id)

signal zone_meta_received(category: String, is_neighborhood: bool)

@rpc("authority")
func receive_zone_meta(payload: Dictionary) -> void :
    var category: String = String(payload.get("category", ""))
    var is_neighborhood: bool = bool(payload.get("is_neighborhood", false))
    emit_signal("zone_meta_received", category, is_neighborhood)




@rpc("any_peer")
func request_create_character(data: Dictionary, st_name: String) -> void :
    if not multiplayer.is_server():
        return

    var sender_id: int = multiplayer.get_remote_sender_id()
    print("🧾 Received character creation request from:", st_name, "(peer ID:", sender_id, ")")
    print("📥 Raw data:", data)


    if st_name == "":
        print("❌ No Storyteller name provided")
        return
    var sender_data: CharacterData = GameManager.character_data_by_name.get(st_name, null)
    if sender_data == null or not sender_data.is_storyteller:
        print("❌ Creation denied - not a registered Storyteller")
        return


    var new_name: String = String(data.get("name", "")).strip_edges()
    if new_name == "":
        print("❌ Creation failed - no name provided")
        return
    if GameManager.character_data_by_name.has(new_name):
        print("❌ Character already exists:", new_name)
        return

    var new_char: CharacterData = CharacterData.new()


    var prop_names: Dictionary = {}
    for p in new_char.get_property_list():
        var pd: Dictionary = p
        prop_names[String(pd.get("name", ""))] = true


    if prop_names.has("name"):
        new_char.name = new_name
    if prop_names.has("clan"):
        new_char.clan = String(data.get("clan", ""))
    if prop_names.has("sect"):
        new_char.sect = String(data.get("sect", ""))
    if prop_names.has("nature"):
        new_char.nature = String(data.get("nature", ""))
    if prop_names.has("demeanor"):
        new_char.demeanor = String(data.get("demeanor", ""))
    if prop_names.has("path_name"):
        new_char.path_name = String(data.get("path_name", ""))
    if prop_names.has("description"):
        new_char.description = String(data.get("description", ""))


    if prop_names.has("current_zone"):
        new_char.current_zone = sender_data.current_zone
    if prop_names.has("current_zone_category"):
        new_char.current_zone_category = sender_data.current_zone_category
    if prop_names.has("is_storyteller"):
        new_char.is_storyteller = false


    for attr in ["strength", "dexterity", "stamina", "charisma", "manipulation", "appearance", "perception", "intelligence", "wits"]:
        if prop_names.has(attr):
            var v_any: Variant = data.get(attr, 1)
            var v: int
            if typeof(v_any) == TYPE_INT:
                v = v_any
            else:
                v = int(v_any)
            new_char.set(attr, clampi(v, 0, 10))


    for virtue in ["conscience", "self_control", "courage", "conviction", "instinct"]:
        if prop_names.has(virtue):
            var v_any2: Variant = data.get(virtue, 1)
            var v2: int
            if typeof(v_any2) == TYPE_INT:
                v2 = v_any2
            else:
                v2 = int(v_any2)
            new_char.set(virtue, clampi(v2, 0, 10))


    if prop_names.has("path"):
        var v_path_any: Variant = data.get("path", 1)
        var v_path: int
        if typeof(v_path_any) == TYPE_INT:
            v_path = v_path_any
        else:
            v_path = int(v_path_any)
        new_char.path = clampi(v_path, 0, 10)

    if prop_names.has("generation"):
        var v_gen_any: Variant = data.get("generation", 0)
        var v_gen: int
        if typeof(v_gen_any) == TYPE_INT:
            v_gen = v_gen_any
        else:
            v_gen = int(v_gen_any)
        new_char.generation = clampi(v_gen, 3, 13)

    if prop_names.has("blood_pool"):
        var v_bp_any: Variant = data.get("blood_pool", 0)
        var v_bp: int
        if typeof(v_bp_any) == TYPE_INT:
            v_bp = v_bp_any
        else:
            v_bp = int(v_bp_any)
        new_char.blood_pool = clampi(v_bp, 0, 50)

    if prop_names.has("blood_pool_max"):
        var v_bpm_any: Variant = data.get("blood_pool_max", 0)
        var v_bpm: int
        if typeof(v_bpm_any) == TYPE_INT:
            v_bpm = v_bpm_any
        else:
            v_bpm = int(v_bpm_any)
        new_char.blood_pool_max = clampi(v_bpm, 0, 50)

    if prop_names.has("blood_per_turn"):
        var v_bpt_any: Variant = data.get("blood_per_turn", 1)
        var v_bpt: int
        if typeof(v_bpt_any) == TYPE_INT:
            v_bpt = v_bpt_any
        else:
            v_bpt = int(v_bpt_any)
        new_char.blood_per_turn = clampi(v_bpt, 0, 10)

    if prop_names.has("willpower_current"):
        var v_wpc_any: Variant = data.get("willpower_current", 0)
        var v_wpc: int
        if typeof(v_wpc_any) == TYPE_INT:
            v_wpc = v_wpc_any
        else:
            v_wpc = int(v_wpc_any)
        new_char.willpower_current = clampi(v_wpc, 0, 10)

    if prop_names.has("willpower_max"):
        var v_wpm_any: Variant = data.get("willpower_max", 0)
        var v_wpm: int
        if typeof(v_wpm_any) == TYPE_INT:
            v_wpm = v_wpm_any
        else:
            v_wpm = int(v_wpm_any)
        new_char.willpower_max = clampi(v_wpm, 0, 10)

    if prop_names.has("experience_points"):
        var v_xp_any: Variant = data.get("experience_points", 0)
        var v_xp: int
        if typeof(v_xp_any) == TYPE_INT:
            v_xp = v_xp_any
        else:
            v_xp = int(v_xp_any)
        new_char.experience_points = clampi(v_xp, 0, 9999)

    if prop_names.has("health_index"):
        var v_hi_any: Variant = data.get("health_index", 7)
        var v_hi: int
        if typeof(v_hi_any) == TYPE_INT:
            v_hi = v_hi_any
        else:
            v_hi = int(v_hi_any)
        new_char.health_index = clampi(v_hi, 0, 999)


    var all_abilities: Array[String] = [
        "alertness", "athletics", "awareness", "brawl", "empathy", "expression", "intimidation", "leadership", "streetwise", "subterfuge", 
        "animal_ken", "crafts", "drive", "etiquette", "firearms", "larceny", "melee", "performance", "stealth", "survival", 
        "academics", "computer", "finance", "investigation", "law", "medicine", "occult", "politics", "science", "technology"
    ]
    for ab in all_abilities:
        if prop_names.has(ab):
            var v_any3: Variant = data.get(ab, 0)
            var v3: int
            if typeof(v_any3) == TYPE_INT:
                v3 = v_any3
            else:
                v3 = int(v_any3)
            new_char.set(ab, clampi(v3, 0, 10))


    var bgs: Array[String] = [
        "allies", "contacts", "domain", "fame", "generation_background", "haven", "herd", 
        "influence", "mentor", "resources", "retainers", "rituals", "status"
    ]
    for bg in bgs:
        if prop_names.has(bg):
            var v_any4: Variant = data.get(bg, 0)
            var v4: int
            if typeof(v_any4) == TYPE_INT:
                v4 = v_any4
            else:
                v4 = int(v_any4)
            new_char.set(bg, clampi(v4, 0, 10))


    if prop_names.has("disciplines") and data.has("disciplines"):
        var disc_data: Dictionary = data.get("disciplines", {})
        if typeof(disc_data) == TYPE_DICTIONARY:
            if typeof(new_char.disciplines) != TYPE_DICTIONARY:
                new_char.disciplines = {}
            for disc in disc_data.keys():
                var raw_val: Variant = disc_data[disc]
                var val: int
                if typeof(raw_val) == TYPE_INT:
                    val = raw_val
                else:
                    val = int(raw_val)
                new_char.disciplines[String(disc)] = clampi(val, 0, 10)




    if prop_names.has("blood_bonds"):
        var bb_in: Variant = data.get("blood_bonds", {})
        if typeof(bb_in) == TYPE_DICTIONARY:
            var bb_out: Dictionary = {}
            for k in bb_in.keys():
                bb_out[String(k)] = int(bb_in[k])
            new_char.blood_bonds = bb_out

    if prop_names.has("vinculum"):
        var vin_in: Variant = data.get("vinculum", {})
        if typeof(vin_in) == TYPE_DICTIONARY:
            var vin_out: Dictionary = {}
            for k in vin_in.keys():
                vin_out[String(k)] = int(vin_in[k])
            new_char.vinculum = vin_out


    if prop_names.has("derangements"):
        var der_in: Variant = data.get("derangements", [])
        if typeof(der_in) == TYPE_ARRAY:
            var der_out: Array[String] = []
            for e in der_in:
                der_out.append(String(e))
            new_char.derangements = der_out

    if prop_names.has("merits"):
        var mer_in: Variant = data.get("merits", [])
        if typeof(mer_in) == TYPE_ARRAY:
            var mer_out: Array[String] = []
            for e in mer_in:
                mer_out.append(String(e))
            new_char.merits = mer_out

    if prop_names.has("flaws"):
        var flw_in: Variant = data.get("flaws", [])
        if typeof(flw_in) == TYPE_ARRAY:
            var flw_out: Array[String] = []
            for e in flw_in:
                flw_out.append(String(e))
            new_char.flaws = flw_out

    if prop_names.has("ability_specialties"):
        var spec_in: Variant = data.get("ability_specialties", [])
        if typeof(spec_in) == TYPE_ARRAY:
            var spec_out: Array[String] = []
            for e in spec_in:
                spec_out.append(String(e))
            new_char.ability_specialties = spec_out

    if prop_names.has("thaumaturgy_paths"):
        var tpaths_in: Variant = data.get("thaumaturgy_paths", [])
        if typeof(tpaths_in) == TYPE_ARRAY:
            var tpaths_out: Array[String] = []
            for e in tpaths_in:
                tpaths_out.append(String(e))
            new_char.thaumaturgy_paths = tpaths_out

    if prop_names.has("thaumaturgy_rituals"):
        var trits_in: Variant = data.get("thaumaturgy_rituals", [])
        if typeof(trits_in) == TYPE_ARRAY:
            var trits_out: Array[String] = []
            for e in trits_in:
                trits_out.append(String(e))
            new_char.thaumaturgy_rituals = trits_out

    if prop_names.has("necromancy_paths"):
        var npaths_in: Variant = data.get("necromancy_paths", [])
        if typeof(npaths_in) == TYPE_ARRAY:
            var npaths_out: Array[String] = []
            for e in npaths_in:
                npaths_out.append(String(e))
            new_char.necromancy_paths = npaths_out

    if prop_names.has("necromancy_rituals"):
        var nrits_in: Variant = data.get("necromancy_rituals", [])
        if typeof(nrits_in) == TYPE_ARRAY:
            var nrits_out: Array[String] = []
            for e in nrits_in:
                nrits_out.append(String(e))
            new_char.necromancy_rituals = nrits_out


    if prop_names.has("ritae_auctoritas_known"):
        var ra_in: Variant = data.get("ritae_auctoritas_known", [])
        if typeof(ra_in) == TYPE_ARRAY:
            var ra_out: Array[String] = []
            for e in ra_in:
                ra_out.append(String(e))
            new_char.ritae_auctoritas_known = ra_out

    if prop_names.has("ritae_ignoblis_known"):
        var ri_in: Variant = data.get("ritae_ignoblis_known", [])
        if typeof(ri_in) == TYPE_ARRAY:
            var ri_out: Array[String] = []
            for e in ri_in:
                ri_out.append(String(e))
            new_char.ritae_ignoblis_known = ri_out

    if prop_names.has("inventory"):
        var inv_in: Variant = data.get("inventory", [])
        if typeof(inv_in) == TYPE_ARRAY:
            var inv_out: Array[String] = []
            for e in inv_in:
                inv_out.append(String(e))
            new_char.inventory = inv_out

    if prop_names.has("health_levels"):
        var hl_in: Variant = data.get("health_levels", [])
        if typeof(hl_in) == TYPE_ARRAY:
            var hl_out: Array[String] = []
            for e in hl_in:
                hl_out.append(String(e))
            new_char.health_levels = hl_out


    GameManager.character_data_by_name[new_char.name] = new_char
    GameManager.character_peers[new_char.name] = -1
    print("✅ Registered character:", new_char.name)
    print("🧭 Zone:", new_char.current_zone)
    print("🗺️  All characters now:", GameManager.character_data_by_name.keys())


    request_zone_move_to(new_char.name, new_char.current_zone, "spawn")


    rpc_id(sender_id, "receive_message", {"message": "[b]Character created:[/b] " + new_char.name})


@rpc("any_peer")
func request_possess(target_name: String):
    if not multiplayer.is_server():
        print("🚫 Not server — ignoring possession request.")
        return

    var sender_id = multiplayer.get_remote_sender_id()
    print("📩 Possession request from peer:", sender_id)

    var current_name = GameManager.peer_to_character_name.get(sender_id, "")
    print("🧠 Current character name for sender:", current_name)
    if current_name == "":
        print("❌ No mapped character name for sender")
        return

    var st_data = GameManager.character_data_by_name.get(current_name, null)
    var target_data = GameManager.character_data_by_name.get(target_name, null)

    if st_data == null:
        print("❌ ST character data not found for:", current_name)
        return
    if target_data == null:
        print("❌ Target character not found:", target_name)
        return
    if target_data.possessed_by != "":
        print("❌ Target already possessed:", target_data.possessed_by)
        return


    GameManager.storyteller_original_forms[current_name] = st_data
    GameManager.possessed_characters[current_name] = target_data.name
    target_data.possessed_by = current_name

    print("💾 Stored original ST data under:", current_name)
    print("📌 Marked", current_name, "as now possessing", target_data.name)


    GameManager.character_peers[target_data.name] = sender_id
    GameManager.peer_to_character_name[sender_id] = target_data.name
    GameManager.name_to_peer[target_data.name] = sender_id

    print("🧠", current_name, "is now possessing", target_data.name)
    print("📦 character_peers:", GameManager.character_peers)
    print("📦 peer_to_character_name:", GameManager.peer_to_character_name)


    rpc_id(sender_id, "receive_message", {
        "message": "[i]You are now possessing " + target_data.name + "[/i]"
    })


    var serialized = serialize_character_data(target_data)
    print("📤 Sending possessed data to client for:", target_data.name)
    rpc_id(sender_id, "update_character_data_from_possession", serialized)

func serialize_character_data(data: CharacterData) -> Dictionary:
    var dict: = {}
    for property in data.get_property_list():
        var prop_name = property.name
        if prop_name == "script":
            continue
        dict[prop_name] = data.get(prop_name)
    return dict



func deserialize_character_data(dict: Dictionary) -> CharacterData:
    var new_data = CharacterData.new()
    new_data.set_path("")

    for key in dict.keys():
        if key in new_data:
            var value = dict[key]


            if typeof(value) == TYPE_OBJECT and value is Resource:
                print("⚠️ Skipping resource assignment for:", key)
                continue


            new_data.set(key, value)
        else:
            print("⚠️ Unknown property during deserialization:", key)

    return new_data








@rpc("authority")
func update_character_data_from_possession(data_dict: Dictionary) -> void :
    call_deferred("_delayed_update_character_data", data_dict)


func _delayed_update_character_data(data_dict: Dictionary) -> void :
    await get_tree().process_frame

    var main_ui = get_node_or_null("/root/MainUI")
    if main_ui == null:
        print("❌ MainUI still not found — aborting character update")
        return

    var restored_name = data_dict.get("name", "UNKNOWN")
    print("🧠 update_character_data_from_possession triggered for:", restored_name)

    var new_data = deserialize_character_data(data_dict)


    GameManager.character_data = new_data
    print("✅ GameManager.character_data set to:", new_data.name)


    var my_peer_id = multiplayer.get_unique_id()
    GameManager.peer_to_character_name[my_peer_id] = new_data.name
    print("📌 Updated peer_to_character_name[", my_peer_id, "] =", new_data.name)


    main_ui.set_character_data(new_data)




@rpc("any_peer")
func request_release_control():
    if not multiplayer.is_server():
        print("🚫 Not server — aborting release.")
        return

    var sender_id = multiplayer.get_remote_sender_id()
    print("🛰️ request_release_control from peer:", sender_id)

    var current_name = GameManager.peer_to_character_name.get(sender_id, "")
    print("🧾 Lookup peer_to_character_name[", sender_id, "] =", current_name)
    if current_name == "":
        print("❌ Unknown sender — no character mapped to peer ID.")
        return

    var possessed_data: CharacterData = GameManager.character_data_by_name.get(current_name, null)
    if possessed_data == null:
        print("❌ No CharacterData found for current_name:", current_name)
        return

    var st_name = possessed_data.possessed_by
    print("🧾 possessed_by =", st_name)
    if st_name == "":
        print("❌ Character is not currently possessed by anyone.")
        return

    var original_data: CharacterData = GameManager.storyteller_original_forms.get(st_name, null)
    if original_data == null:
        print("❌ No original data found for ST:", st_name)
        print("🧾 storyteller_original_forms keys:", GameManager.storyteller_original_forms.keys())
        return

    print("🧠 Releasing possession:")
    print("    ST name      :", st_name)
    print("    Possessed    :", current_name)
    print("    Original name:", original_data.name)


    possessed_data.possessed_by = ""
    print("🧹 Cleared possessed_by on:", current_name)


    GameManager.character_peers[original_data.name] = sender_id
    GameManager.peer_to_character_name[sender_id] = original_data.name
    GameManager.name_to_peer[original_data.name] = sender_id


    GameManager.possessed_characters.erase(st_name)
    GameManager.storyteller_original_forms.erase(st_name)

    print("✅ Released possession:")
    print("    Reassigned control to:", original_data.name)
    print("📦 character_peers:", GameManager.character_peers)
    print("📦 peer_to_character_name:", GameManager.peer_to_character_name)


    var serialized = serialize_character_data(original_data)
    print("📤 Sending character data back to client:", serialized.get("name", "UNKNOWN"))
    rpc_id(sender_id, "update_character_data_from_possession", serialized)

    rpc_id(sender_id, "receive_message", {
        "message": "[i]You have returned to your original form.[/i]"
    })







func send_character_data_to_peer(char_data: CharacterData, peer_id: int):

    GameManager.name_to_peer[char_data.name] = peer_id
    GameManager.peer_to_character_name[peer_id] = char_data.name


    var dict = serialize_character_data(char_data)
    rpc_id(peer_id, "update_character_data_from_possession", dict)


@rpc("any_peer")
func set_peer_mode(mode: String):
    var peer_id = multiplayer.get_remote_sender_id()
    GameManager.current_mode_by_peer[peer_id] = mode


@rpc("any_peer")
func request_delete_character(target_name: String):
    if not multiplayer.is_server():
        return

    var peer_id = multiplayer.get_remote_sender_id()
    var sender_name = GameManager.peer_to_character_name.get(peer_id, "")
    var sender_data = GameManager.character_data_by_name.get(sender_name, null)
    var target_data = GameManager.character_data_by_name.get(target_name, null)

    if sender_data == null or not sender_data.is_storyteller:
        print("❌ Not authorized to delete:", sender_name)
        return

    if target_data == null:
        print("❌ Target does not exist:", target_name)
        return

    if target_data.is_storyteller:
        print("❌ Cannot delete storyteller characters")
        return

    if target_data.possessed_by != "":
        print("❌ Cannot delete a possessed character")
        return


    var zone = target_data.current_zone
    if ZoneManager.zones.has(zone):
        ZoneManager.zones[zone]["characters"] = ZoneManager.zones[zone]["characters"].filter(
            func(c): return c.name != target_name
        )


    GameManager.character_data_by_name.erase(target_name)
    GameManager.character_peers.erase(target_name)

    print("🗑️ Deleted character:", target_name)

    rpc_id(peer_id, "receive_message", {
        "message": "[i]Deleted character: %s[/i]" % target_name
    })

signal stat_value_received(stat_name: String, value: int)


func request_stat_value(character_name: String, stat_name: String) -> void :
    if multiplayer.is_server():

        var character_data = GameManager.character_data_by_name.get(character_name, null)
        if character_data:
            var value = _resolve_stat_value(character_data, stat_name)
            emit_signal("stat_value_received", stat_name, value)
    else:
        rpc_id(1, "request_stat_value_server", multiplayer.get_unique_id(), character_name, stat_name)


@rpc("any_peer")
func request_stat_value_server(peer_id: int, character_name: String, stat_name: String) -> void :
    if not multiplayer.is_server():
        return

    var character_data = GameManager.character_data_by_name.get(character_name, null)
    if character_data == null:
        print("⚠ Unknown character:", character_name)
        return

    var value = _resolve_stat_value(character_data, stat_name)
    rpc_id(peer_id, "receive_stat_value", stat_name, value)


func _resolve_stat_value(character_data: Resource, stat_name: Variant) -> int:
    if typeof(stat_name) != TYPE_STRING:
        print("❌ Stat name is not a string:", stat_name)
        return 0

    var lower_name: String = stat_name.to_lower().replace(" ", "_")


    for prop in character_data.get_property_list():
        if prop.name == lower_name:
            return character_data.get(lower_name)


    if character_data.has_method("get"):
        var abilities: Dictionary = character_data.get("abilities") if character_data.has_property("abilities") else {}

        if typeof(abilities) == TYPE_DICTIONARY:
            if abilities.has(stat_name):
                return abilities[stat_name]
            var normalized_key: String = lower_name
            if abilities.has(normalized_key):
                return abilities[normalized_key]

    print("⚠ Stat not found on character:", stat_name)
    return 0






@rpc("any_peer")
func request_dice_roll(character_name: String, attr_name: String, ability_name: String, difficulty: int, mode: int, custom_pool_1: = 0, custom_pool_2: = 0, use_specialization: bool = false, use_willpower: bool = false) -> void :
    if not multiplayer.is_server():
        return

    var character_data = GameManager.character_data_by_name.get(character_name, null)
    if character_data == null:
        print("❌ Character not found for roll:", character_name)
        return

    var attr_val: = 0
    var ability_val: = 0
    var total_dice: = 0
    var penalty: = 0


    var is_custom: = (attr_name == "Custom" and ability_name == "Custom")
    if is_custom:
        attr_val = clamp(custom_pool_1, 0, 20)
        ability_val = clamp(custom_pool_2, 0, 20)
    else:
        attr_val = _resolve_stat_value(character_data, attr_name)
        ability_val = _resolve_stat_value(character_data, ability_name)


        match character_data.health_index:
            2, 3:
                penalty = 1
            4, 5:
                penalty = 2
            6:
                penalty = 5
            7:
                penalty = 999

    total_dice = max(0, attr_val + ability_val - penalty)


    var spec_active: = use_specialization and not is_custom and ability_val >= 4


    var bonus_successes: = 0
    if use_willpower and not is_custom and character_data.willpower_current > 0:
        character_data.willpower_current -= 1
        bonus_successes = 1
        GameManager.emit_signal("character_updated", character_name)


    var rolls: Array[int] = []
    var successes: = 0
    var ones_count: = 0
    var rand = RandomNumberGenerator.new()
    rand.randomize()

    for i in total_dice:
        var roll = rand.randi_range(1, 10)
        rolls.append(roll)

        if roll == 1:
            ones_count += 1


        if roll >= difficulty:
            successes += 1


            if spec_active:
                if roll == 10:
                    successes += 1
                elif ability_val >= 5 and roll == 9 and difficulty <= 9:
                    successes += 1

    successes += bonus_successes


    var effective_ones: = ones_count
    if spec_active and ones_count > 0:
        effective_ones = ones_count - 1

    var net_successes: = successes - effective_ones


    var is_botch: = successes == 0 and ones_count > 0


    var result_type: = ""
    if is_botch:
        result_type = "Botch"
    elif net_successes <= 0:
        result_type = "Failure"
    elif net_successes == 1:
        result_type = "Marginal Success"
    elif net_successes == 2:
        result_type = "Moderate Success"
    elif net_successes == 3:
        result_type = "Complete Success"
    elif net_successes == 4:
        result_type = "Exceptional Success"
    else:
        result_type = "Phenomenal Success"


    var data: = {
        "speaker": character_name, 
        "attribute": attr_name, 
        "attribute_value": attr_val, 
        "ability": ability_name, 
        "ability_value": ability_val, 
        "difficulty": difficulty, 
        "rolls": rolls, 
        "successes": successes, 
        "ones_count": ones_count, 
        "effective_ones": effective_ones, 
        "net_successes": net_successes, 
        "is_botch": is_botch, 
        "result_type": result_type, 
        "used_specialization": spec_active, 
        "used_willpower": use_willpower, 
        "bonus_successes": bonus_successes, 
        "total_dice": total_dice
    }


    if not is_custom:
        var penalty_text: = ""
        match character_data.health_index:
            2, 3:
                penalty_text = "(-1 die due to wounds)"
            4, 5:
                penalty_text = "(-2 dice due to wounds)"
            6:
                penalty_text = "(-5 dice due to wounds)"
            7:
                penalty_text = "Roll reduced to 0 — Incapacitated"
        if penalty_text != "":
            data["penalty_reason"] = penalty_text


    match mode:
        0:
            MessagesManager.process_dicethrow(data)
        1:
            MessagesManager.process_private_dicethrow(data)
        _:
            print("⚠ Unknown dice roll mode:", mode)




@rpc("any_peer")
func request_zone_viewpoint_data(char_name: String) -> void :
    if not GameManager.character_data_by_name.has(char_name):
        print("❌ Unknown character:", char_name)
        return

    var char_data = GameManager.character_data_by_name[char_name]
    var zone_id = char_data.current_zone
    var viewpoint_id = char_data.current_viewpoint

    var zone_data = ZoneManager.zones.get(zone_id, {})
    var viewpoint_data = zone_data.get("viewpoints", {}).get(viewpoint_id, {})

    var image_path = viewpoint_data.get("image_path", "")
    var packet: = {
        "char_name": char_name, 
        "image_path": image_path, 
    }

    var peer_id = GameManager.character_peers.get(char_name, -1)
    if peer_id != -1:
        rpc_id(peer_id, "receive_viewpoint_image", packet)


@rpc("any_peer")
func receive_viewpoint_image(data: Dictionary) -> void :
    var char_name = data.get("char_name", "")
    print("🧭 Updating image for:", char_name)

    if not GameManager.character_uis.has(char_name):
        print("❌ No UI found for:", char_name)
        return

    var image_path = data.get("image_path", "")
    if image_path == "":
        print("⚠ No image path provided — skipping load")
        return

    print("🖼 Trying to load image from path:", image_path)

    var texture = load(image_path)
    if texture:
        var ui = GameManager.character_uis[char_name]
        ui.update_viewpoint_image(image_path)
        print("✅ Image updated successfully")
    else:
        print("❌ Failed to load image from:", image_path)



func set_viewpoint_image(texture: Texture2D) -> void :
    $ZoneImagePanel.texture = texture





@rpc("any_peer")
func request_change_viewpoint(char_name: String, new_viewpoint: String):
    if not GameManager.character_data_by_name.has(char_name):
        print("❌ Unknown character:", char_name)
        return

    var char_data = GameManager.character_data_by_name[char_name]
    var zone_id = char_data.current_zone

    if not ZoneManager.zones.has(zone_id):
        print("❌ Unknown zone:", zone_id)
        return

    var zone_data = ZoneManager.zones[zone_id]
    var valid_viewpoints = zone_data.get("viewpoints", {}).keys()

    if new_viewpoint not in valid_viewpoints:
        print("❌ Invalid viewpoint:", new_viewpoint)
        return

    char_data.current_viewpoint = new_viewpoint
    print("🔄", char_name, "now viewing:", new_viewpoint)


    var vp_data = zone_data["viewpoints"].get(new_viewpoint, {})
    var image_path = vp_data.get("image_path", "")

    var peer_id = GameManager.character_peers.get(char_name, -1)
    if peer_id != -1:
        rpc_id(peer_id, "receive_viewpoint_image", {
            "image_path": image_path, 
            "char_name": char_name
        })

@rpc("any_peer")
func request_all_character_names(requester_name: String):
    if not multiplayer.is_server():
        return

    if not GameManager.character_data_by_name.has(requester_name):
        print("❌ Tell request from unknown character:", requester_name)
        return

    var peer_id = multiplayer.get_remote_sender_id()
    var all_names: = []

    for char_name in GameManager.character_data_by_name.keys():
        if char_name != requester_name:
            all_names.append(char_name)

    rpc_id(peer_id, "receive_all_character_names", all_names)



@rpc("authority")
func receive_all_character_names(names: Array):
    emit_signal("all_character_names_received", names)


@rpc("any_peer")
func request_register_player_character(data: Dictionary):
    print("📥 Received character registration:", data)
    if not multiplayer.is_server():
        return

    var sender_id = multiplayer.get_remote_sender_id()
    var new_name = data.get("name", "").strip_edges()

    if new_name == "":
        print("❌ Character creation failed - no name provided.")
        return

    if GameManager.character_data_by_name.has(new_name):
        print("❌ Character already exists:", new_name)
        return

    var char_data = CharacterData.new()
    char_data.name = new_name
    char_data.is_storyteller = false
    char_data.current_zone = "OOC"


    char_data.clan = data.get("clan", "")
    char_data.sect = data.get("sect", "")
    char_data.nature = data.get("nature", "")
    char_data.demeanor = data.get("demeanor", "")
    char_data.path_name = data.get("path_name", "")
    char_data.experience_points = data.get("experience_points", 0)
    char_data.is_vampire = data.get("is_vampire", true)


    for attr in ["strength", "dexterity", "stamina", "charisma", "manipulation", "appearance", "perception", "intelligence", "wits"]:
        char_data.set(attr, data.get(attr, 1))


    for virtue in ["conscience", "self_control", "courage", "conviction", "instinct"]:
        char_data.set(virtue, data.get(virtue, 0))


    for mech in ["path", "generation", "blood_pool", "blood_pool_max", "blood_per_turn", "willpower_max", "willpower_current"]:
        char_data.set(mech, data.get(mech, 1))


    var ability_names: = [
        "alertness", "athletics", "awareness", "brawl", "empathy", "expression", "intimidation", "leadership", "streetwise", "subterfuge", 
        "animal_ken", "crafts", "drive", "etiquette", "firearms", "larceny", "melee", "performance", "stealth", "survival", 
        "academics", "computer", "finance", "investigation", "law", "medicine", "occult", "politics", "science", "technology"
    ]
    for ability in ability_names:
        char_data.set(ability, data.get(ability, 0))


    var raw_specs = data.get("ability_specialties", [])
    var ability_specialties_clean: Array[String] = []
    if raw_specs is Array:
        for entry in raw_specs:
            if typeof(entry) == TYPE_STRING and entry != "":
                ability_specialties_clean.append(entry)
    char_data.ability_specialties = ability_specialties_clean
    print("🧩 Specializations:", char_data.ability_specialties)


    var background_names: = [
        "allies", "contacts", "domain", "fame", "generation_background", 
        "haven", "herd", "influence", "mentor", "resources", 
        "retainers", "rituals", "status"
    ]
    for background in background_names:
        char_data.set(background, data.get(background, 0))


    var raw_derangements = data.get("derangements", [])
    var clean_derangements: Array[String] = []
    if raw_derangements is Array:
        for d in raw_derangements:
            if typeof(d) == TYPE_STRING:
                clean_derangements.append(d)
    char_data.derangements = clean_derangements


    char_data.disciplines = data.get("disciplines", {})


    var raw_paths = data.get("thaumaturgy_paths", [])
    var paths: Array[String] = []
    if raw_paths is Array:
        for entry in raw_paths:
            if typeof(entry) == TYPE_STRING and entry != "":
                paths.append(entry)
    char_data.thaumaturgy_paths = paths


    var raw_rituals = data.get("thaumaturgy_rituals", [])
    var rituals: Array[String] = []
    if raw_rituals is Array:
        for r in raw_rituals:
            if typeof(r) == TYPE_STRING and r != "":
                rituals.append(r)
    char_data.thaumaturgy_rituals = rituals


    var raw_necro_paths = data.get("necromancy_paths", [])
    var necro_paths: Array[String] = []
    if raw_necro_paths is Array:
        for entry in raw_necro_paths:
            if typeof(entry) == TYPE_STRING and entry != "":
                necro_paths.append(entry)
    char_data.necromancy_paths = necro_paths


    var raw_necro_rituals = data.get("necromancy_rituals", [])
    var necro_rituals: Array[String] = []
    if raw_necro_rituals is Array:
        for r in raw_necro_rituals:
            if typeof(r) == TYPE_STRING and r != "":
                necro_rituals.append(r)
    char_data.necromancy_rituals = necro_rituals


    char_data.merits = data.get("merits", [])
    char_data.flaws = data.get("flaws", [])


    GameManager.character_data_by_name[char_data.name] = char_data
    GameManager.character_peers[char_data.name] = sender_id
    GameManager.peer_to_character_name[sender_id] = char_data.name

    ZoneManager.move_character_to_zone(char_data, char_data.current_zone)

    print("✅ Player character registered:", char_data.name)
    print("🧭 Zone:", char_data.current_zone)


    print("🔍 Final blood values:", {
        "blood_pool": char_data.blood_pool, 
        "blood_pool_max": char_data.blood_pool_max, 
        "blood_per_turn": char_data.blood_per_turn
    })


    rpc_id(sender_id, "receive_character_data", serialize_character_data(char_data))




@rpc("authority")
func receive_character_data(data: Dictionary) -> void :
    print("📥 Receiving character data on client:", data.get("name", "Unknown"))

    var character = CharacterData.new()
    character.deserialize_from_dict(data)

    GameManager.character_data_by_name[character.name] = character
    GameManager.character_data = character

    var main_ui = load("res://scene/main_ui.tscn").instantiate()
    main_ui.set_character_data(character)

    GameManager.character_uis[character.name] = main_ui

    get_tree().root.add_child(main_ui)
    if get_tree().current_scene:
        get_tree().current_scene.queue_free()
    get_tree().set_current_scene(main_ui)

    print("✅ Character %s fully loaded into UI and memory" % character.name)

@rpc("any_peer")
func request_save_character(character_dict: Dictionary) -> void :
    if not multiplayer.is_server():
        return

    var char_name = character_dict.get("name", "")
    if char_name == "":
        print("❌ Save failed — no name in dictionary.")
        return

    var character = GameManager.character_data_by_name.get(char_name)
    if character == null:
        print("❌ Character not found:", char_name)
        return


    if character_dict.has("character_password"):
        character.character_password = character_dict["character_password"]
        print("🔐 Server-side password updated for", char_name)



    print("✅ [request_save_character] Saving up-to-date character:", character.name)
    SaveManager.save_character(character)
    print("✅ Character saved:", character.name)






@rpc("any_peer")
func receive_stat_value(stat_name: String, value: int) -> void :
    emit_signal("stat_value_received", stat_name, value)

@rpc("any_peer")
func request_load_character(character_name: String, submitted_password: String) -> void :
    if not multiplayer.is_server():
        return

    var save_path = "user://characters/" + character_name + ".tres"
    if not FileAccess.file_exists(save_path):
        print("❌ No saved character found for:", character_name)
        return

    var char_data: = ResourceLoader.load(save_path)
    if char_data == null or not (char_data is CharacterData):
        print("❌ Invalid character file:", character_name)
        return

    if char_data.name != character_name:
            if char_data.name.to_lower() == character_name.to_lower():
                print("❌ Name capitalization mismatch for:", character_name, "Expected:", char_data.name)
            else:
                print("❌ Character name mismatch for:", character_name, "Expected:", char_data.name)
            return

    if char_data.character_password != submitted_password:
        print("❌ Incorrect password for:", character_name)
        return

    print("✅ Character loaded:", character_name)


    var peer_id: = multiplayer.get_remote_sender_id()
    GameManager.character_data_by_name[character_name] = char_data
    GameManager.peer_to_character_name[peer_id] = character_name
    GameManager.character_peers[character_name] = peer_id


    request_zone_move_to(character_name, char_data.current_zone, "load")


    var dict = char_data.serialize_to_dict()
    rpc_id(peer_id, "handle_received_character_data", dict)

@rpc("any_peer")
func handle_received_character_data(data: Dictionary) -> void :
    var character: = CharacterData.new()
    character.deserialize_from_dict(data)

    GameManager.character_data_by_name[character.name] = character
    GameManager.character_data = character

    if Engine.has_singleton("SettingsManager") or SettingsManager:
        SettingsManager.sync_from_character()

    if character.is_storyteller:
        print("🧙 Storyteller detected:", character.name)
        _activate_storyteller_mode(character)
    else:
        print("👤 Player character loaded:", character.name)
        NetworkManager.on_character_received(character)
        NetworkManager.rpc_id(1, "request_wake_up_effects", character.name)

func _activate_storyteller_mode(character: CharacterData) -> void :
    print("🧪 Activating storyteller mode for:", character.name)
    
    if character.current_zone.is_empty():
        character.current_zone = "OOC"
    
    var peer_id: int = multiplayer.get_unique_id()
    GameManager.peer_to_character_name[peer_id] = character.name
    print("🔗 Registered peer ID", peer_id, "→", character.name)
    
    var main_scene: Control = load("res://scene/main_ui.tscn").instantiate()
    main_scene.set_character_data(character)
    GameManager.character_uis[character.name] = main_scene
    
    get_tree().root.add_child(main_scene)
    
    var old_scene = get_tree().current_scene
    get_tree().current_scene = main_scene
    if old_scene:
        old_scene.queue_free()
    
    print("✅ Storyteller mode activated for:", character.name)

func on_character_received(character: CharacterData) -> void :
    var main_ui = load("res://scene/main_ui.tscn").instantiate()
    main_ui.set_character_data(character)

    GameManager.character_uis[character.name] = main_ui

    print("✅ Finished loading character UI for:", character.name)
    get_tree().root.add_child(main_ui)
    var old_scene = get_tree().current_scene
    get_tree().current_scene = main_ui
    if old_scene:
        old_scene.queue_free()

    print("✅ Main UI loaded for:", character.name)
    print("✅ Finished loading character UI for:", character.name)




func handle_peer_disconnected(peer_id: int) -> void :
    print("📴 Handling disconnection for peer:", peer_id)

    var char_name = GameManager.peer_to_character_name.get(peer_id, "")
    if char_name == "":
        print("⚠️ No character for peer:", peer_id)
        return

    var char_data = GameManager.character_data_by_name.get(char_name, null)
    if char_data:

        if char_data.character_password != "":
            if has_node("/root/SaveManager"):
                SaveManager.save_character(char_data)
            else:
                print("❌ SaveManager not found — could not auto-save:", char_name)
        else:
            print("🕳 No password — skipping auto-save for:", char_name)


        var zone_name = char_data.current_zone
        if ZoneManager.zones.has(zone_name):
            var zone_dict = ZoneManager.zones[zone_name]
            zone_dict["characters"] = zone_dict["characters"].filter(
                func(c): return c.name != char_name
            )
            print("🚪 Removed", char_name, "from zone:", zone_name)


        MessagesManager.notify_disconnect(char_name, zone_name)



    GameManager.character_data_by_name.erase(char_name)
    GameManager.character_peers.erase(char_name)
    GameManager.name_to_peer.erase(char_name)
    GameManager.peer_to_character_name.erase(peer_id)
    GameManager.current_mode_by_peer.erase(peer_id)


    if GameManager.storyteller_original_forms.has(char_name):
        var possessed_name = GameManager.possessed_characters.find_key(char_name)
        if possessed_name:
            GameManager.possessed_characters.erase(possessed_name)
        GameManager.storyteller_original_forms.erase(char_name)

    print("🧹 Finished cleaning up character:", char_name)

@rpc("any_peer")
func request_virtue_roll(_st_name: String, target_name: String, difficulty: int, mode: String) -> void :
    if not multiplayer.is_server():
        return

    var target_data = GameManager.character_data_by_name.get(target_name, null)
    if target_data == null:
        print("❌ request_virtue_roll: Target not found:", target_name)
        return

    var virtue_name: = ""
    var virtue_value: = 0
    var rolls: Array[int] = []
    var raw_successes: = 0
    var ones_count: = 0
    var final_successes: = 0
    var result_data: = {}


    match mode:
        "path":
            if target_data.conscience > 0:
                virtue_name = "conscience"
            elif target_data.conviction > 0:
                virtue_name = "conviction"
            else:
                print("❌ Target", target_name, "has neither Conscience nor Conviction")
                return

        "frenzy":
            if target_data.instinct > 0:
                print("Auto-Frenzy due to Instinct for", target_name)
                result_data = {
                    "speaker": target_name, 
                    "virtue_name": "instinct", 
                    "virtue_value": target_data.instinct, 
                    "difficulty": difficulty, 
                    "rolls": [], 
                    "raw_successes": 0, 
                    "ones_count": 0, 
                    "final_successes": -999, 
                    "is_botch": false, 
                    "mode": mode, 
                    "frenzy_total": 0
                }
                MessagesManager.process_virtue_roll(result_data)
                return
            elif target_data.self_control > 0:
                virtue_name = "self_control"
            else:
                print("❌ Target has no Instinct or Self-Control:", target_name)
                return

        "rotschreck":
            if target_data.courage > 0:
                virtue_name = "courage"
            else:
                print("❌ Target has no Courage value")
                return

        _:
            print("❌ Unsupported virtue roll mode:", mode)
            return


    virtue_value = target_data.get(virtue_name)
    if virtue_value <= 0:
        print("❌ Cannot roll: Virtue value is 0")
        return


    var rand = RandomNumberGenerator.new()
    rand.randomize()

    for i in virtue_value:
        var roll = rand.randi_range(1, 10)
        rolls.append(roll)
        if roll >= difficulty:
            raw_successes += 1
        elif roll == 1:
            ones_count += 1

    final_successes = raw_successes - ones_count
    var is_botch: = (raw_successes == 0 and ones_count > 0)


    if mode == "frenzy":
        if final_successes < 1:
            print("❌ Frenzy triggered for", target_name)
            GameManager.frenzy_test_state.erase(target_name)
        else:
            var previous = GameManager.frenzy_test_state.get(target_name, 0)
            var new_total = previous + final_successes
            if new_total >= 5:
                print("✅ Frenzy resisted by", target_name)
                GameManager.frenzy_test_state.erase(target_name)
            else:
                GameManager.frenzy_test_state[target_name] = new_total
                print("🧪 Frenzy resistance progress for %s: %d/5" % [target_name, new_total])


    if mode == "rotschreck":
        if final_successes < 1:
            print("❌ Rötschreck triggered for", target_name)
            GameManager.rotschreck_test_state.erase(target_name)
        else:
            var previous = GameManager.rotschreck_test_state.get(target_name, 0)
            var new_total = previous + final_successes
            if new_total >= 5:
                print("✅ Rötschreck resisted by", target_name)
                GameManager.rotschreck_test_state.erase(target_name)
            else:
                GameManager.rotschreck_test_state[target_name] = new_total
                print("🧪 Rötschreck resistance progress for %s: %d/5" % [target_name, new_total])


    if mode == "path" and final_successes <= 0:
        target_data.path = max(0, target_data.path - 1)
        print("⚠️ Path rating reduced to", target_data.path, "for", target_name)


    result_data = {
        "speaker": target_name, 
        "virtue_name": virtue_name, 
        "virtue_value": virtue_value, 
        "difficulty": difficulty, 
        "rolls": rolls, 
        "raw_successes": raw_successes, 
        "ones_count": ones_count, 
        "final_successes": final_successes, 
        "is_botch": is_botch, 
        "mode": mode, 
        "frenzy_total": GameManager.frenzy_test_state.get(target_name, 0), 
        "rotschreck_total": GameManager.rotschreck_test_state.get(target_name, 0)
    }

    MessagesManager.process_virtue_roll(result_data)

@rpc("any_peer")
func set_character_description(character_name: String, description: String) -> void :
    var character = GameManager.character_data_by_name.get(character_name)
    if character == null:
        print("❌ Character not found:", character_name)
        return

    character.description = description
    print("✅ [set_character_description] Updated:", character_name, "->", character.description)


    var dict: Dictionary = character.serialize_to_dict()
    print("📦 [set_character_description] Serialized Description:", dict.get("description", "MISSING"))
    request_save_character(dict)


    var peer_id = GameManager.name_to_peer.get(character_name, -1)
    if peer_id != -1:
        print("📤 Syncing updated description to peer:", peer_id)
        rpc_id(peer_id, "receive_updated_description_only", description)

@rpc("authority")
func receive_updated_description_only(new_description: String) -> void :
    if GameManager.character_data:
        GameManager.character_data.description = new_description
        print("📝 Client-side character description updated")




@rpc("any_peer")
func request_character_description(requester_name: String, target_name: String):
    if not GameManager.character_data_by_name.has(target_name):
        print("❌ Target not found for description:", target_name)
        return

    var target_data = GameManager.character_data_by_name[target_name]
    var description: String = target_data.description.strip_edges()

    if description.is_empty():
        description = "No description available."

    var requester_peer: int = GameManager.character_peers.get(requester_name, -1)
    if requester_peer == -1:
        print("❌ Could not find peer for:", requester_name)
        return


    var portrait_path: = "user://portraits/%s.png" % target_name
    var portrait_bytes: = PackedByteArray()

    if FileAccess.file_exists(portrait_path):
        var file: = FileAccess.open(portrait_path, FileAccess.READ)
        if file:
            portrait_bytes = file.get_buffer(file.get_length())
            file.close()
            print("🖼️ Loaded portrait for", target_name)
    else:
        print("⚠️ No portrait image found for", target_name)


    var packet: = {
        "type": "description", 
        "speaker": target_name, 
        "message": CHAT_DIVIDER + "[b]%s[/b]'s description:\n%s" % [target_name, description]
    }
    rpc_id(requester_peer, "receive_message", packet)


    rpc_id(requester_peer, "show_character_display", requester_name, target_name, description, portrait_bytes)




@rpc("authority")
func show_character_display(requester_name: String, target_name: String, description: String, image_bytes: PackedByteArray):
    if not GameManager.character_uis.has(requester_name):
        print("⚠️ No local character UI found for:", requester_name)
        return

    var main_ui = GameManager.character_uis[requester_name]
    if not is_instance_valid(main_ui):
        print("⚠️ Main UI invalid for:", requester_name)
        return

    main_ui.show_character_display(target_name, description, image_bytes)

@rpc("any_peer", "reliable")
func request_self_image_preview(requester_name: String) -> void :

    var sender_peer: int = multiplayer.get_remote_sender_id()
    var mapped_name: String = GameManager.peer_to_character_name.get(sender_peer, "")
    if mapped_name != requester_name:
        print("❌ request_self_image_preview: name mismatch for peer %d" % sender_peer)
        return


    var portrait_bytes: PackedByteArray = PackedByteArray()
    var portrait_path: String = "user://portraits/%s.png" % requester_name

    if FileAccess.file_exists(portrait_path):
        var file: FileAccess = FileAccess.open(portrait_path, FileAccess.READ)
        if file != null:
            portrait_bytes = file.get_buffer(file.get_length())
            file.close()
            print("🖼️ Loaded self portrait for", requester_name)
    else:

        if GameManager.character_data_by_name.has(requester_name):
            var cd: Resource = GameManager.character_data_by_name[requester_name] as Resource
            var v_img: Variant = cd.get("portrait_bytes")
            if typeof(v_img) == TYPE_PACKED_BYTE_ARRAY:
                portrait_bytes = v_img
        if portrait_bytes.is_empty():
            print("⚠️ No portrait image found for", requester_name)


    rpc_id(sender_peer, "show_character_display", requester_name, requester_name, "", portrait_bytes)



@rpc("any_peer")
func request_character_data_for_edit(character_name: String) -> void :
    if not multiplayer.is_server():
        print("❌ request_character_data_for_edit() must only run on the server")
        return

    var sender_peer: = multiplayer.get_remote_sender_id()
    if sender_peer == -1:
        print("❌ Invalid sender peer ID — likely called locally on the server")
        return

    if not GameManager.character_data_by_name.has(character_name):
        print("❌ Character not found:", character_name)
        return

    var target_data: CharacterData = GameManager.character_data_by_name[character_name]
    var serialized: = target_data.serialize_to_dict()

    send_character_data_to_editor.rpc_id(sender_peer, serialized)
    print("📤 Sent character data for editing to peer", sender_peer, "→", character_name)



@rpc("authority")
func send_character_data_to_editor(data: Dictionary) -> void :
    var character_ui = GameManager.character_uis.get(GameManager.character_data.name, null)
    if character_ui == null:
        print("⚠️ Could not find UI for current character")
        return

    var editable_panel = character_ui.get_node_or_null("CharacterSheetEditableUI")
    if editable_panel == null:
        print("⚠️ Editable panel not found")
        return


    var character_resource: = CharacterData.new()
    character_resource.deserialize_from_dict(data)
    editable_panel.receive_character_data(character_resource)




@rpc("authority", "call_local")
func receive_character_data_for_edit(dict: Dictionary, sender_name: String) -> void :

    print("🔍 Looking up UI for:", sender_name)
    print("📋 character_uis keys:", GameManager.character_uis.keys())

    var main_ui: Control = GameManager.character_uis.get(sender_name, null)
    if main_ui == null:
        print("❌ MainUI not found for Storyteller named:", sender_name)
        return

    var edit_ui: Control = main_ui.get_node_or_null("CharacterSheetEditableUI")
    if edit_ui == null:
        print("❌ CharacterSheetEditableUI not found.")
        return

    var temp_data: CharacterData = CharacterData.new()
    temp_data.deserialize_from_dict(dict)

    edit_ui.receive_character_data(temp_data)
    edit_ui.visible = true

    var player_selection: Control = main_ui.get_node_or_null("PlayerSelection")
    if player_selection:
        player_selection.visible = false




func _ts() -> String:
    var d: = Time.get_datetime_dict_from_system()
    return "%04d-%02d-%02d %02d:%02d:%02d" % [d.year, d.month, d.day, d.hour, d.minute, d.second]

func _editor_name_from_peer(pid: int) -> String:
    return GameManager.peer_to_character_name.get(pid, "PEER_%s" % str(pid))

func _log_character_edit_text(editor_peer_id: int, target_before: String, target_after: String, change: Dictionary) -> void :
    if not multiplayer.is_server():
        return


    if not FileAccess.file_exists(EDIT_LOG_PATH):
        var nf: = FileAccess.open(EDIT_LOG_PATH, FileAccess.WRITE)
        if nf:
            nf.close()
        else:
            push_error("Failed to create edit log file: %s (err %s)" % [EDIT_LOG_PATH, str(FileAccess.get_open_error())])
            return

    var editor_name: = _editor_name_from_peer(editor_peer_id)
    var lines: PackedStringArray = []
    lines.append("=== CHARACTER EDIT ===")
    lines.append("Time: %s" % _ts())
    lines.append("Editor: %s (peer %s)" % [editor_name, str(editor_peer_id)])
    lines.append("Target: %s -> %s" % [target_before, target_after])
    lines.append("Change:")
    lines.append(JSON.stringify(change, "  ", true))
    lines.append("")

    var f: = FileAccess.open(EDIT_LOG_PATH, FileAccess.READ_WRITE)
    if f:
        f.seek_end()
        f.store_string("\n".join(lines) + "\n")
        f.close()
    else:
        push_error("Failed to open edit log file: %s (err %s)" % [EDIT_LOG_PATH, str(FileAccess.get_open_error())])


@rpc("any_peer")
func request_edit_character(character_name: String, change_dict: Dictionary) -> void :
    if not GameManager.character_data_by_name.has(character_name):
        print("❌ Character not found:", character_name)
        return

    var editor_peer_id: = multiplayer.get_remote_sender_id()
    var original_target: = character_name

    var character_data: CharacterData = GameManager.character_data_by_name[character_name]

    var property_names: Array[String] = []
    for prop in character_data.get_property_list():
        property_names.append(prop.name)

    for key in change_dict.keys():
        var value = change_dict[key]

        if key == "disciplines":
            if typeof(value) == TYPE_DICTIONARY:
                var new_disc: Dictionary = {}
                for k in value.keys():
                    new_disc[String(k)] = int(value[k])
                character_data.disciplines = new_disc
            continue

        if key == "blood_bonds":
            if typeof(value) == TYPE_DICTIONARY:
                var bb: Dictionary = {}
                for k in value.keys():
                    bb[String(k)] = int(value[k])
                character_data.blood_bonds = bb
            continue

        if key == "vinculum":
            if typeof(value) == TYPE_DICTIONARY:
                var vc: Dictionary = {}
                for k in value.keys():
                    vc[String(k)] = int(value[k])
                character_data.vinculum = vc
            continue

        if key == "derangements" or key == "merits" or key == "flaws"\
or key == "ability_specialties" or key == "thaumaturgy_paths" or key == "thaumaturgy_rituals"\
or key == "necromancy_paths" or key == "necromancy_rituals"\
or key == "ritae_auctoritas_known" or key == "ritae_ignoblis_known"\
or key == "inventory" or key == "health_levels":
            var arr: Array[String] = []
            if typeof(value) == TYPE_ARRAY:
                for e in value:
                    arr.append(String(e))
            if key == "derangements":
                character_data.derangements = arr
            elif key == "merits":
                character_data.merits = arr
            elif key == "flaws":
                character_data.flaws = arr
            elif key == "ability_specialties":
                character_data.ability_specialties = arr
            elif key == "thaumaturgy_paths":
                character_data.thaumaturgy_paths = arr
            elif key == "thaumaturgy_rituals":
                character_data.thaumaturgy_rituals = arr
            elif key == "necromancy_paths":
                character_data.necromancy_paths = arr
            elif key == "necromancy_rituals":
                character_data.necromancy_rituals = arr
            elif key == "ritae_auctoritas_known":
                character_data.ritae_auctoritas_known = arr
            elif key == "ritae_ignoblis_known":
                character_data.ritae_ignoblis_known = arr
            elif key == "inventory":
                character_data.inventory = arr
            elif key == "health_levels":
                character_data.health_levels = arr
            continue

        if property_names.has(key):
            character_data.set(key, value)
        else:
            pass

    var new_name: = String(change_dict.get("name", character_name))
    if new_name != "" and new_name != character_name:
        var old_name: = character_name

        GameManager.character_data_by_name.erase(old_name)
        GameManager.character_data_by_name[new_name] = character_data

        if GameManager.character_peers.has(old_name):
            var pid: int = int(GameManager.character_peers.get(old_name, -1))
            if pid != -1:
                GameManager.character_peers.erase(old_name)
                GameManager.character_peers[new_name] = pid

                if GameManager.name_to_peer.has(old_name):
                    GameManager.name_to_peer.erase(old_name)
                    GameManager.name_to_peer[new_name] = pid

                GameManager.peer_to_character_name[pid] = new_name

        character_name = new_name

    print("✅ Edited character:", character_name)

    _log_character_edit_text(editor_peer_id, original_target, character_name, change_dict)

    if GameManager.character_peers.has(character_name):
        var peer_id: int = int(GameManager.character_peers.get(character_name, -1))
        if peer_id != -1:
            var dict = character_data.serialize_to_dict()
            rpc_id(peer_id, "receive_edited_character_data", dict)

@rpc
func receive_edited_character_data(dict: Dictionary) -> void :
    var new_data: = CharacterData.new()
    new_data.deserialize_from_dict(dict)

    GameManager.character_data = new_data
    GameManager.character_data_by_name[new_data.name] = new_data
    SettingsManager.sync_from_character()

    var main_ui: Control = GameManager.character_uis.get(new_data.name, null)
    if main_ui != null:
        var sheet_ui: Control = main_ui.get_node_or_null("CharacterSheetUI")
        if sheet_ui != null and sheet_ui.visible:
            sheet_ui.show_character(new_data)




@rpc("any_peer")
func request_character_data_for_view(character_name: String) -> void :
    var sender_id: int = multiplayer.get_remote_sender_id()
    var sender_name: String = GameManager.peer_to_character_name.get(sender_id, "")
    var sender_data: CharacterData = GameManager.character_data_by_name.get(sender_name, null)

    if sender_data == null:
        print("⛔ View request denied: sender not registered.")
        return

    if not GameManager.character_data_by_name.has(character_name):
        print("❌ Character not found for view:", character_name)
        return

    var target_data: CharacterData = GameManager.character_data_by_name[character_name]
    var dict: Dictionary = target_data.serialize_to_dict()

    rpc_id(sender_id, "receive_character_data_for_view", dict, character_name)
    print("📤 Sent viewable character data for", character_name, "to", sender_name)


@rpc("authority", "call_local")
func receive_character_data_for_view(dict: Dictionary, character_name: String) -> void :
    print("🛬 Receiving viewable character data for:", character_name)

    var main_ui: Control = GameManager.character_uis.get(character_name, null)
    if main_ui == null:
        print("❌ MainUI not found for", character_name)
        return

    var sheet_ui: Control = main_ui.get_node_or_null("CharacterSheetUI")
    if sheet_ui == null:
        print("❌ CharacterSheetUI not found.")
        return

    var temp_data: CharacterData = CharacterData.new()
    temp_data.deserialize_from_dict(dict)

    sheet_ui.receive_character_data(temp_data)
    sheet_ui.visible = true

var _description_panel_target: Node = null

func request_character_data_for_description(panel_ref: Node, character_name: String) -> void :
    _description_panel_target = panel_ref
    rpc("request_character_data_for_description_only", character_name)

@rpc("any_peer")
func request_character_data_for_description_only(character_name: String) -> void :
    var sender_id: int = multiplayer.get_remote_sender_id()
    var sender_name: String = GameManager.peer_to_character_name.get(sender_id, "")
    var sender_data: CharacterData = GameManager.character_data_by_name.get(sender_name, null)

    if sender_data == null:
        print("⛔ Description request denied: sender not registered.")
        return

    if not GameManager.character_data_by_name.has(character_name):
        print("❌ Character not found for description:", character_name)
        return

    var target_data: CharacterData = GameManager.character_data_by_name[character_name]
    var dict: Dictionary = serialize_character_data(target_data)

    rpc_id(sender_id, "receive_character_data_for_description_only", dict, character_name)
    print("📤 Sent description character data for", character_name, "to", sender_name)


@rpc("authority", "call_local")
func receive_character_data_for_description_only(dict: Dictionary, character_name: String) -> void :
    print("🛬 Receiving character data (description-only) for:", character_name)

    if _description_panel_target == null or not _description_panel_target.is_inside_tree():
        print("⚠ No valid panel to receive description data.")
        return

    var temp_data: CharacterData = CharacterData.new()
    temp_data.deserialize_from_dict(dict)

    _description_panel_target.receive_fresh_description_resource(temp_data)
    _description_panel_target = null





@rpc("any_peer")
func request_create_temp_zone(payload: Dictionary) -> void :
    var zone_name: String = payload.get("name", "").strip_edges()
    var password: String = payload.get("password", "").strip_edges()
    var description: String = payload.get("description", "").strip_edges()
    var creator: String = payload.get("creator", "")
    var origin_zone: String = payload.get("origin_zone", "")

    if zone_name == "" or password == "" or description == "":
        print("❌ Invalid temp zone payload received")
        return

    if ZoneManager.zones.has(zone_name):
        print("⚠ Zone already exists:", zone_name)
        return

    var zone_data: Dictionary = {
        "zone_name": zone_name, 
        "default_viewpoint": "Main", 
        "is_neighborhood": false, 
        "viewpoints": {
            "Main": {
                "image_path": "res://Image/ViewpointImage/OOCIMAGE.png", 
                "description": description, 
                "sound_path": "res://sound/description/Test1.mp3"
            }
        }, 
        "connected_zones": [origin_zone], 
        "characters": [], 
        "secret_entry_passwords": [password], 
        "accessible_from_zones": [origin_zone], 
        "Temporary": true
    }

    ZoneManager.zones[zone_name] = zone_data
    ZoneManager.start_temp_zone_cleanup_timer(zone_name)



    var peer_id = GameManager.name_to_peer.get(creator, -1)
    if peer_id != -1:
        print("📨 Syncing new temp zone to creator:", creator)
        rpc_id(peer_id, "receive_new_zone_data", zone_name, zone_data)





@rpc("any_peer")
func request_zone_selection_list(character_name: String, mode: String) -> void :
    var peer_id = multiplayer.get_remote_sender_id()
    var char_data = GameManager.character_data_by_name.get(character_name)

    if char_data == null:
        print("⚠ Invalid character in request_zone_selection_list:", character_name)
        return

    var zone_name = char_data.current_zone
    var zone_res = ZoneManager.zones.get(zone_name)

    if zone_res == null:
        print("⚠ Current zone not found on server:", zone_name)
        return

    var result: Array = []

    match mode:
        "zone":
            result = zone_res.connected_zones.duplicate()

        "teleport":
            result = ZoneManager.zones.keys()

        "viewpoint":
            result = zone_res.viewpoints.keys()

        _:
            print("⚠ Unknown mode in request_zone_selection_list:", mode)
            return

    rpc_id(peer_id, "receive_zone_selection_list", character_name, result)


@rpc("authority")
func receive_zone_selection_list(character_name: String, zone_names: Array) -> void :
    var ui = GameManager.character_uis.get(character_name)
    if ui == null:
        print("⚠ UI not found for character:", character_name)
        return

    var selector = ui.get_node_or_null("LocationSelection")
    if selector == null:
        print("⚠ LocationSelector node not found under character UI for:", character_name)
        return

    selector.populate_zone_list(zone_names)



@warning_ignore("unused_signal")
signal name_check_result_received(name_taken: bool)

func request_name_check(char_name: String):
    print("[DEBUG] Client sending name check for:", char_name)
    rpc("_server_request_name_check", char_name)

@rpc("any_peer")
func _server_request_name_check(char_name: String):
    if not multiplayer.is_server():
        print("[DEBUG] request_name_check() ignored — not server")
        return

    var path: = "user://characters/" + char_name + ".tres"
    var name_taken: = FileAccess.file_exists(path)
    print("[DEBUG] Server checking for existing file at:", path, "| Taken:", name_taken)

    var peer_id: = multiplayer.get_remote_sender_id()
    print("[DEBUG] Sending result back to peer:", peer_id)
    rpc_id(peer_id, "receive_name_check_result", name_taken)

@rpc("authority")
func receive_name_check_result(name_taken: bool):
    print("[DEBUG] Client received name check result:", name_taken)
    emit_signal("name_check_result_received", name_taken)


@rpc("any_peer")
func set_character_notes(character_name: String, notes: String) -> void :
    var character = GameManager.character_data_by_name.get(character_name)
    if character == null:
        print("❌ Character not found for notes:", character_name)
        return

    character.notes = notes
    print("✅ [set_character_notes] Updated notes for:", character_name)

    var dict: Dictionary = character.serialize_to_dict()
    request_save_character(dict)




@rpc("any_peer")
func report_typing_state(data: Dictionary) -> void :
    var char_name: String = data.get("name", "")
    var is_typing: bool = data.get("is_typing", false)
    var mode: String = data.get("mode", "")

    if not ["speak", "emote", "whisper", "ooc", "describe"].has(mode):
        return

    var char_data = GameManager.character_data_by_name.get(char_name, null)
    if not char_data:
        print("⚠ Typing state from unknown character:", char_name)


        for peer_id in GameManager.peer_to_character_name.keys():
            if peer_id != 1:
                rpc_id(peer_id, "receive_typing_update", {
                    "name": char_name, 
                    "is_typing": is_typing
                })
        return


    var zone_name = char_data.current_zone
    var zone_data = ZoneManager.zones.get(zone_name, {})

    if zone_data.get("is_neighborhood", false):
        return

    GameManager.typing_state_by_name[char_name] = is_typing

    var characters_in_zone = zone_data.get("characters", [])
    for other_char in characters_in_zone:
        if not other_char or other_char.name == char_name:
            continue

        var peer_id = GameManager.character_peers.get(other_char.name, -1)
        if peer_id != -1:
            rpc_id(peer_id, "receive_typing_update", {
                "name": char_name, 
                "is_typing": is_typing
            })


signal typing_update_received(data: Dictionary)

@rpc("authority")
func receive_typing_update(data: Dictionary) -> void :
    emit_signal("typing_update_received", data)

@rpc("authority")
func flush_typing_state():
    if GameManager.character_data == null:
        print("❌ flush_typing_state skipped: character_data is null")
        return

    var local_name = GameManager.character_data.name
    var ui = GameManager.character_uis.get(local_name, null)
    if ui:
        ui.typers_in_zone.clear()
        ui.update_typing_indicator()


@rpc("authority")
func remove_typing_character(char_name: String):
    if GameManager.character_data == null:
        print("❌ remove_typing_character skipped: character_data is null")
        return

    var local_name = GameManager.character_data.name
    var ui = GameManager.character_uis.get(local_name, null)
    if ui and ui.typers_in_zone.has(char_name):
        ui.typers_in_zone.erase(char_name)
        ui.update_typing_indicator()




@rpc("authority")
func receive_zone_category(category: String):
    print("🎶 Received zone category:", category)
    MusicManager.update_ambiance_for_category(category)




@rpc("any_peer")
func request_vaulderie_host(data: Dictionary) -> void :
    if multiplayer.get_unique_id() != 1:
        return

    var host = data.get("host", "")
    var zone = data.get("zone", "")

    if host == "" or zone == "":
        print("❌ Invalid host or zone for Vaulderie")
        return

    if not ZoneManager.zones.has(zone):
        print("❌ Zone not found:", zone)
        return

    if VaulderieManager.active_rituals.has(zone):
        print("⚠ Vaulderie already active in zone:", zone)
        return

    print("📿 Host request received from:", host, "in zone:", zone)
    VaulderieManager.start_ritual(host, zone)

    if VaulderieManager.active_rituals.has(zone):
        var participants = VaulderieManager.active_rituals[zone]["participants"]
        var peer_id = GameManager.name_to_peer.get(host, -1)

        if peer_id != -1:
            print("📨 Sending participant list to", host, "(peer %d)" % peer_id)
            rpc_id(peer_id, "receive_vaulderie_participant_list", participants)
        else:
            print("⚠ No peer ID found for host:", host)
    else:
        print("❌ Ritual setup failed — skipping participant sync")

@rpc("authority")
func receive_vaulderie_participant_list(participants) -> void :
    print("📨 [receive_vaulderie_participant_list] RPC triggered.")
    print("👥 Participants received:", participants)
    _forward_participant_list_to_host_panel(participants)
    _forward_participant_list_to_participant_panel(participants)


@rpc("authority")
func _forward_participant_list_to_host_panel(participants: Array) -> void :
    var local_name = GameManager.character_data.name
    print("📨 [_forward_participant_list_to_host_panel] Called for:", local_name)
    print("👥 Participants =", participants)

    var ui = GameManager.character_uis.get(local_name, null)
    if ui == null:
        print("❌ No UI registered for", local_name)
        return

    if ui.has_node("VaulderiePanel"):
        print("🔍 Found VaulderiePanel node inside UI.")
        var panel = ui.get_node("VaulderiePanel")

        if panel.has_method("receive_vaulderie_participant_list"):
            print("📣 Calling panel.receive_vaulderie_participant_list()...")
            panel.receive_vaulderie_participant_list(participants)
        else:
            print("❌ Panel is missing method: receive_vaulderie_participant_list")
    else:
        print("❌ UI has no child node 'VaulderiePanel'")




func _forward_participant_list_to_participant_panel(participants) -> void :
    var ui = GameManager.character_uis.get(GameManager.character_data.name, null)
    if not ui:
        print("❌ [NetworkManager] UI not found for", GameManager.character_data.name)
        return

    if ui.has_node("VaulderiePanelParticipant"):
        var participant_panel = ui.get_node("VaulderiePanelParticipant")
        if participant_panel.has_method("receive_vaulderie_participant_list"):
            participant_panel.receive_vaulderie_participant_list(participants)
            print("✅ [NetworkManager] Forwarded to VaulderiePanelParticipant")
            return

    print("❌ [NetworkManager] VaulderiePanelParticipant not found or missing method")


@rpc("any_peer")
func request_vaulderie_cancel(data: Dictionary) -> void :
    if multiplayer.get_unique_id() != 1:
        return

    var char_name = data.get("character", "")
    var zone = data.get("zone", "")

    if char_name == "" or zone == "":
        print("❌ Invalid cancel payload")
        return

    print("🛑 %s is attempting to cancel ritual in %s" % [char_name, zone])
    VaulderieManager.leave_ritual(char_name, zone)

@rpc("any_peer")
func request_open_vaulderie_participant(char_name: String, zone_name: String) -> void :
    if not GameManager.character_data_by_name.has(char_name):
        print("❌ Unknown character trying to check ritual:", char_name)
        return

    var peer_id = GameManager.name_to_peer.get(char_name, -1)
    if peer_id == -1:
        print("❌ No peer ID for", char_name)
        return

    if not VaulderieManager.active_rituals.has(zone_name):
        print("❌ No active Vaulderie in zone:", zone_name)
        rpc_id(peer_id, "vaulderie_participation_denied", "There is no Vaulderie occurring in these parts.")
        return

    print("✅ Ritual found in zone. Opening VaulderiePanelParticipant for", char_name)
    rpc_id(peer_id, "open_vaulderie_participant_panel")

@rpc("authority")
func open_vaulderie_participant_panel() -> void :
    var ui = GameManager.character_uis.get(GameManager.character_data.name, null)
    if not ui:
        print("❌ Cannot find UI for participant")
        return

    var panel_path = "VaulderiePanelParticipant"
    if ui.has_node(panel_path):
        var panel = ui.get_node(panel_path)
        panel.show()
    else:
        print("❌ VaulderiePanelParticipant node not found in UI")

@rpc("authority")
func vaulderie_participation_denied() -> void :
    print("❌ There is no Vaulderie occurring in this zone.")
    var ui = GameManager.character_uis.get(GameManager.character_data.name, null)
    if ui and ui.has_node("ChatLog"):
        var chat_log = ui.get_node("ChatLog")
        chat_log.add_message("❌ There is no Vaulderie occurring in this zone.")

@rpc("any_peer")
func request_leave_vaulderie(char_name: String, zone_name: String) -> void :
    if not GameManager.character_data_by_name.has(char_name):
        print("❌ Unknown character trying to leave ritual:", char_name)
        return

    if not VaulderieManager.active_rituals.has(zone_name):
        print("❌ No active ritual in zone to leave:", zone_name)
        return

    VaulderieManager.leave_ritual(char_name, zone_name)

@rpc("any_peer")
func request_join_vaulderie(char_name: String, zone_name: String) -> void :
    if not GameManager.character_data_by_name.has(char_name):
        print("❌ Unknown character trying to join ritual:", char_name)
        return

    if not VaulderieManager.active_rituals.has(zone_name):
        print("❌ No active Vaulderie in zone:", zone_name)
        return

    print("📿 %s is joining the ritual in zone %s" % [char_name, zone_name])
    VaulderieManager.join_ritual(char_name, zone_name)

func _on_ritual_updated(zone_name: String, participant_names: Array[String]) -> void :
    print("📡 [NetworkManager] Ritual updated in zone:", zone_name)
    for participant in participant_names:
        var peer_id = GameManager.name_to_peer.get(participant, -1)
        if peer_id != -1:
            print("📨 Sending updated participant list to", participant, "(peer %d)" % peer_id)
            rpc_id(peer_id, "receive_vaulderie_participant_list", participant_names)
        else:
            print("❌ No peer ID found for:", participant)



func _on_ritual_canceled(zone_name: String) -> void :
    print("⚰️ [NetworkManager] Ritual canceled in zone:", zone_name)


@rpc("authority")
func close_vaulderie_panels() -> void :
    var ui: Control = GameManager.character_uis.get(GameManager.character_data.name, null)
    if ui == null:
        return


    if ui.has_node("VaulderiePanel"):
        var host_panel = ui.get_node("VaulderiePanel")
        host_panel.hide()

        var host_cup_path = "VaulderiePanel/VBoxContainer/SubViewportContainer/SubViewport/CupScene"
        var host_cup_scene = host_panel.get_node_or_null(host_cup_path)
        if host_cup_scene and host_cup_scene.has_method("clear_labels_and_stop"):
            host_cup_scene.clear_labels_and_stop()


    if ui.has_node("VaulderiePanelParticipant"):
        var participant_panel = ui.get_node("VaulderiePanelParticipant")
        participant_panel.hide()

        var participant_cup_path = "VaulderiePanelParticipant/VBoxContainer/SubViewportContainer/SubViewport/CupScene"
        var participant_cup_scene = participant_panel.get_node_or_null(participant_cup_path)
        if participant_cup_scene and participant_cup_scene.has_method("clear_labels_and_stop"):
            participant_cup_scene.clear_labels_and_stop()





@rpc("any_peer")
func request_perform_vaulderie(zone_name: String) -> void :
    if multiplayer.get_unique_id() != 1:
        return

    if not VaulderieManager.active_rituals.has(zone_name):
        print("❌ No active ritual in zone:", zone_name)
        return

    var ritual = VaulderieManager.active_rituals[zone_name]
    var host_name = ritual.get("host", "")
    var sender_id = multiplayer.get_remote_sender_id()
    var sender_name = GameManager.peer_to_character_name.get(sender_id, "")

    if sender_name != host_name:
        print("⛔ Perform denied: only the host may perform the Vaulderie.")
        return

    print("🩸 Vaulderie is being performed in zone:", zone_name)
    VaulderieManager.perform_vaulderie(zone_name)

@rpc("any_peer")
func request_vinculum_data(character_name: String) -> void :
    var sender_id: int = multiplayer.get_remote_sender_id()
    var sender_name: String = GameManager.peer_to_character_name.get(sender_id, "")

    var character_data: CharacterData = GameManager.character_data_by_name.get(character_name, null)
    if character_data == null:
        print("❌ No character data found for:", character_name)
        return

    var vinculum_copy: Dictionary = character_data.vinculum.duplicate(true)
    rpc_id(sender_id, "receive_vinculum_data", character_name, vinculum_copy)
    print("📤 Sent Vinculum data for %s to %s (peer %d)" % [character_name, sender_name, sender_id])


@rpc("authority", "call_local")
func receive_vinculum_data(character_name: String, vinculum: Dictionary) -> void :
    print("📥 Received Vinculum data for:", character_name)

    var ui: Control = GameManager.character_uis.get(character_name, null)
    if ui == null:
        print("❌ UI not found for", character_name)
        return

    var vinculum_menu: = ui.get_node_or_null("VinculumMenu")
    if vinculum_menu == null:
        print("❌ VinculumMenu node not found in UI for", character_name)
        return

    vinculum_menu.display_vinculum_data(vinculum)
    print("✅ Vinculum data displayed for", character_name)



@rpc("any_peer")
func upload_character_image(char_name: String, data: PackedByteArray):
    var save_dir: = "user://portraits/"
    var save_path: = save_dir + char_name + ".png"

    DirAccess.make_dir_absolute(save_dir)

    var file: = FileAccess.open(save_path, FileAccess.WRITE)
    if file:
        file.store_buffer(data)
        file.close()
        print("✅ Portrait saved as", save_path)
    else:
        print("❌ Failed to write portrait for", char_name)









@rpc("any_peer")
func request_send_group_invitation(inviter_name_client: String, invitee_name: String) -> void :

    if multiplayer.get_unique_id() != 1:
        print("⛔ Rejected: request_send_group_invitation called from non-server peer")
        return


    var sender_pid: int = multiplayer.get_remote_sender_id()
    var inviter_name: String = GameManager.peer_to_character_name.get(sender_pid, "")
    if inviter_name == "":
        print("❌ Could not resolve inviter from sender pid:", sender_pid)
        return
    if inviter_name != inviter_name_client:
        print("⚠️ Client passed inviter_name '%s' but resolved '%s' from pid %d" % [inviter_name_client, inviter_name, sender_pid])

    print("\n📨 INVITE: %s -> %s" % [inviter_name, invitee_name])


    var inviter_group_name: String = GroupManager.get_group_of(inviter_name)


    GroupManager.request_invite_to_group(inviter_name, invitee_name, inviter_group_name)



@rpc("authority", "call_local")
func receive_group_invite(packet: Dictionary) -> void :

    var inviter: String = str(packet.get("inviter", ""))
    var group_name: String = str(packet.get("group_name", ""))

    print("📥 Receiving group invitation from:", inviter, "for group:", group_name)

    var main_ui: Node = get_tree().get_root().get_node_or_null("MainUI")
    if main_ui == null:
        print("❌ MainUI not found.")
        return

    var group_invitation_panel: Node = main_ui.get_node_or_null("GroupInvitation")
    if group_invitation_panel == null:
        print("❌ GroupInvitation panel not found in MainUI.")
        return



    if group_invitation_panel.has_method("show_invitation_with_group"):
        group_invitation_panel.call("show_invitation_with_group", inviter, group_name)
    else:
        group_invitation_panel.call("show_invitation", inviter)


@rpc("any_peer")
func request_accept_group_invite(_legacy_inviter_name: String = "") -> void :
    if multiplayer.get_unique_id() != 1:
        print("⛔ Rejected: request_accept_group_invite called from non-server peer")
        return

    var invitee_pid: int = multiplayer.get_remote_sender_id()
    var invitee_name: String = GameManager.peer_to_character_name.get(invitee_pid, "")
    print("\n✅ Group invite accepted by peer ID %d => %s" % [invitee_pid, invitee_name])

    if invitee_name == "" or not GameManager.character_data_by_name.has(invitee_name):
        print("❌ Invalid invitee:", invitee_name)
        return


    GroupManager.request_respond_group_invite(invitee_name, true)


@rpc("any_peer")
func request_decline_group_invite(_legacy_inviter_name: String = "") -> void :
    if multiplayer.get_unique_id() != 1:
        print("⛔ Rejected: request_decline_group_invite called from non-server peer")
        return

    var invitee_pid: int = multiplayer.get_remote_sender_id()
    var invitee_name: String = GameManager.peer_to_character_name.get(invitee_pid, "")
    print("\n🚫 Group invite declined by peer ID %d => %s" % [invitee_pid, invitee_name])

    if invitee_name == "" or not GameManager.character_data_by_name.has(invitee_name):
        print("❌ Invalid invitee:", invitee_name)
        return

    GroupManager.request_respond_group_invite(invitee_name, false)


@rpc("any_peer")
func request_leave_group() -> void :
    if multiplayer.get_unique_id() != 1:
        print("⛔ Rejected: request_leave_group called from non-server peer")
        return

    var pid: int = multiplayer.get_remote_sender_id()
    var character_name: String = GameManager.peer_to_character_name.get(pid, "")
    if character_name == "":
        print("❌ Could not resolve character from peer ID.")
        return


    for group_name in GroupManager.groups.keys():
        var group: Dictionary = GroupManager.groups[group_name]
        var members: Array = group.get("members", []) as Array
        if character_name in members:
            print("🚪 %s is leaving group '%s'" % [character_name, group_name])
            GroupManager.leave_group(character_name, group_name)
            return

    print("⚠️ %s not found in any group." % character_name)


@rpc("any_peer")
func request_group_members_for(character_name: String) -> void :
    if multiplayer.get_unique_id() != 1:
        print("⛔ Rejected: request_group_members_for called from non-server peer")
        return

    var group_name: String = ""
    for gname in GroupManager.groups.keys():
        var members: Array = GroupManager.groups[gname].get("members", []) as Array
        if character_name in members:
            group_name = gname
            break

    if group_name == "":
        print("ℹ️", character_name, "is not in a group.")
        return

    GroupManager.send_group_members_to_requester(group_name, character_name)







signal post_order_received(zone_name: String, order: Array)
signal post_order_cleared(zone_name: String)




@rpc("any_peer")
func request_rebuild_post_order(zone_name: String) -> void :

    PostOrderManager.destroy(zone_name)
    var new_order: Array[String] = PostOrderManager.create_from_roster(zone_name, "")
    server_broadcast_post_order(zone_name, new_order)

@rpc("any_peer")
func request_set_post_order(zone_name: String, ordered_names: Array[String]) -> void :

    var result: = PostOrderManager.replace(zone_name, ordered_names, "")
    server_broadcast_post_order(zone_name, result.order)

@rpc("any_peer")
func request_get_post_order(zone_name: String) -> void :

    var requester: = multiplayer.get_remote_sender_id()
    var order: Array[String] = PostOrderManager.get_order(zone_name)
    rpc_id(requester, "_rpc_post_order_push", zone_name, order)

@rpc("any_peer")
func request_clear_post_order(zone_name: String) -> void :

    PostOrderManager.destroy(zone_name)
    server_clear_post_order(zone_name)




@rpc("authority", "call_local")
func _rpc_post_order_push(zone_name: String, order: Array) -> void :
    emit_signal("post_order_received", zone_name, order)

@rpc("authority", "call_local")
func _rpc_post_order_cleared(zone_name: String) -> void :
    emit_signal("post_order_cleared", zone_name)
    emit_signal("post_order_received", zone_name, [])




func server_broadcast_post_order(zone_name: String, order: Array) -> void :
    for peer_id in _peers_in_zone(zone_name):
        rpc_id(peer_id, "_rpc_post_order_push", zone_name, order)

func server_clear_post_order(zone_name: String) -> void :
    for peer_id in _peers_in_zone(zone_name):
        rpc_id(peer_id, "_rpc_post_order_cleared", zone_name)




func _peers_in_zone(zone_name: String) -> Array[int]:
    var out: Array[int] = []
    if not ZoneManager.zones.has(zone_name):
        return out
    var zone: Dictionary = ZoneManager.zones[zone_name]
    var chars: Array = zone.get("characters", []) as Array
    for c in chars:
        var nm: = ""
        if c and c.has_method("get"):
            nm = str(c.name)
        elif typeof(c) == TYPE_STRING:
            nm = str(c)
        if nm == "":
            continue
        if GameManager.name_to_peer.has(nm):
            var pid: = int(GameManager.name_to_peer[nm])
            if pid > 0:
                out.append(pid)
    return out



@rpc("any_peer")
func request_current_ic_time(requester_name: String) -> void :
    if not CalendarManager or not GameManager.character_data_by_name.has(requester_name):
        print("❌ Invalid request for IC time.")
        return

    var ic_date: String = CalendarManager.get_current_date_string()
    var is_second_half: bool = CalendarManager.is_second_half
    var part: String = "Late Night" if is_second_half else "Early Night"

    var peer_id: int = int(GameManager.character_peers.get(requester_name, -1))
    if peer_id == -1:
        print("❌ No peer ID found for", requester_name)
        return

    MessagesManager.send_time_message(peer_id, ic_date, part)




@rpc("any_peer")
func request_wake_up_effects(char_name: String) -> void :
    if not GameManager.character_data_by_name.has(char_name):
        print("❌ No character found to wake up:", char_name)
        return

    var char_data: CharacterData = GameManager.character_data_by_name[char_name]

    await get_tree().create_timer(0.75).timeout


    var peer_id: int = GameManager.name_to_peer.get(char_name, -1)


    WakeUpManager.apply_login_effects(char_data, peer_id)




@rpc("any_peer")
func request_has_willpower(character_name: String) -> void :
    if not GameManager.character_data_by_name.has(character_name):
        print("❌ [request_has_willpower] Character not found:", character_name)
        return

    var character = GameManager.character_data_by_name[character_name]
    var has_willpower: bool = character.willpower_current > 0
    print("🧠 [request_has_willpower] Character:", character_name, "| Willpower_Current:", character.willpower_current, "| Has Willpower:", has_willpower)


    rpc_id(multiplayer.get_remote_sender_id(), "NetworkManager_receive_willpower_status", character_name, has_willpower)


@rpc("authority")
func NetworkManager_receive_willpower_status(character_name: String, has_willpower: bool) -> void :
    print("📩 [receive_willpower_status] Received for:", character_name, "| has_willpower:", has_willpower)

    if GameManager.character_uis.has(character_name):
        var ui = GameManager.character_uis[character_name]
        if ui.has_node("DiceRollerUI"):
            var dice_ui = ui.get_node("DiceRollerUI")
            if dice_ui.has_method("update_willpower_button"):
                print("✅ Updating willpower button in DiceRollerUI for", character_name)
                dice_ui.update_willpower_button(has_willpower)
            else:
                print("⚠️ DiceRollerUI found but missing update_willpower_button")
        else:
            print("❌ DiceRollerUI node not found in UI for", character_name)
    else:
        print("❌ No UI found for", character_name)





@rpc("any_peer")
func request_nightly_activities_data(char_name: String) -> void :
    print("📨 [Server] Received request_nightly_activities_data for:", char_name)

    if not GameManager.character_data_by_name.has(char_name):
        print("❌ [Server] No character data found for:", char_name)
        return

    var character: CharacterData = GameManager.character_data_by_name[char_name]

    var payload: = {
        "zone": character.current_zone, 
        "ap_current": character.action_points_current, 
        "ap_max": character.action_points_max, 
        "blood_current": character.blood_pool, 
        "blood_max": character.blood_pool_max, 
        "wp_current": character.willpower_current, 
        "wp_max": character.willpower_max
    }

    print("📦 [Server] Sending nightly activities data to client:", payload)

    rpc_id(multiplayer.get_remote_sender_id(), "receive_nightly_activities_data", payload)


@rpc("authority")
func receive_nightly_activities_data(data: Dictionary) -> void :
    print("📥 [Client] Received nightly activities data:", data)

    var nightly_ui: = get_tree().get_root().get_node_or_null("MainUI/NightlyActivitiesUI")
    if not nightly_ui:
        print("❌ [Client] NightlyActivitiesUI not found in scene tree.")
        return

    print("✅ [Client] Populating NightlyActivitiesUI panel.")
    nightly_ui.populate_from_server_data(data)


@rpc("any_peer")
func request_NA_Hunting(char_name: String) -> void :
    print("📨 [Server] Hunting request received for:", char_name)

    var character: CharacterData = GameManager.character_data_by_name[char_name]
    NightlyActivitiesManager.perform_hunting(character)

@rpc("any_peer")
func request_NA_WillpowerRecover(char_name: String) -> void :
    print("📨 [Server] Willpower recovery request received for:", char_name)

    var character: CharacterData = GameManager.character_data_by_name[char_name]
    NightlyActivitiesManager.perform_willpower_recovery(character)

@rpc("any_peer")
func request_attribute_upgrade_data(char_name: String) -> void :
    print("📨 [Server] Received attribute upgrade request for:", char_name)

    if not GameManager.character_data_by_name.has(char_name):
        print("❌ [Server] No character data found for:", char_name)
        return

    var character: CharacterData = GameManager.character_data_by_name[char_name]

    var payload: = {
        "strength": character.strength, 
        "strength_progress": character.strength_progress, 
        "dexterity": character.dexterity, 
        "dexterity_progress": character.dexterity_progress, 
        "stamina": character.stamina, 
        "stamina_progress": character.stamina_progress, 
        "charisma": character.charisma, 
        "charisma_progress": character.charisma_progress, 
        "manipulation": character.manipulation, 
        "manipulation_progress": character.manipulation_progress, 
        "appearance": character.appearance, 
        "appearance_progress": character.appearance_progress, 
        "perception": character.perception, 
        "perception_progress": character.perception_progress, 
        "intelligence": character.intelligence, 
        "intelligence_progress": character.intelligence_progress, 
        "wits": character.wits, 
        "wits_progress": character.wits_progress
    }

    print("📦 [Server] Sending attribute upgrade data to client:", payload)

    rpc_id(multiplayer.get_remote_sender_id(), "receive_attribute_upgrade_data", payload)


@rpc("authority")
func receive_attribute_upgrade_data(data: Dictionary) -> void :
    print("📥 [Client] Received attribute upgrade data:", data)

    var main_ui: = get_tree().get_root().get_node_or_null("MainUI")
    if not main_ui:
        print("❌ [Client] MainUI not found in scene tree.")
        return

    for child in main_ui.get_children():
        if child is Control and child.get_script() != null and child.get_script().resource_path.ends_with("nightly_activities_ui.gd"):
            print("✅ [Client] Found NightlyActivitiesUI, populating panel.")
            child.populate_attribute_upgrade_panel(data)
            return

    print("❌ [Client] NightlyActivitiesUI node with matching script not found.")

@rpc("any_peer")
func request_ability_upgrade_data(char_name: String) -> void :
    print("📨 [Server] Received ability upgrade request for:", char_name)

    if not GameManager.character_data_by_name.has(char_name):
        print("❌ [Server] No character data found for:", char_name)
        return

    var c: CharacterData = GameManager.character_data_by_name[char_name]

    var payload: = {

        "alertness": c.alertness, "alertness_progress": c.alertness_progress, 
        "athletics": c.athletics, "athletics_progress": c.athletics_progress, 
        "awareness": c.awareness, "awareness_progress": c.awareness_progress, 
        "brawl": c.brawl, "brawl_progress": c.brawl_progress, 
        "empathy": c.empathy, "empathy_progress": c.empathy_progress, 
        "expression": c.expression, "expression_progress": c.expression_progress, 
        "intimidation": c.intimidation, "intimidation_progress": c.intimidation_progress, 
        "leadership": c.leadership, "leadership_progress": c.leadership_progress, 
        "streetwise": c.streetwise, "streetwise_progress": c.streetwise_progress, 
        "subterfuge": c.subterfuge, "subterfuge_progress": c.subterfuge_progress, 


        "animal_ken": c.animal_ken, "animal_ken_progress": c.animal_ken_progress, 
        "crafts": c.crafts, "crafts_progress": c.crafts_progress, 
        "drive": c.drive, "drive_progress": c.drive_progress, 
        "etiquette": c.etiquette, "etiquette_progress": c.etiquette_progress, 
        "firearms": c.firearms, "firearms_progress": c.firearms_progress, 
        "larceny": c.larceny, "larceny_progress": c.larceny_progress, 
        "melee": c.melee, "melee_progress": c.melee_progress, 
        "performance": c.performance, "performance_progress": c.performance_progress, 
        "stealth": c.stealth, "stealth_progress": c.stealth_progress, 
        "survival": c.survival, "survival_progress": c.survival_progress, 


        "academics": c.academics, "academics_progress": c.academics_progress, 
        "computer": c.computer, "computer_progress": c.computer_progress, 
        "finance": c.finance, "finance_progress": c.finance_progress, 
        "investigation": c.investigation, "investigation_progress": c.investigation_progress, 
        "law": c.law, "law_progress": c.law_progress, 
        "medicine": c.medicine, "medicine_progress": c.medicine_progress, 
        "occult": c.occult, "occult_progress": c.occult_progress, 
        "politics": c.politics, "politics_progress": c.politics_progress, 
        "science": c.science, "science_progress": c.science_progress, 
        "technology": c.technology, "technology_progress": c.technology_progress, 
    }

    rpc_id(multiplayer.get_remote_sender_id(), "receive_ability_upgrade_data", payload)

@rpc("authority")
func receive_ability_upgrade_data(data: Dictionary) -> void :
    print("📥 [Client] Received ability upgrade data:", data)

    var main_ui: = get_tree().get_root().get_node_or_null("MainUI")
    if not main_ui:
        print("❌ [Client] MainUI not found in scene tree.")
        return

    for child in main_ui.get_children():
        if child is Control and child.get_script() != null and child.get_script().resource_path.ends_with("nightly_activities_ui.gd"):
            print("✅ [Client] Found NightlyActivitiesUI, populating panel.")
            child.populate_ability_upgrade_panel(data)
            return

    print("❌ [Client] NightlyActivitiesUI node with matching script not found.")


@rpc("any_peer")
func request_increase_stat(character_name: String, trait_name: String) -> void :
    if not GameManager.character_data_by_name.has(character_name):
        print("⛔ Character not found:", character_name)
        return

    var character: CharacterData = GameManager.character_data_by_name[character_name]
    var peer_id: int = GameManager.name_to_peer.get(character_name, -1)

    if peer_id == -1:
        print("⛔ Peer ID not found for", character_name)
        return

    if character.action_points_current <= 0:
        print("❌ Not enough AP for", character_name)
        rpc_id(peer_id, "receive_message", {
            "speaker": "Nightly Activities", 
            "message": "[color=gray]────────────────────[/color]\nYou've done all you could for now.", 
            "jingle": true
        })
        return


    NightlyActivitiesManager.process_trait_increase(character, trait_name)

@rpc("any_peer")
func request_virtue_upgrade_data(character_name: String) -> void :

    if not GameManager.character_data_by_name.has(character_name):
        return
    var cd: CharacterData = GameManager.character_data_by_name[character_name]


    var peer_id: int = GameManager.name_to_peer.get(character_name, -1)
    if peer_id == -1:
        return


    rpc_id(peer_id, "receive_virtue_upgrade_data", cd.serialize_to_dict())

@rpc("authority")
func receive_virtue_upgrade_data(data: Dictionary) -> void :
    print("📥 [Client] Received virtue/path upgrade data:", data)

    var main_ui: = get_tree().get_root().get_node_or_null("MainUI")
    if not main_ui:
        print("❌ [Client] MainUI not found in scene tree.")
        return

    for child in main_ui.get_children():
        if child is Control and child.get_script() != null and child.get_script().resource_path.ends_with("nightly_activities_ui.gd"):
            print("✅ [Client] Found NightlyActivitiesUI, populating panel.")
            child.populate_virtue_upgrade_panel(data)
            return

    print("❌ [Client] NightlyActivitiesUI node with matching script not found.")

@rpc("any_peer")
func request_NA_CharacterSummary(char_name: String) -> void :
    if not GameManager.character_data_by_name.has(char_name):
        return
    var cd: CharacterData = GameManager.character_data_by_name[char_name]
    var payload: Dictionary = cd.serialize_to_dict()
    rpc_id(multiplayer.get_remote_sender_id(), "receive_NA_CharacterSummary", payload)

@rpc("authority")
func receive_NA_CharacterSummary(data: Dictionary) -> void :
    var nightly_ui: = get_tree().get_root().get_node_or_null("MainUI/NightlyActivitiesUI")
    if nightly_ui:
        nightly_ui.populate_character_summary_from_server(data)





const NA_BASE_INCREMENTS: Array[int] = [500, 350, 175, 88, 44]


@rpc("any_peer")
func request_discipline_upgrade_data(char_name: String) -> void :
    print("📨 [Server] Received discipline upgrade request for:", char_name)

    if not GameManager.character_data_by_name.has(char_name):
        print("❌ [Server] No character data found for:", char_name)
        return

    var cd: CharacterData = GameManager.character_data_by_name[char_name]
    var peer_id: int = multiplayer.get_remote_sender_id()
    var payload: Dictionary = _build_discipline_upgrade_payload(cd)

    print("📦 [Server] Sending discipline upgrade data to client.")
    rpc_id(peer_id, "receive_discipline_upgrade_data", payload)


@rpc("authority")
func receive_discipline_upgrade_data(data: Dictionary) -> void :
    print("📥 [Client] Received discipline upgrade data.")

    var main_ui: Node = get_tree().get_root().get_node_or_null("MainUI")
    if not main_ui:
        print("❌ [Client] MainUI not found in scene tree.")
        return

    for child in main_ui.get_children():
        if child is Control and child.get_script() != null and child.get_script().resource_path.ends_with("nightly_activities_ui.gd"):
            if child.has_method("populate_discipline_upgrade_panel"):
                print("✅ [Client] Populating Discipline panel in NightlyActivitiesUI.")
                child.populate_discipline_upgrade_panel(data)
                return

    print("❌ [Client] NightlyActivitiesUI node with matching script not found.")


@rpc("authority")
func receive_thaumaturgy_paths_data(paths_payload: Array) -> void :
    var main_ui: Node = get_tree().get_root().get_node_or_null("MainUI")
    if not main_ui:
        print("❌ [Client] MainUI not found in scene tree.")
        return

    for child in main_ui.get_children():
        if child is Control and child.get_script() != null and child.get_script().resource_path.ends_with("nightly_activities_ui.gd"):
            if child.has_method("receive_thaumaturgy_paths_data"):
                child.receive_thaumaturgy_paths_data(paths_payload)
                return

    print("❌ [Client] NightlyActivitiesUI node with matching script not found.")


@rpc("authority")
func receive_necromancy_paths_data(paths_payload: Array) -> void :
    var main_ui: Node = get_tree().get_root().get_node_or_null("MainUI")
    if not main_ui:
        print("❌ [Client] MainUI not found in scene tree.")
        return

    for child in main_ui.get_children():
        if child is Control and child.get_script() != null and child.get_script().resource_path.ends_with("nightly_activities_ui.gd"):
            if child.has_method("receive_necromancy_paths_data"):
                child.receive_necromancy_paths_data(paths_payload)
                return

    print("❌ [Client] NightlyActivitiesUI node with matching script not found.")



@rpc("any_peer")
func request_thaum_path_progress(char_name: String, path_label: String) -> void :
    if not GameManager.character_data_by_name.has(char_name):
        print("❌ [Server] No character data for:", char_name)
        return

    var cd: CharacterData = GameManager.character_data_by_name[char_name]
    var peer_id: int = multiplayer.get_remote_sender_id()


    if cd.action_points_current <= 0:
        if peer_id != -1:
            rpc_id(peer_id, "receive_message", {
                "message": "You lack Activity Points.", 
                "speaker": "Nightly Activities", 
                "jingle": true
            })
        return

    var DM_SCRIPT: Script = DisciplineManager.get_script()


    var cur_path_rating: int = DM_SCRIPT.get_thaum_path_rating(cd, path_label)
    var tier_idx: int = clamp(cur_path_rating, 0, 4)
    var base_inc: int = NA_BASE_INCREMENTS[tier_idx]

    var is_thaum_primary: bool = DM_SCRIPT.is_primary_for_character(cd, String(DM_SCRIPT.THAUMATURGY))
    var mult: float = 1.0
    if not is_thaum_primary:
        mult = 1.0 / 2.5

    var inc: int = max(1, int(ceil(float(base_inc) * mult)))


    var result: Dictionary = DM_SCRIPT.progress_thaum_path_with_increment(cd, path_label, inc)


    cd.action_points_current = max(0, cd.action_points_current - 1)


    if peer_id != -1:
        var msg: String = "You studied [b]%s[/b] (+%d progress)." % [String(result.get("path", path_label)), int(result.get("increment", inc))]
        var dots_gained: int = int(result.get("dots_gained", 0))
        if dots_gained > 0:
            msg += "\nPath increased to %d. Thaumaturgy is now %d." % [
                int(result.get("rating_after", 0)), 
                int(result.get("thaumaturgy_after", 0))
            ]

        rpc_id(peer_id, "receive_message", {
            "message": msg, 
            "speaker": "Nightly Activities", 
            "jingle": true
        })


        var update_data: Dictionary = {
            "zone": cd.current_zone, 
            "ap_current": cd.action_points_current, 
            "ap_max": cd.action_points_max, 
            "blood_current": cd.blood_pool, 
            "blood_max": cd.blood_pool_max, 
            "wp_current": cd.willpower_current, 
            "wp_max": cd.willpower_max
        }
        rpc_id(peer_id, "receive_nightly_activities_data", update_data)


        var payload: Dictionary = _build_discipline_upgrade_payload(cd)
        rpc_id(peer_id, "receive_discipline_upgrade_data", payload)



@rpc("any_peer")
func request_necromancy_path_progress(char_name: String, path_label: String) -> void :
    if not GameManager.character_data_by_name.has(char_name):
        print("❌ [Server] No character data for:", char_name)
        return

    var cd: CharacterData = GameManager.character_data_by_name[char_name]
    var peer_id: int = multiplayer.get_remote_sender_id()


    if cd.action_points_current <= 0:
        if peer_id != -1:
            rpc_id(peer_id, "receive_message", {
                "message": "You lack Activity Points.", 
                "speaker": "Nightly Activities", 
                "jingle": true
            })
        return

    var DM_SCRIPT: Script = DisciplineManager.get_script()


    var cur_path_rating: int = DM_SCRIPT.get_necromancy_path_rating(cd, path_label)
    var tier_idx: int = clamp(cur_path_rating, 0, 4)
    var base_inc: int = NA_BASE_INCREMENTS[tier_idx]

    var is_necro_primary: bool = DM_SCRIPT.is_primary_for_character(cd, String(DM_SCRIPT.NECROMANCY))
    var mult: float = 1.0
    if not is_necro_primary:
        mult = 1.0 / 2.5

    var inc: int = max(1, int(ceil(float(base_inc) * mult)))


    var result: Dictionary = DM_SCRIPT.progress_necromancy_path_with_increment(cd, path_label, inc)


    cd.action_points_current = max(0, cd.action_points_current - 1)


    if peer_id != -1:
        var msg: String = "You studied [b]%s[/b] (+%d progress)." % [String(result.get("path", path_label)), int(result.get("increment", inc))]
        var dots_gained: int = int(result.get("dots_gained", 0))
        if dots_gained > 0:
            msg += "\nPath increased to %d. Necromancy is now %d." % [
                int(result.get("rating_after", 0)), 
                int(result.get("necromancy_after", 0))
            ]

        rpc_id(peer_id, "receive_message", {
            "message": msg, 
            "speaker": "Nightly Activities", 
            "jingle": true
        })


        var update_data: Dictionary = {
            "zone": cd.current_zone, 
            "ap_current": cd.action_points_current, 
            "ap_max": cd.action_points_max, 
            "blood_current": cd.blood_pool, 
            "blood_max": cd.blood_pool_max, 
            "wp_current": cd.willpower_current, 
            "wp_max": cd.willpower_max
        }
        rpc_id(peer_id, "receive_nightly_activities_data", update_data)


        var payload: Dictionary = _build_discipline_upgrade_payload(cd)
        rpc_id(peer_id, "receive_discipline_upgrade_data", payload)






func _build_discipline_upgrade_payload(cd: CharacterData) -> Dictionary:
    var DM_SCRIPT: Script = DisciplineManager.get_script()


    var prim_any: Array = DM_SCRIPT.get_in_clan_disciplines_for_character(cd)
    var prim_list: Array[String] = []
    for v in prim_any:
        prim_list.append(String(v))


    var prim_set_lc: = {}
    for d in prim_list:
        prim_set_lc[String(d).to_lower()] = true


    var included_lc: = {}

    var primary: Array[Dictionary] = []
    var out_common: Array[Dictionary] = []
    var out_clan: Array[Dictionary] = []
    var sorcery: Array[Dictionary] = []


    for d in prim_list:
        var dn: = String(d)
        if dn.to_lower() == String(DM_SCRIPT.THAUMATURGY).to_lower():
            continue
        if dn.to_lower() == String(DM_SCRIPT.NECROMANCY).to_lower():
            continue
        var entry: Dictionary = _make_disc_entry(cd, dn, true)
        if not entry.is_empty():
            primary.append(entry)
            included_lc[dn.to_lower()] = true


    for d in (DM_SCRIPT.COMMON_DISCIPLINES as Array):
        var dn: = String(d)
        var lc: = dn.to_lower()
        if prim_set_lc.has(lc):
            continue
        var entry_oc: Dictionary = _make_disc_entry(cd, dn, false)
        if not entry_oc.is_empty() and not included_lc.has(lc):
            out_common.append(entry_oc)
            included_lc[lc] = true


    for d in (DM_SCRIPT.CLAN_DISCIPLINES as Array):
        var dn2: = String(d)
        var lc2: = dn2.to_lower()
        if prim_set_lc.has(lc2):
            continue
        var entry_cc: Dictionary = _make_disc_entry(cd, dn2, false)
        if not entry_cc.is_empty() and not included_lc.has(lc2):
            out_clan.append(entry_cc)
            included_lc[lc2] = true


    var sorc_names: Array[String] = []
    for dn3 in sorc_names:
        var lc3: = String(dn3).to_lower()
        if prim_set_lc.has(lc3):
            continue
        var entry_s: Dictionary = _make_disc_entry(cd, dn3, false)
        if not entry_s.is_empty() and not included_lc.has(lc3):
            sorcery.append(entry_s)
            included_lc[lc3] = true


    for d_name in cd.disciplines.keys():
        var dn4: = String(d_name)
        var lc4: = dn4.to_lower()
        if included_lc.has(lc4) or prim_set_lc.has(lc4):
            continue

        var is_known: = false
        for d in (DM_SCRIPT.COMMON_DISCIPLINES as Array):
            if String(d).to_lower() == lc4:
                is_known = true
                break
        if not is_known:
            for d in (DM_SCRIPT.CLAN_DISCIPLINES as Array):
                if String(d).to_lower() == lc4:
                    is_known = true
                    break
        if not is_known:
            if lc4 == String(DM_SCRIPT.THAUMATURGY).to_lower() or lc4 == String(DM_SCRIPT.NECROMANCY).to_lower():
                is_known = true
        if is_known:
            continue

        var entry_other: Dictionary = _make_disc_entry(cd, dn4, false)
        if not entry_other.is_empty():
            out_clan.append(entry_other)
            included_lc[lc4] = true


    var thaum_paths: Array[Dictionary] = DM_SCRIPT.build_thaum_path_payload(cd)

    var necro_paths: Array[Dictionary] = DM_SCRIPT.build_necromancy_path_payload(cd)

    return {
        "primary": primary, 
        "out_common": out_common, 
        "out_clan": out_clan, 
        "sorcery": sorcery, 
        "thaum_paths": thaum_paths, 
        "necro_paths": necro_paths
    }


func _make_disc_entry(cd: CharacterData, disc_name: String, include_zero: bool) -> Dictionary:
    var rating: int = int(cd.disciplines.get(disc_name, 0))
    var prog: int = int(cd.discipline_progress.get(disc_name, 0))

    if rating <= 0 and prog <= 0 and not include_zero:
        return {}
    return {
        "name": disc_name, 
        "rating": rating, 
        "progress": prog
    }




@rpc("any_peer")
func request_hunt_scenario_list(character_name: String, hunt_type: String) -> void :

    if not GameManager.character_data_by_name.has(character_name):
        print("❌ [Server] Character not found in character_data_by_name:", character_name)
        return

    var _character: CharacterData = GameManager.character_data_by_name[character_name]
    var peer_id: int = GameManager.name_to_peer.get(character_name, -1)

    if peer_id == -1:
        print("❌ [Server] Peer ID not found for character:", character_name)
        return

    var raw_ids: = HuntScenarioManager.get_scenarios_for_type(hunt_type)
    if raw_ids == null:
        return

    var scenario_ids: Array[String] = []
    for id in raw_ids:
        if typeof(id) == TYPE_STRING:
            scenario_ids.append(id)
        else:
            print("⚠️ [Server] Skipped non-string ID in raw_ids:", id)

    print("📤 [Server] Sending scenario list to peer_id %d: %s" % [peer_id, scenario_ids])
    rpc_id(peer_id, "receive_hunt_scenario_list", hunt_type, scenario_ids)


@rpc("authority")
func receive_hunt_scenario_list(hunt_type: String, scenario_ids: Array[String]) -> void :

    var main_ui: = get_tree().get_root().get_node_or_null("MainUI")
    if not main_ui:
        print("❌ [Client] MainUI not found in scene tree.")
        return

    print("🔍 [Client] Searching for NightlyActivitiesUI in MainUI children...")

    for child in main_ui.get_children():
        if child.name == "NightlyActivitiesUI":
            print("✅ [Client] Found NightlyActivitiesUI by node name.")
            child.show_hunt_scenario_options(hunt_type, scenario_ids)
            return

        if child is Control and child.get_script() != null:
            var script_path: String = child.get_script().resource_path
            if script_path != "":
                print("🔹 [Client] Found Control with script:", script_path)
            else:
                print("⚠️ [Client] Control script has empty resource_path.")

            if script_path.ends_with("nightly_activities_ui.gd"):
                print("✅ [Client] Found NightlyActivitiesUI by script path.")
                child.show_hunt_scenario_options(hunt_type, scenario_ids)
                return


    print("❌ [Client] NightlyActivitiesUI node with matching name or script not found.")


@rpc("any_peer")
func request_hunt_contact_phase(character_name: String, hunt_type: String, scenario_id: String) -> void :


    if not GameManager.character_data_by_name.has(character_name):
        return
    var peer_id: int = GameManager.name_to_peer.get(character_name, -1)
    if peer_id == -1:
        print("❌ [Server] Peer ID not found for:", character_name)
        return


    var cd: CharacterData = GameManager.character_data_by_name.get(character_name, null)
    if cd == null:
        return
    if cd.action_points_current <= 0:
        return

    cd.action_points_current = max(0, cd.action_points_current - 1)
    GameManager.character_data_by_name[character_name] = cd


    var update_data: Dictionary = {
        "zone": String(cd.current_zone), 
        "ap_current": int(cd.action_points_current), 
        "ap_max": int(cd.action_points_max), 
        "blood_current": int(cd.blood_pool), 
        "blood_max": int(cd.blood_pool_max), 
        "wp_current": int(cd.willpower_current), 
        "wp_max": int(cd.willpower_max)
    }
    rpc_id(peer_id, "receive_nightly_activities_data", update_data)


    var data: Dictionary = HuntManager.build_contact_phase_payload(hunt_type, scenario_id, cd)
    rpc_id(peer_id, "receive_hunt_contact_phase", hunt_type, scenario_id, data)


@rpc("authority")
func receive_hunt_contact_phase(hunt_type: String, scenario_id: String, data: Dictionary) -> void :
    print("📥 [Client] receive_hunt_contact_phase for %s/%s → %s"
        %[hunt_type, scenario_id, data.get("scenario_name", scenario_id)])

    var main_ui: = get_tree().get_root().get_node_or_null("MainUI")
    if not main_ui:
        print("❌ [Client] MainUI not found.")
        return

    print("🔍 [Client] Looking for NightlyActivitiesUI…")
    for child in main_ui.get_children():

        if child.name == "NightlyActivitiesUI":
            print("✅ [Client] Found NightlyActivitiesUI by name. Rendering contact phase.")
            child.call("show_contact_phase", hunt_type, scenario_id, data)
            return


        if child is Control and child.get_script() != null:
            var script_path: String = child.get_script().resource_path
            if script_path != "" and script_path.ends_with("nightly_activities_ui.gd"):
                print("✅ [Client] Found NightlyActivitiesUI by script path. Rendering contact phase.")
                child.call("show_contact_phase", hunt_type, scenario_id, data)
                return

    print("❌ [Client] NightlyActivitiesUI not found in MainUI children.")





@rpc("any_peer")
func request_hunt_contact_choice(
        character_name: String, 
        hunt_type: String, 
        scenario_id: String, 
        option_index: int, 
        use_specialization: bool = false, 
        use_willpower: bool = false
    ) -> void :

    if not multiplayer.is_server():
        return


    if not GameManager.character_data_by_name.has(character_name):
        return

    var peer_id: int = GameManager.name_to_peer.get(character_name, -1)
    if peer_id == -1:
        print("❌ [Server] request_hunt_contact_choice: peer_id not found for", character_name)
        return



    var payload: Dictionary = HuntManager.process_contact_choice(
        character_name, 
        hunt_type, 
        scenario_id, 
        option_index, 
        use_specialization, 
        use_willpower
    )

    print("📤 [Server] Sending contact result to peer", peer_id, " payload.outcome=", String(payload.get("outcome", "?")))
    rpc_id(peer_id, "receive_hunt_contact_result", hunt_type, scenario_id, payload)



@rpc("authority")
func receive_hunt_contact_result(hunt_type: String, scenario_id: String, result_payload: Dictionary) -> void :

    print("📥 [Client] receive_hunt_contact_result for", hunt_type, "/", scenario_id, 
        " outcome=", String(result_payload.get("outcome", "?")), 
        " net_successes=", str(result_payload.get("roll_result", {}).get("net_successes", 0))
    )

    var main_ui: = get_tree().get_root().get_node_or_null("MainUI")
    if not main_ui:
        print("❌ [Client] MainUI not found in scene tree.")
        return

    for child in main_ui.get_children():
        if child is Control and child.get_script() != null and child.get_script().resource_path.ends_with("nightly_activities_ui.gd"):

            child.call("show_contact_result", hunt_type, scenario_id, result_payload)
            return

    print("❌ [Client] NightlyActivitiesUI node with matching script not found.")

@rpc("any_peer")
func request_hunt_choice(
    character_name: String, 
    hunt_type: String, 
    scenario_id: String, 
    option_index: int, 
    use_specialization: bool = false, 
    use_willpower: bool = false
) -> void :

    if not GameManager.character_data_by_name.has(character_name):
        print("❌ [Server] Unknown character:", character_name)
        return

    var peer_id: int = GameManager.name_to_peer.get(character_name, -1)
    if peer_id == -1:
        print("❌ [Server] No peer for:", character_name)
        return

    var payload: Dictionary = HuntManager.process_hunt_choice(
        character_name, hunt_type, scenario_id, option_index, use_specialization, use_willpower
    )

    rpc_id(peer_id, "receive_hunt_result", hunt_type, scenario_id, payload)


@rpc("authority")
func receive_hunt_result(hunt_type: String, scenario_id: String, result_payload: Dictionary) -> void :
    print("📥 [Client] Received hunt result for '", hunt_type, "/", scenario_id, "': ", result_payload)

    var main_ui: Node = get_tree().get_root().get_node_or_null("MainUI")
    if main_ui == null:
        print("❌ [Client] MainUI not found.")
        return

    var routed: bool = false
    for child in main_ui.get_children():
        if child is Control:
            var ui: Control = child as Control

            var scr: Script = ui.get_script()
            var scr_path: String = ""
            if scr != null:
                scr_path = String(scr.resource_path)

            if scr_path.ends_with("nightly_activities_ui.gd"):
                print("✅ [Client] Found NightlyActivitiesUI. Routing hunt result.")
                if ui.has_method("show_hunt_result"):
                    ui.call("show_hunt_result", hunt_type, scenario_id, result_payload)
                elif ui.has_method("show_contact_result"):
                    ui.call("show_contact_result", hunt_type, scenario_id, result_payload)
                routed = true
                break

    if not routed:
        print("❌ [Client] NightlyActivitiesUI node with matching script not found.")

@rpc("any_peer")
func request_feed_choice(character_name: String, hunt_type: String, scenario_id: String, mode: String) -> void :
    print("📨 [Server] Feed choice request:", character_name, hunt_type, scenario_id, mode)

    if not GameManager.character_data_by_name.has(character_name):
        print("❌ [Server] No character data found for:", character_name)
        return

    var peer_id: int = GameManager.name_to_peer.get(character_name, -1)
    if peer_id == -1:
        print("❌ [Server] Peer ID not found for:", character_name)
        return

    var result_payload: = HuntManager.process_feed_resolution(character_name, hunt_type, scenario_id, mode)
    print("📤 [Server] Sending feed result to", peer_id, ":", result_payload)
    rpc_id(peer_id, "receive_feed_result", result_payload)


@rpc("authority")
func receive_feed_result(payload: Dictionary) -> void :
    print("📥 [Client] Received feed result:", payload)

    var main_ui: Node = get_tree().get_root().get_node_or_null("MainUI")
    if main_ui == null:
        print("❌ [Client] MainUI not found in scene tree.")
        return


    var nightly_ui: Control = main_ui.get_node_or_null("NightlyActivitiesUI") as Control
    if nightly_ui != null and nightly_ui.has_method("show_feed_result"):
        nightly_ui.show_feed_result(payload)
        return


    print("🔍 [Client] Scanning MainUI children for NightlyActivitiesUI...")
    for c in main_ui.get_children():
        if c is Control:
            var ctrl: Control = c
            var script_res: Script = ctrl.get_script()
            var sp: String = ""
            if script_res != null:
                sp = String(script_res.resource_path)
            if sp.ends_with("nightly_activities_ui.gd"):
                print("✅ [Client] Found NightlyActivitiesUI by script:", sp)
                ctrl.show_feed_result(payload)
                return

    print("❌ [Client] NightlyActivitiesUI not found to display feed result.")

@rpc("any_peer")
func request_defeat_choice(
    character_name: String, 
    hunt_type: String, 
    scenario_id: String, 
    option_index: int, 
    use_specialization: bool = false, 
    use_willpower: bool = false
) -> void :
    print("📨 [Server] Defeat choice from:", character_name, hunt_type, scenario_id, "idx:", option_index)

    if not GameManager.character_data_by_name.has(character_name):
        print("❌ [Server] Character not found:", character_name)
        return

    var peer_id: int = GameManager.name_to_peer.get(character_name, -1)
    if peer_id == -1:
        print("❌ [Server] Peer not found for:", character_name)
        return


    var result_payload: Dictionary = HuntManager.process_defeat_choice(
        character_name, hunt_type, scenario_id, option_index, use_specialization, use_willpower
    )

    print("📤 [Server] Sending defeat result to", peer_id, "…")
    rpc_id(peer_id, "receive_defeat_result", hunt_type, scenario_id, result_payload)


@rpc("authority")
func receive_defeat_result(hunt_type: String, scenario_id: String, result_payload: Dictionary) -> void :
    print("📥 [Client] Received defeat result:", result_payload)

    var main_ui: = get_tree().get_root().get_node_or_null("MainUI")
    if not main_ui:
        print("❌ [Client] MainUI not found.")
        return


    var ui: = main_ui.get_node_or_null("NightlyActivitiesUI")
    if ui:
        print("✅ [Client] Found NightlyActivitiesUI, rendering defeat result.")
        ui.call("show_defeat_result", hunt_type, scenario_id, result_payload)
        return


    for child in main_ui.get_children():
        if child is Control and child.get_script() != null and child.get_script().resource_path.ends_with("nightly_activities_ui.gd"):
            print("✅ [Client] Found NightlyActivitiesUI by script, rendering defeat result.")
            child.call("show_defeat_result", hunt_type, scenario_id, result_payload)
            return

    print("❌ [Client] NightlyActivitiesUI not found to render defeat result.")

@rpc("any_peer")
func request_arm_willpower_for_next_roll(char_name: String) -> void :

    if not GameManager.character_data_by_name.has(char_name):
        print("❌ [Server] request_arm_willpower_for_next_roll: no character:", char_name)
        return
    var peer_id: int = GameManager.name_to_peer.get(char_name, -1)
    if peer_id == -1:
        print("❌ [Server] request_arm_willpower_for_next_roll: no peer for", char_name)
        return


    var res: Dictionary = HuntManager.arm_willpower_for_next_roll(char_name)


    var upd: Dictionary
    if bool(res.get("ok", false)):
        upd = {
            "zone": String(res.get("zone", "")), 
            "ap_current": int(res.get("ap_current", 0)), 
            "ap_max": int(res.get("ap_max", 0)), 
            "blood_current": int(res.get("blood_current", 0)), 
            "blood_max": int(res.get("blood_max", 0)), 
            "wp_current": int(res.get("wp_current", 0)), 
            "wp_max": int(res.get("wp_max", 0))
        }
    else:
        var cd: CharacterData = GameManager.character_data_by_name[char_name]
        upd = {
            "zone": String(cd.current_zone), 
            "ap_current": int(cd.action_points_current), 
            "ap_max": int(cd.action_points_max), 
            "blood_current": int(cd.blood_pool), 
            "blood_max": int(cd.blood_pool_max), 
            "wp_current": int(cd.willpower_current), 
            "wp_max": int(cd.willpower_max)
        }


    rpc_id(peer_id, "receive_nightly_activities_data", upd)



signal group_presence_received(entries: Array[Dictionary])
signal member_na_panel_status(name: String, opened: bool)
signal group_summary_received(group_name: String, members: Array[String], founder: String)

var na_panel_open_by_name: Dictionary = {}



@rpc("any_peer")
func request_group_summary(requester_name: String) -> void :
    if not multiplayer.is_server():
        return

    var g: String = GroupManager.get_group_of(requester_name)
    var members: Array[String] = []
    var founder: String = ""

    if g != "":
        members = GroupManager.get_group_members(g)
        founder = String(GroupManager.groups[g].get("founder", ""))

    var pid: int = int(GameManager.name_to_peer.get(requester_name, -1))
    if pid != -1:
        rpc_id(pid, "receive_group_summary", g, members, founder)


@rpc("authority")
func receive_group_summary(group_name: String, members: Array, founder: String) -> void :
    var typed: Array[String] = []
    for m in members:
        typed.append(String(m))
    emit_signal("group_summary_received", String(group_name), typed, String(founder))

@rpc("any_peer")
func request_group_presence(requester_name: String) -> void :
    if not multiplayer.is_server():
        return

    var out: Array[Dictionary] = []
    var g: String = GroupManager.get_group_of(requester_name)
    if g != "":
        var founder: String = String(GroupManager.groups[g].get("founder", ""))
        var members: Array[String] = GroupManager.get_group_members(g)


        var req_cd: CharacterData = GameManager.character_data_by_name.get(requester_name, null)
        var zone: Dictionary = {}
        var neighborhood: bool = false
        if req_cd != null:
            zone = ZoneManager.zones.get(req_cd.current_zone, {})
            neighborhood = bool(zone.get("is_neighborhood", false))


        for m in members:
            var entry: Dictionary = {}
            entry["name"] = String(m)
            entry["is_founder"] = (String(m) == founder)

            var same_zone: = false
            if neighborhood and zone.has("characters"):
                var chars: Array = zone["characters"] as Array
                for cd in chars:
                    if cd and String(cd.name) == String(m):
                        same_zone = true
                        break
            entry["same_zone"] = same_zone
            entry["na_open"] = bool(na_panel_open_by_name.get(m, false))
            out.append(entry)

    var pid: int = int(GameManager.name_to_peer.get(requester_name, -1))
    if pid != -1:
        rpc_id(pid, "receive_group_presence", out)

@rpc("authority")
func receive_group_presence(entries: Array) -> void :

    emit_signal("group_presence_received", entries)

@rpc("any_peer")
func request_notify_na_panel_open(char_name: String, opened: bool) -> void :

    if multiplayer.get_unique_id() != 1:
        return


    na_panel_open_by_name[char_name] = opened


    var grp: Node = get_node_or_null("/root/GroupManager")
    if grp == null:
        return

    var gname: String = String(grp.call("get_group_of", char_name))
    if gname == "":
        return

    var members_v: Variant = grp.call("get_group_members", gname)
    var members: Array[String] = []
    if typeof(members_v) == TYPE_ARRAY:
        for m in (members_v as Array):
            members.append(String(m))

    for member_name in members:
        var pid: int = int(GameManager.name_to_peer.get(member_name, -1))
        if pid != -1:
            rpc_id(pid, "receive_member_na_panel_status", char_name, opened)

@rpc("authority")
func receive_member_na_panel_status(member_name: String, opened: bool) -> void :
    emit_signal("member_na_panel_status", String(member_name), bool(opened))












@rpc("any_peer", "reliable")
func request_blush_of_life(char_name: String) -> void :
    if not multiplayer.is_server():
        print("⚠️ [Blush] Ignored on client for:", char_name)
        return

    var requester_id: int = multiplayer.get_remote_sender_id()
    print("➡️ [Blush] Request from peer", requester_id, "for char:", char_name)


    var cd: CharacterData = GameManager.character_data_by_name.get(char_name) as CharacterData
    var peer_id: int = int(GameManager.name_to_peer.get(char_name, requester_id))
    print("🧭 [Blush] Resolved peer_id:", peer_id, " cd is null?:", cd == null)

    if cd == null:
        print("❌ [Blush] Character not found on server for:", char_name)
        var pkt_nf: Dictionary = {"message": CHAT_DIVIDER + "❌ Character not found on server."}
        print("✉️ [Blush] rpc_id(", peer_id, ", receive_message, ", pkt_nf, ")")
        rpc_id(peer_id, "receive_message", pkt_nf)
        return


    if cd.path_name != "Humanity":
        print("🧪 [Blush] Path not Humanity. path_name:", cd.path_name)
        var pkt_path: Dictionary = {"message": CHAT_DIVIDER + "You've stopped lying to yourself."}
        print("✉️ [Blush] rpc_id(", peer_id, ", receive_message, ", pkt_path, ")")
        rpc_id(peer_id, "receive_message", pkt_path)
        return


    if cd.blush_of_life == true:
        print("🔁 [Blush] Already active for:", char_name)
        var pkt_already: Dictionary = {"message": CHAT_DIVIDER + "You're already passing for a mortal."}
        print("✉️ [Blush] rpc_id(", peer_id, ", receive_message, ", pkt_already, ")")
        rpc_id(peer_id, "receive_message", pkt_already)
        return


    var cost: int = max(0, 8 - int(cd.path))
    print("🧮 [Blush] Computed cost:", cost, "from path:", int(cd.path))


    if cd.blood_pool < cost:
        print("🩸 [Blush] Not enough blood. Have:", cd.blood_pool, "Need:", cost)
        var pkt_low: Dictionary = {"message": CHAT_DIVIDER + "There is not enough vitae in your body to fake your humanity."}
        print("✉️ [Blush] rpc_id(", peer_id, ", receive_message, ", pkt_low, ")")
        rpc_id(peer_id, "receive_message", pkt_low)
        return


    cd.blush_of_life = true
    cd.blood_pool = max(0, cd.blood_pool - cost)
    print("✅ [Blush] Applied. New blood_pool:", cd.blood_pool, "blush_of_life:", cd.blush_of_life)

    var msg: String = CHAT_DIVIDER + "Your corpselike figure takes life.\nYou spend [b]%d[/b] blood. Remaining: [b]%d[/b]." % [cost, cd.blood_pool]
    var pkt_ok: Dictionary = {"message": msg}
    print("📤 [Blush] Sending result via receive_message to", peer_id, "msg:", msg)
    print("✉️ [Blush] rpc_id(", peer_id, ", receive_message, ", pkt_ok, ")")
    rpc_id(peer_id, "receive_message", pkt_ok)





@rpc("any_peer")
func request_heal_bash_lethal(character_name: String) -> void :
    var hm = get_node("/root/HealManager")
    if hm and hm.has_method("process_heal_bash_lethal"):
        hm.process_heal_bash_lethal(character_name)

@rpc("any_peer")
func request_heal_aggravated(character_name: String) -> void :
    var hm: Node = get_node("/root/HealManager")
    if hm and hm.has_method("process_heal_aggravated"):
        hm.process_heal_aggravated(character_name)

@rpc("any_peer")
func request_st_heal_aggravated(character_name: String, amount: int) -> void :
    var hm: Node = get_node("/root/HealManager")
    if hm and hm.has_method("process_st_heal_aggravated"):
        hm.process_st_heal_aggravated(character_name, amount)






@rpc("any_peer")
func request_st_damage_bash_lethal(target_name: String, amount: int) -> void :
    if amount <= 0:
        return
    if not GameManager.character_data_by_name.has(target_name):
        return

    var data: CharacterData = GameManager.character_data_by_name[target_name]


    var max_idx: int = max(0, data.health_levels.size() - 1)
    data.health_index = clamp(data.health_index + amount, 0, max_idx)


    var zone_name: String = data.current_zone
    var zone_data: Dictionary = ZoneManager.zones.get(zone_name, {})
    var characters_in_zone: Array = zone_data.get("characters", [])

    var msg: String = "%s[b]%s[/b] suffers %d wound%s." % [
        CHAT_DIVIDER, 
        target_name, 
        amount, 
        ("" if amount == 1 else "s")
    ]
    var packet: Dictionary = {"message": msg, "speaker": target_name}

    var notified: Dictionary = {}
    for cd in characters_in_zone:
        if not cd or not cd.has_method("get"):
            continue
        var c_name: String = cd.name
        var pid: int = GameManager.character_peers.get(c_name, -1)
        if pid != -1 and not notified.has(pid):
            rpc_id(pid, "receive_message", packet)
            notified[pid] = true


@rpc("any_peer")
func request_st_damage_aggravated(target_name: String, amount: int) -> void :
    if amount <= 0:
        return
    if not GameManager.character_data_by_name.has(target_name):
        return

    var data: CharacterData = GameManager.character_data_by_name[target_name]


    if not ("aggravated_wounds" in data) or typeof(data.aggravated_wounds) != TYPE_ARRAY:
        data.aggravated_wounds = []


    var calendar: Node = get_node("/root/CalendarManager")
    var cur_date: String = calendar.get_current_date_string()


    var max_idx: int = max(0, data.health_levels.size() - 1)
    data.health_index = clamp(data.health_index + amount, 0, max_idx)
    for i in range(amount):
        data.aggravated_wounds.append(cur_date)


    var zone_name: String = data.current_zone
    var zone_data: Dictionary = ZoneManager.zones.get(zone_name, {})
    var characters_in_zone: Array = zone_data.get("characters", [])

    var msg: String = "%s[b]%s[/b] suffers %d aggravated wound%s." % [
        CHAT_DIVIDER, 
        target_name, 
        amount, 
        ("" if amount == 1 else "s")
    ]
    var packet: Dictionary = {"message": msg, "speaker": target_name}

    var notified: Dictionary = {}
    for cd in characters_in_zone:
        if not cd or not cd.has_method("get"):
            continue
        var c_name: String = cd.name
        var pid: int = GameManager.character_peers.get(c_name, -1)
        if pid != -1 and not notified.has(pid):
            rpc_id(pid, "receive_message", packet)
            notified[pid] = true






signal herd_state_received(data: Dictionary)
signal herd_feed_result(data: Dictionary)


@rpc("any_peer")
func request_herd_state(character_name: String) -> void :
    if not multiplayer.is_server():
        return

    var caller_id: int = multiplayer.get_remote_sender_id()
    var peer_id: int = int(GameManager.name_to_peer.get(character_name, caller_id))
    if peer_id == 0:
        peer_id = caller_id

    var payload: Dictionary = HerdManager.get_state(character_name)

    print("NM ▶ herd_state → to peer", peer_id, " for:", character_name, " payload keys:", payload.keys())
    rpc_id(peer_id, "receive_herd_state", payload)


@rpc("any_peer")
func request_herd_create_member(character_name: String, index: int, member_name: String) -> void :
    if not multiplayer.is_server():
        return
    var caller_id: int = multiplayer.get_remote_sender_id()
    var peer_id: int = int(GameManager.name_to_peer.get(character_name, caller_id))
    if peer_id == 0:
        peer_id = caller_id

    var payload: Dictionary = HerdManager.create_member(character_name, index, member_name)

    print("NM ▶ herd_create → to peer", peer_id, " idx:", index, " name:", member_name)
    rpc_id(peer_id, "receive_herd_state", payload)


@rpc("any_peer")
func request_herd_feed(character_name: String, index: int, mode: String) -> void :
    if not multiplayer.is_server():
        return
    var caller_id: int = multiplayer.get_remote_sender_id()
    var peer_id: int = int(GameManager.name_to_peer.get(character_name, caller_id))
    if peer_id == 0:
        peer_id = caller_id


    var payload: Dictionary = HerdManager.feed(character_name, index, mode)
    print("NM ▶ herd_feed → to peer", peer_id, " idx:", index, " mode:", mode)

    rpc_id(peer_id, "receive_herd_state", payload.get("state", {}))
    rpc_id(peer_id, "receive_herd_feed_result", payload.get("result", {}))


    if GameManager.character_data_by_name.has(character_name):
        var cd: CharacterData = GameManager.character_data_by_name[character_name]
        var summary: = {
            "zone": cd.current_zone, 
            "ap_current": cd.action_points_current, 
            "ap_max": cd.action_points_max, 
            "blood_current": cd.blood_pool, 
            "blood_max": cd.blood_pool_max, 
            "wp_current": cd.willpower_current, 
            "wp_max": cd.willpower_max, 
            "herd_dots": cd.herd, 
        }
        rpc_id(peer_id, "receive_nightly_activities_data", summary)



@rpc("any_peer")
func receive_herd_state(data: Dictionary) -> void :

    print("NM ◀ herd_state (client) members:", data.get("members", []))
    herd_state_received.emit(data)


@rpc("any_peer")
func receive_herd_feed_result(data: Dictionary) -> void :

    print("NM ◀ herd_feed_result (client) msg:", data.get("message", ""))
    herd_feed_result.emit(data)



signal mentor_target_list_received(names: Array)
signal mentor_discipline_list_received(student_name: String, disciplines: Array)
signal mentor_invite_received(payload: Dictionary)
signal mentor_teaching_options_received(student_name: String, subject: String, options: Array, auto_select: bool, auto_value: String, auto_label: String)



var na_panel_open: Dictionary = {}
var mentor_pending_invites: Dictionary = {}

@rpc("any_peer")
func request_mentor_target_list(teacher_name: String) -> void :
    if multiplayer.get_unique_id() != 1:
        return
    var sender_id: = multiplayer.get_remote_sender_id()
    var actual: = String(GameManager.peer_to_character_name.get(sender_id, ""))
    if actual != teacher_name:
        return

    var mgr: = get_node_or_null("/root/MentorManager")
    if mgr == null:
        return

    var names_v: Variant = mgr.call("get_eligible_targets", teacher_name)
    var names: Array[String] = []
    if names_v is Array:
        for n in (names_v as Array):
            names.append(String(n))


    rpc_id(sender_id, "receive_mentor_target_list", names)

@rpc("authority")
func receive_mentor_target_list(names: Array) -> void :
    emit_signal("mentor_target_list_received", names)


@rpc("any_peer")
func request_mentor_discipline_list(teacher_name: String, student_name: String) -> void :
    if multiplayer.get_unique_id() != 1:
        return
    var sender_id: = multiplayer.get_remote_sender_id()
    var actual: = String(GameManager.peer_to_character_name.get(sender_id, ""))
    if actual != teacher_name:
        return

    var mgr: = get_node_or_null("/root/MentorManager")
    if mgr == null:
        return

    var discs_v: Variant = mgr.call("get_teachable_disciplines", teacher_name, student_name)
    var discs: Array[String] = []
    if discs_v is Array:
        for d in (discs_v as Array):
            discs.append(String(d))

    rpc_id(sender_id, "receive_mentor_discipline_list", student_name, discs)


@rpc("authority")
func receive_mentor_discipline_list(student_name: String, disciplines: Array) -> void :
    emit_signal("mentor_discipline_list_received", student_name, disciplines)

@rpc("any_peer")
func request_mentor_teaching_options(teacher_name: String, student_name: String, subject: String) -> void :
    if multiplayer.get_unique_id() != 1:
        return
    var sender_id: = multiplayer.get_remote_sender_id()
    var actual: = String(GameManager.peer_to_character_name.get(sender_id, ""))
    if actual != teacher_name:
        return

    var mgr: = get_node_or_null("/root/MentorManager")
    if mgr == null:
        return

    var result_v: Variant = mgr.call("get_teaching_options", teacher_name, student_name, subject)
    if not (result_v is Dictionary):
        return
    var result: Dictionary = result_v as Dictionary

    var options: Array = result.get("options", []) as Array
    var auto_select: bool = bool(result.get("auto_select", false))
    var auto_value: String = String(result.get("auto_value", ""))
    var auto_label: String = String(result.get("auto_label", ""))

    rpc_id(sender_id, "receive_mentor_teaching_options", student_name, subject, options, auto_select, auto_value, auto_label)

@rpc("authority")
func receive_mentor_teaching_options(student_name: String, subject: String, options: Array, auto_select: bool, auto_value: String, auto_label: String) -> void :
    emit_signal("mentor_teaching_options_received", student_name, subject, options, auto_select, auto_value, auto_label)


@rpc("any_peer")
func request_send_mentor_invite(
    teacher_name: String, 
    student_name: String, 
    discipline: String, 
    subject: String = "Discipline", 
    invite_type: String = "discipline_class", 
    topic_label: String = ""
) -> void :
    if multiplayer.get_unique_id() != 1:
        return
    var sender_id: = multiplayer.get_remote_sender_id()
    var actual: = String(GameManager.peer_to_character_name.get(sender_id, ""))
    if actual != teacher_name:
        return


    mentor_pending_invites[student_name] = {
        "teacher": teacher_name, 
        "discipline": discipline, 
        "subject": subject, 
        "invite_type": invite_type, 
        "topic_label": topic_label, 
        "created_at": Time.get_unix_time_from_system()
    }

    var display_label: String = topic_label if topic_label != "" else discipline
    if display_label == "":
        display_label = subject

    var payload: = {
        "type": "mentor_invite", 
        "teacher": teacher_name, 
        "student": student_name, 
        "discipline": discipline, 
        "subject": subject, 
        "topic_label": display_label, 
        "message": "[i]%s offers to teach you %s. Accept?[/i]" % [teacher_name, display_label], 
        "jingle": true
    }

    var target_pid: = int(GameManager.name_to_peer.get(student_name, -1))
    if target_pid != -1:
        rpc_id(target_pid, "receive_mentor_invite", payload)


@rpc("authority")
func receive_mentor_invite(payload: Dictionary) -> void :
    emit_signal("mentor_invite_received", payload)


@rpc("any_peer")
func request_respond_mentor_invite(student_name: String, accept: bool) -> void :

    if multiplayer.get_unique_id() != 1:
        return

    var invite: Dictionary = mentor_pending_invites.get(student_name, {}) as Dictionary
    if invite.is_empty():
        var pid_miss: int = int(GameManager.name_to_peer.get(student_name, -1))
        if pid_miss != -1:
            rpc_id(pid_miss, "receive_message", {
                "message": CHAT_DIVIDER + "[i]No pending teaching invitation found.[/i]", 
                "speaker": "Nightly Activities", 
                "jingle": true
            })
        return


    mentor_pending_invites.erase(student_name)

    var teacher_name: String = String(invite.get("teacher", ""))
    var discipline: String = String(invite.get("discipline", ""))
    var subject: String = String(invite.get("subject", "Discipline"))
    var invite_type: String = String(invite.get("invite_type", "discipline_class"))
    var topic_label: String = String(invite.get("topic_label", ""))

    if not accept:
        var s_pid: int = int(GameManager.name_to_peer.get(student_name, -1))
        if s_pid != -1:
            rpc_id(s_pid, "receive_message", {
                "message": CHAT_DIVIDER + "[i]You declined the teaching offer from %s.[/i]" % teacher_name, 
                "speaker": "Nightly Activities", 
                "jingle": true
            })
        var t_pid: int = int(GameManager.name_to_peer.get(teacher_name, -1))
        if t_pid != -1:
            rpc_id(t_pid, "receive_message", {
                "message": CHAT_DIVIDER + "[i]%s declined your teaching offer.[/i]" % student_name, 
                "speaker": "Nightly Activities", 
                "jingle": true
            })
        return

    var mgr: = get_node_or_null("/root/MentorManager")
    if mgr == null:
        var s_pid2: int = int(GameManager.name_to_peer.get(student_name, -1))
        if s_pid2 != -1:
            rpc_id(s_pid2, "receive_message", {
                "message": CHAT_DIVIDER + "[i]Teaching could not be processed.[/i]", 
                "speaker": "Nightly Activities", 
                "jingle": true
            })
        return

    var res: Dictionary = {}
    if invite_type == "mentor_training":
        res = mgr.call("accept_training_invite", teacher_name, student_name, subject, discipline, topic_label)
    else:
        res = mgr.call("accept_teach_invite", teacher_name, student_name, discipline)
    var ok: bool = bool(res.get("ok", false))
    if not ok:
        var code: String = String(res.get("code", "error"))
        var msg: = CHAT_DIVIDER + "[i]Teaching failed: %s[/i]" % code
        var s_pid3: int = int(GameManager.name_to_peer.get(student_name, -1))
        if s_pid3 != -1:
            rpc_id(s_pid3, "receive_message", {"message": msg, "speaker": "Nightly Activities", "jingle": true})
        var t_pid2: int = int(GameManager.name_to_peer.get(teacher_name, -1))
        if t_pid2 != -1:
            rpc_id(t_pid2, "receive_message", {"message": msg, "speaker": "Nightly Activities", "jingle": true})
        return








signal physical_attributes_data_received(data: Dictionary)


@rpc("any_peer", "reliable")
func request_physical_attributes_data(character_name) -> void :
    if not multiplayer.is_server():
        return
    var peer_id: int = multiplayer.get_remote_sender_id()
    var cname: String = String(character_name)
    var cd: CharacterData = GameManager.character_data_by_name.get(cname, null)
    if cd == null:
        return
    _send_physical_payload(peer_id, cname, cd)


@rpc("any_peer", "reliable")
func request_increase_physical_attribute(character_name, trait_name) -> void :
    if not multiplayer.is_server():
        return

    var cname: String = String(character_name)
    var tname: String = String(trait_name).to_lower()
    var cd: CharacterData = GameManager.character_data_by_name.get(cname, null)
    if cd == null:
        return


    if int(cd.blood_pool) <= 0:
        var no_bp_peer: int = int(GameManager.character_peers.get(cname, -1))
        if no_bp_peer != -1:
            var out_of_blood: = {
                "message": "[color=gray]────────────────────[/color]\nYou're out of blood.", 
                "speaker": cname, 
                "jingle": false
            }
            rpc_id(no_bp_peer, "receive_message", out_of_blood)
            _send_physical_payload(no_bp_peer, cname, cd)
        return


    if tname != "strength" and tname != "dexterity" and tname != "stamina":
        var bad_peer: int = int(GameManager.character_peers.get(cname, -1))
        if bad_peer != -1:
            _send_physical_payload(bad_peer, cname, cd)
        return


    cd.blood_pool = max(0, int(cd.blood_pool) - 1)
    match tname:
        "strength":
            cd.strength = int(cd.strength) + 1
            cd.strength_blood_increased = int(cd.strength_blood_increased) + 1
        "dexterity":
            cd.dexterity = int(cd.dexterity) + 1
            cd.dexterity_blood_increased = int(cd.dexterity_blood_increased) + 1
        "stamina":
            cd.stamina = int(cd.stamina) + 1
            cd.stamina_blood_increased = int(cd.stamina_blood_increased) + 1


    var my_peer: int = int(GameManager.character_peers.get(cname, -1))
    if my_peer != -1:
        var nice: String = tname.substr(0, 1).to_upper() + tname.substr(1, tname.length() - 1)
        var to_self: = {
            "message": "[color=gray]────────────────────[/color]\nYou increased %s by 1!" % nice, 
            "speaker": cname, 
            "jingle": true
        }
        rpc_id(my_peer, "receive_message", to_self)


    var zone_name: String = String(cd.current_zone)
    var zone_data: Dictionary = ZoneManager.zones.get(zone_name, {}) as Dictionary
    var chars_in_zone: Array = zone_data.get("characters", []) as Array
    var to_others: = {
        "message": "[color=gray]────────────────────[/color]\n%s is focusing on a Physical Trait!" % cname, 
        "speaker": cname, 
        "jingle": true
    }
    for other_cd in chars_in_zone:
        if not other_cd or not other_cd.has_method("get"):
            continue
        var other_name: String = String(other_cd.name)
        if other_name == cname:
            continue
        var pid_other: int = int(GameManager.character_peers.get(other_name, -1))
        if pid_other != -1:
            rpc_id(pid_other, "receive_message", to_others)


    if my_peer != -1:
        _send_physical_payload(my_peer, cname, cd)


func _send_physical_payload(peer_id: int, character_name: String, cd: CharacterData) -> void :
    if int(peer_id) == -1:
        return
    var payload: = {
        "name": String(character_name), 
        "strength": int(cd.strength), 
        "dexterity": int(cd.dexterity), 
        "stamina": int(cd.stamina), 
        "blood_pool": int(cd.blood_pool), 
        "strength_blood_increased": int(cd.strength_blood_increased), 
        "dexterity_blood_increased": int(cd.dexterity_blood_increased), 
        "stamina_blood_increased": int(cd.stamina_blood_increased), 
    }
    rpc_id(int(peer_id), "deliver_physical_attributes_data", payload)


@rpc("authority")
func deliver_physical_attributes_data(data: Dictionary) -> void :
    emit_signal("physical_attributes_data_received", data)


@rpc("any_peer")
func request_reset_physical_blood_bonuses(char_name) -> void :
    if not multiplayer.is_server():
        print("⏭️ [ResetPhysical] Ignored on client peer:", multiplayer.get_unique_id())
        return

    var requester: int = multiplayer.get_remote_sender_id()
    var cname: String = String(char_name)
    print("🔁 [ResetPhysical] Server received reset request from peer %d for '%s'" % [requester, cname])

    if not GameManager.character_data_by_name.has(cname):
        print("❌ [ResetPhysical] character_data_by_name has no entry for:", cname)
        return

    var cd: CharacterData = GameManager.character_data_by_name.get(cname, null)
    if cd == null:
        print("❌ [ResetPhysical] CharacterData is null for:", cname)
        return


    print("📊 [ResetPhysical] BEFORE  S:%d(+%d)  D:%d(+%d)  T:%d(+%d)  | Blood:%d"
        %[int(cd.strength), int(cd.strength_blood_increased), 
           int(cd.dexterity), int(cd.dexterity_blood_increased), 
           int(cd.stamina), int(cd.stamina_blood_increased), 
           int(cd.blood_pool)])


    var s_inc: int = int(cd.strength_blood_increased)
    var d_inc: int = int(cd.dexterity_blood_increased)
    var t_inc: int = int(cd.stamina_blood_increased)

    if s_inc > 0:
        cd.strength = max(0, int(cd.strength) - s_inc)
    if d_inc > 0:
        cd.dexterity = max(0, int(cd.dexterity) - d_inc)
    if t_inc > 0:
        cd.stamina = max(0, int(cd.stamina) - t_inc)

    cd.strength_blood_increased = 0
    cd.dexterity_blood_increased = 0
    cd.stamina_blood_increased = 0


    print("✅ [ResetPhysical] AFTER   S:%d  D:%d  T:%d  | Increments reset to 0"
        %[int(cd.strength), int(cd.dexterity), int(cd.stamina)])


    var pid: int = int(GameManager.character_peers.get(cname, -1))
    print("📤 [ResetPhysical] _send_physical_payload → pid:", pid)
    if pid != -1:
        _send_physical_payload(pid, cname, cd)
    else:
        print("⚠️ [ResetPhysical] No peer id found for '%s'; payload not sent." % cname)

@rpc("any_peer")
func request_grant_ap(target_name: String) -> void :
    if not multiplayer.is_server():
        return

    var sender_pid: int = multiplayer.get_remote_sender_id()
    var st_name: String = String(GameManager.peer_to_character_name.get(sender_pid, ""))
    var st: CharacterData = GameManager.character_data_by_name.get(st_name, null)
    if st == null or not st.is_storyteller:
        return

    var t: CharacterData = GameManager.character_data_by_name.get(target_name, null)
    if t == null:
        return

    if t.action_points_current >= t.action_points_max:
        rpc_id(sender_pid, "receive_message", {
            "message": "[i]%s is already at max AP (%d/%d).[/i]" % [
                target_name, t.action_points_current, t.action_points_max]
        })
        return

    t.action_points_current = min(t.action_points_max, t.action_points_current + 1)


    rpc_id(sender_pid, "receive_message", {
        "message": "[i]Granted 1 AP to %s (%d/%d).[/i]" % [
            target_name, t.action_points_current, t.action_points_max]
    })


    var target_pid: int = int(GameManager.name_to_peer.get(target_name, -1))
    if target_pid != -1:
        rpc_id(target_pid, "receive_message", {
            "speaker": "Nightly Activities", 
            "message": "You gained 1 Action Point. (%d/%d)" % [
                t.action_points_current, t.action_points_max], 
            "jingle": true
        })
        rpc_id(target_pid, "receive_nightly_activities_data", {
            "zone": String(t.current_zone), 
            "ap_current": int(t.action_points_current), 
            "ap_max": int(t.action_points_max), 
            "blood_current": int(t.blood_pool), 
            "blood_max": int(t.blood_pool_max), 
            "wp_current": int(t.willpower_current), 
            "wp_max": int(t.willpower_max)
        })

@rpc("any_peer")
func request_lose_one_blood(char_name: String) -> void :
    if not multiplayer.is_server():
        return

    var sender_id: int = multiplayer.get_remote_sender_id()
    var requester_name: String = String(GameManager.peer_to_character_name.get(sender_id, ""))


    if requester_name != char_name:
        var req_cd: CharacterData = GameManager.character_data_by_name.get(requester_name, null)
        if req_cd == null or not req_cd.is_storyteller:
            print("⛔ Unauthorized blood loss request by", requester_name, "for", char_name)
            return

    var cd: CharacterData = GameManager.character_data_by_name.get(char_name, null)
    if cd == null:
        print("❌ Character not found:", char_name)
        return

    if cd.blood_pool <= 0:
        var pid_zero: int = int(GameManager.name_to_peer.get(char_name, -1))
        if pid_zero != -1:
            rpc_id(pid_zero, "receive_message", {
                "speaker": "System", 
                "message": "You have no Blood left to lose."
            })
        return

    cd.blood_pool = max(0, cd.blood_pool - 1)

    var target_pid: int = int(GameManager.name_to_peer.get(char_name, -1))
    if target_pid != -1:

        rpc_id(target_pid, "receive_message", {
            "speaker": "System", 
            "message": "You lose 1 Blood. (%d/%d)" % [cd.blood_pool, cd.blood_pool_max], 
            "jingle": true
        })

        rpc_id(target_pid, "receive_nightly_activities_data", {
            "zone": String(cd.current_zone), 
            "ap_current": int(cd.action_points_current), 
            "ap_max": int(cd.action_points_max), 
            "blood_current": int(cd.blood_pool), 
            "blood_max": int(cd.blood_pool_max), 
            "wp_current": int(cd.willpower_current), 
            "wp_max": int(cd.willpower_max)
        })



@rpc("any_peer")
func request_blood_bond_data(character_name: String) -> void :

    if multiplayer.get_unique_id() != 1:
        return

    var sender_id: int = multiplayer.get_remote_sender_id()
    var sender_name: String = String(GameManager.peer_to_character_name.get(sender_id, ""))
    var cd: CharacterData = GameManager.character_data_by_name.get(character_name, null) as CharacterData
    if cd == null:
        print("❌ No character data found for:", character_name)
        return

    var bonds: Dictionary = (cd.blood_bonds as Dictionary).duplicate(true)
    rpc_id(sender_id, "receive_blood_bond_data", character_name, bonds)
    print("📤 Sent Blood Bond data for %s to %s (peer %d)" % [character_name, sender_name, sender_id])


@rpc("authority")
func receive_blood_bond_data(character_name: String, bonds: Dictionary) -> void :
    print("📥 Received Blood Bond data for:", character_name)

    var ui: Control = GameManager.character_uis.get(character_name, null) as Control
    if ui == null:
        print("❌ UI not found for", character_name)
        return

    var menu: Node = ui.get_node_or_null("bloodbondUI")
    if menu == null:
        print("❌ bloodbondUI not found under MainUI for", character_name)
        return

    menu.call("display_blood_bond_data", bonds)
    print("✅ Blood Bond data displayed for", character_name)




@rpc("any_peer")
func request_force_blood_bond(source_name: String, target_name: String) -> void :

    if multiplayer.get_unique_id() != 1:
        return

    var sender_id: int = multiplayer.get_remote_sender_id()
    var sender_name: String = String(GameManager.peer_to_character_name.get(sender_id, ""))
    var sender_cd: CharacterData = GameManager.character_data_by_name.get(sender_name, null) as CharacterData
    var is_storyteller: bool = sender_cd != null and sender_cd.is_storyteller


    if sender_name != source_name and not is_storyteller:
        print("⛔ Denied blood bond: sender mismatch. Sender:", sender_name, " Source:", source_name)
        return


    var mgr: BloodBondManager = get_node_or_null("/root/BloodBondManager") as BloodBondManager
    if mgr == null:
        mgr = BloodBondManager.new()
        add_child(mgr)

    var result: Dictionary = mgr.force_blood_bond_point(source_name, target_name)
    print("🩸 Blood Bond result:", String(result.get("code", "")), " target:", target_name, " source:", source_name)


    var target_peer: int = int(GameManager.name_to_peer.get(target_name, 0))
    if target_peer != 0:
        var target_cd: CharacterData = GameManager.character_data_by_name.get(target_name, null) as CharacterData
        if target_cd != null:
            var bonds: Dictionary = (target_cd.blood_bonds as Dictionary).duplicate(true)
            rpc_id(target_peer, "receive_blood_bond_data", target_name, bonds)



@rpc("any_peer")
func request_send_blood_offer(source_name: String, target_name: String) -> void :

    if multiplayer.get_unique_id() != 1:
        return

    var sender_id: = multiplayer.get_remote_sender_id()
    var sender_name: = String(GameManager.peer_to_character_name.get(sender_id, ""))
    if sender_name != source_name:
        print("⛔ Denied blood offer: sender isn't the source. Sender:", sender_name, " Source:", source_name)
        return

    var source_cd: = GameManager.character_data_by_name.get(source_name, null) as CharacterData
    var target_cd: = GameManager.character_data_by_name.get(target_name, null) as CharacterData
    if source_cd == null or target_cd == null:
        print("❌ Blood offer: missing CharacterData (source or target).")
        return


    if int(source_cd.blood_pool) <= 0:
        print("❌ Blood offer: source has no blood.")
        return

    var target_peer: int = int(GameManager.name_to_peer.get(target_name, 0))
    if target_peer == 0:
        print("❌ Blood offer: target has no peer.")
        return


    rpc_id(target_peer, "receive_blood_offer", source_name)


@rpc("authority")
func receive_blood_offer(from_name: String) -> void :

    var local_cd: CharacterData = GameManager.character_data
    if local_cd == null:
        print("❌ receive_blood_offer: no local character data.")
        return

    var ui: = GameManager.character_uis.get(local_cd.name, null) as Control
    if ui == null:
        print("❌ receive_blood_offer: MainUI not found for", local_cd.name)
        return

    var invite_panel: Node = ui.get_node_or_null("GroupInvitation")
    if invite_panel == null:
        print("❌ receive_blood_offer: GroupInvitation panel not found")
        return

    invite_panel.call("show_blood_offer", from_name)


@rpc("any_peer")
func request_accept_blood_offer(source_name: String) -> void :

    if multiplayer.get_unique_id() != 1:
        return

    var acceptor_peer: int = multiplayer.get_remote_sender_id()
    var target_name: String = String(GameManager.peer_to_character_name.get(acceptor_peer, ""))
    if target_name == "":
        print("❌ accept_blood_offer: no target name for peer", acceptor_peer)
        return

    var source_cd: CharacterData = GameManager.character_data_by_name.get(source_name, null) as CharacterData
    var target_cd: CharacterData = GameManager.character_data_by_name.get(target_name, null) as CharacterData
    if source_cd == null or target_cd == null:
        print("❌ accept_blood_offer: missing CharacterData.")
        return


    if int(source_cd.blood_pool) <= 0:
        print("❌ accept_blood_offer: source has no blood.")
        return

    source_cd.blood_pool = int(source_cd.blood_pool) - 1
    target_cd.blood_pool = min(int(target_cd.blood_pool) + 1, int(target_cd.blood_pool_max))


    var mgr: BloodBondManager = get_node_or_null("/root/BloodBondManager") as BloodBondManager
    if mgr == null:
        mgr = BloodBondManager.new()
        add_child(mgr)
    var _bb_result: Dictionary = mgr.force_blood_bond_point(source_name, target_name)


    var source_peer: int = int(GameManager.name_to_peer.get(source_name, 0))
    if source_peer != 0:
        rpc_id(source_peer, "receive_edited_character_data", source_cd.serialize_to_dict())
    if acceptor_peer != 0:
        rpc_id(acceptor_peer, "receive_edited_character_data", target_cd.serialize_to_dict())


    var bonds: Dictionary = (target_cd.blood_bonds as Dictionary).duplicate(true)
    if acceptor_peer != 0:
        rpc_id(acceptor_peer, "receive_blood_bond_data", target_name, bonds)


    var divider: String = "[color=gray]────────────────────[/color]\n"
    var donor_peer: int = source_peer
    var receiver_peer: int = acceptor_peer

    var donor_msg: Dictionary = {
        "message": divider + "[b]You feed %s[/b] (–1 Blood Point)." % target_name, 
        "speaker": "SYSTEM", 
        "jingle": false
    }
    var receiver_msg: Dictionary = {
        "message": divider + "[b]%s feeds you[/b] (+1 Blood Point)." % source_name, 
        "speaker": "SYSTEM", 
        "jingle": false
    }

    if donor_peer != 0:
        rpc_id(donor_peer, "receive_message", donor_msg)
    if receiver_peer != 0:
        rpc_id(receiver_peer, "receive_message", receiver_msg)


    var msg_mgr: Node = get_node_or_null("/root/MessageManager")
    if msg_mgr and msg_mgr.has_method("notify_feed_event"):
        msg_mgr.call("notify_feed_event", source_name, target_name)

    print("🩸 Blood transfer: %s -> %s | donor now %d BP, receiver now %d BP."
        %[source_name, target_name, source_cd.blood_pool, target_cd.blood_pool])





@rpc("any_peer")
func request_add_item_to_inventory(packet: Dictionary) -> void :
    print("📩 [SERVER] request_add_item_to_inventory called")
    print("🧾 Received packet:", packet)

    if not multiplayer.is_server():
        return

    var item_name: String = str(packet.get("item_name", ""))
    var item_type: String = str(packet.get("item_type", "generic"))
    var char_name: String = str(packet.get("character_name", ""))
    var base_name: String = str(packet.get("base_name", item_name))

    if item_name == "" or char_name == "":
        print("❌ Invalid item packet:", packet)
        return

    var character_data: CharacterData = GameManager.character_data_by_name.get(char_name, null)
    if character_data == null:
        print("❌ Character not found:", char_name)
        return

    var stored_entry: = "%s:%s" % [item_name, base_name]
    print("🧩 Combined entry string:", stored_entry)

    match item_type:
        "armor":
            character_data.inventory_armor.append(stored_entry)
            print("🛡️ Added to inventory_armor. Total now:", character_data.inventory_armor.size())
        "melee", "ranged":
            character_data.inventory_weapons.append(stored_entry)
            print("🗡️ Added to inventory_weapons. Total now:", character_data.inventory_weapons.size())
        _:
            character_data.inventory_general.append(stored_entry)
            print("🎒 Added to inventory_general. Total now:", character_data.inventory_general.size())

    print("✅ [SERVER] Added '%s' to %s inventory (%s)" % [stored_entry, char_name, item_type])

    var sender_id: int = multiplayer.get_remote_sender_id()
    print("📨 Sender peer ID:", sender_id)


    print("📥 [CLIENT-SIDE SIM] Confirmation (peer %s): Added '%s' to %s’s %s inventory" % [
        str(sender_id), stored_entry, char_name, item_type
    ])
