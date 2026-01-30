extends Control

@onready var cancel_button = $Panel / VBoxContainer / HBoxContainer / Cancel
@onready var invite_button = $Panel / VBoxContainer / HBoxContainer / Invite
@onready var view_button = $Panel / VBoxContainer / HBoxContainer / View
@onready var leave_button = $Panel / VBoxContainer / HBoxContainer / Leave

func _ready():
    cancel_button.pressed.connect(_on_cancel_pressed)
    invite_button.pressed.connect(_on_invite_pressed)
    view_button.pressed.connect(_on_view_pressed)
    leave_button.pressed.connect(_on_leave_pressed)

func _on_cancel_pressed() -> void :
    self.visible = false

func _on_invite_pressed() -> void :
    var player_selection = get_parent().get_node_or_null("PlayerSelection")
    if player_selection and GameManager.character_data:
        self.visible = false
        player_selection.enter_state("GroupInvite", GameManager.character_data)
    else:
        print("❌ Could not open PlayerSelection. Check GameManager.character_data and node path.")

func _on_view_pressed() -> void :
    if not GameManager.character_data:
        print("❌ No active character data.")
        return

    var character_name: String = GameManager.character_data.name
    NetworkManager.rpc("request_group_members_for", character_name)




func _on_leave_pressed() -> void :
    print("🚪 Leave group button pressed")
    if GameManager.character_data:
        NetworkManager.rpc("request_leave_group")
    else:
        print("❌ No active character found in GameManager.")
    self.visible = false
