extends Control

@onready var close_button = $Panel / HBoxContainer / Close
@onready var acquire_button = $Panel / HBoxContainer / Acquire

func _ready() -> void :
    if close_button:
        close_button.pressed.connect(_on_close_pressed)
    else:
        print("❌ Close button not found in InventoryMenu")

    if acquire_button:
        acquire_button.pressed.connect(_on_acquire_pressed)
    else:
        print("❌ Acquire button not found in InventoryMenu")


func _on_close_pressed() -> void :
    self.visible = false


func _on_acquire_pressed() -> void :
    self.visible = false
    var main_ui = get_parent()
    if not main_ui:
        print("❌ MainUI not found as parent.")
        return

    var acquire_ui = main_ui.get_node_or_null("InventoryAcquireUI")
    if acquire_ui:
        acquire_ui.visible = true
    else:
        print("❌ InventoryAcquireUI not found.")
