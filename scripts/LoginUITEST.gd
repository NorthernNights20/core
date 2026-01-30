extends Control

@onready var name_field = $Panel / VBoxContainer / Name_Field
@onready var password_field = $Panel / VBoxContainer / Password_Field
@onready var cancel_button = $Panel / VBoxContainer / HBoxContainer / Cancel
@onready var confirm_button = $Panel / VBoxContainer / HBoxContainer / Confirm

signal login_cancelled()

var login_mode: String = "player"

func _ready():
    cancel_button.pressed.connect(_on_cancel_pressed)
    confirm_button.pressed.connect(_on_confirm_pressed)
    self.visible = false

func open(mode: String = "player") -> void :
    login_mode = mode
    clear_fields()
    self.visible = true

func _on_cancel_pressed() -> void :
    self.visible = false
    emit_signal("login_cancelled")

func _on_confirm_pressed() -> void :
    var character_name: String = name_field.text.strip_edges()
    var password: String = password_field.text.strip_edges()

    if character_name.is_empty() or password.is_empty():
        print("❌ Name or password is empty.")
        return

    match login_mode:
        "storyteller":
            if character_name == "Storyteller" and password == "HahaPoopoo":
                print("🧙 Storyteller access granted.")
                self.visible = false
                get_parent()._start_storyteller_mode()
            else:
                print("🚫 Invalid Storyteller credentials.")
                self.visible = false

        "player":
            print("🔐 Player login attempt for:", character_name)
            self.visible = false
            NetworkManager.rpc("request_load_character", character_name, password)

func clear_fields():
    name_field.text = ""
    password_field.text = ""
