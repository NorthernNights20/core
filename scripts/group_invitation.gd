extends Control

@onready var label: Label = $Panel / VBoxContainer / Label
@onready var accept_button: Button = $Panel / VBoxContainer / HBoxContainer / Accept
@onready var refuse_button: Button = $Panel / VBoxContainer / HBoxContainer / Refuse

var inviter_name: String = ""
var mode: String = "group"

func _ready() -> void :
    accept_button.pressed.connect(_on_accept_pressed)
    refuse_button.pressed.connect(_on_refuse_pressed)
    self.visible = false

func show_invitation(from_name: String) -> void :
    inviter_name = from_name
    mode = "group"
    label.text = "%s invited you to their group." % from_name
    self.visible = true

func show_blood_offer(from_name: String) -> void :
    inviter_name = from_name
    mode = "blood_offer"
    label.text = "%s offers you 1 Blood Point. Accept?" % from_name
    self.visible = true

func _on_accept_pressed() -> void :
    match mode:
        "blood_offer":
            print("✅ Accepted blood offer from:", inviter_name)

            NetworkManager.rpc("request_accept_blood_offer", inviter_name)
        _:
            print("✅ Accepted invitation from:", inviter_name)

            NetworkManager.rpc("request_accept_group_invite")
    self.visible = false

func _on_refuse_pressed() -> void :
    print("❌ Refused (%s) from:" % mode, inviter_name)
    self.visible = false
