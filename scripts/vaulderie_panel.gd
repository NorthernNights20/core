extends Control


@onready var host_button: = $VaulderiePanel / VBoxContainer / HBoxContainer / Host
@onready var cancel_button: = $VaulderiePanel / VBoxContainer / HBoxContainer / Cancel
@onready var perform_button: = $VaulderiePanel / VBoxContainer / HBoxContainer / Perform


func _ready() -> void :
    print("🧪 VaulderiePanel _ready() triggered.")
    host_button.pressed.connect(_on_Host_pressed)
    cancel_button.pressed.connect(_on_Cancel_pressed)
    perform_button.pressed.connect(_on_Perform_pressed)



func _on_Host_pressed() -> void :
    var char_name = GameManager.character_data.name
    var zone = GameManager.character_data.current_zone

    print("📡 Host button pressed by", char_name, "in zone", zone)

    NetworkManager.rpc_id(1, "request_vaulderie_host", {
        "host": char_name, 
        "zone": zone
    })


func _on_Cancel_pressed() -> void :
    var char_name = GameManager.character_data.name
    var zone = GameManager.character_data.current_zone

    print("❌ Cancel button pressed by", char_name)

    NetworkManager.rpc_id(1, "request_vaulderie_cancel", {
        "character": char_name, 
        "zone": zone
    })

    self.visible = false


func receive_vaulderie_participant_list(participants: Array) -> void :
    print("📥 [VaulderiePanel] received participant list:", participants)
    call_deferred("_update_cup_scene_names", participants)


func _update_cup_scene_names(participants: Array) -> void :
    print("🔍 Attempting to find CupScene...")

    var cup_scene = get_node("VaulderiePanel/VBoxContainer/SubViewportContainer/SubViewport/CupScene")
    if cup_scene:
        print("✅ CupScene found — updating names.")


        var name_list: Array[String] = []
        for p in participants:
            name_list.append(str(p))

        cup_scene.update_names(name_list)
    else:
        push_error("❌ CupScene not found. Check node path or load timing.")




func _on_Perform_pressed() -> void :
    var char_name = GameManager.character_data.name
    var zone = GameManager.character_data.current_zone

    print("🩸 Perform button pressed by", char_name, "in zone", zone)
    NetworkManager.rpc_id(1, "request_perform_vaulderie", zone)
