extends Control

@onready var cancel_button: = $VaulderiePanelParticipant / VBoxContainer / HBoxContainer / Cancel
@onready var participate_button: = $VaulderiePanelParticipant / VBoxContainer / HBoxContainer / Participate
@onready var withdraw_button: = $VaulderiePanelParticipant / VBoxContainer / HBoxContainer / Withdraw

func _ready() -> void :
    print("🎭 VaulderiePanelParticipant ready.")
    cancel_button.pressed.connect(_on_cancel_pressed)
    participate_button.pressed.connect(_on_participate_pressed)
    withdraw_button.pressed.connect(_on_withdraw_pressed)

func _on_cancel_pressed() -> void :
    print("❌ Participant canceled.")
    hide()

func _on_participate_pressed() -> void :
    var char_name = GameManager.character_data.name
    var zone = GameManager.character_data.current_zone
    print("➕ Participant joining:", char_name, "in zone:", zone)
    NetworkManager.rpc_id(1, "request_join_vaulderie", char_name, zone)

func _on_withdraw_pressed() -> void :
    var char_name = GameManager.character_data.name
    var zone = GameManager.character_data.current_zone
    print("➖ Participant withdrawing:", char_name, "from zone:", zone)
    NetworkManager.rpc_id(1, "request_leave_vaulderie", char_name, zone)

func receive_vaulderie_participant_list(participants: Array) -> void :
    print("📥 [VaulderiePanelParticipant] received participant list:", participants)
    call_deferred("_update_cup_scene_names", participants)

func _update_cup_scene_names(participants: Array) -> void :
    print("🔍 Attempting to find CupScene (participant panel)...")
    var cup_scene = get_node_or_null("VaulderiePanelParticipant/VBoxContainer/SubViewportContainer/SubViewport/CupScene")
    if cup_scene:
        print("✅ CupScene found — calling update_names()")
        var name_list: Array[String] = []
        for p in participants:
            name_list.append(str(p))
        cup_scene.update_names(name_list)
    else:
        push_error("❌ CupScene not found in participant panel.")
