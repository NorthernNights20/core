extends Control

@onready var name_field: LineEdit = $Panel / VBoxContainer / Name_Field
@onready var password_field: LineEdit = $Panel / VBoxContainer / Password_Field
@onready var cancel_button = $Panel / VBoxContainer / HBoxContainer / Cancel
@onready var confirm_button = $Panel / VBoxContainer / HBoxContainer / Confirm

signal login_cancelled()

func _ready():
    
    if "--server" in OS.get_cmdline_args():
        print("Server mode detected (--server)")

        var server = preload("res://scripts/server.gd").new()
        server.name = "Server"

        get_tree().root.add_child.call_deferred(server)
        return

    cancel_button.pressed.connect(_on_cancel_pressed)
    confirm_button.pressed.connect(_on_confirm_pressed)
    self.visible = false


    name_field.focus_mode = Control.FOCUS_ALL
    password_field.focus_mode = Control.FOCUS_ALL


    name_field.gui_input.connect(_on_field_gui_input.bind("name"))
    password_field.gui_input.connect(_on_field_gui_input.bind("password"))

func _on_field_gui_input(event: InputEvent, which: String) -> void :
    if event is InputEventKey and event.pressed and not event.echo:
        if event.is_action_pressed("ui_focus_next") or event.is_action_pressed("ui_focus_prev"):
            if which == "name":
                password_field.grab_focus()
            else:
                name_field.grab_focus()
            accept_event()

func open() -> void :
    clear_fields()
    self.visible = true
    name_field.grab_focus()

func _on_cancel_pressed() -> void :
    self.visible = false
    emit_signal("login_cancelled")

func _on_confirm_pressed() -> void :
    var character_name: String = name_field.text.strip_edges()
    var password: String = password_field.text.strip_edges()
    if character_name.is_empty() or password.is_empty():
        print("❌ Name or password is empty.")
        return

    print("🔐 Login attempt for:", character_name)
    self.visible = false
    NetworkManager.rpc("request_load_character", character_name, password)

func clear_fields():
    name_field.text = ""
    password_field.text = ""
