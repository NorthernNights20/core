extends Control

@onready var strength_label: Label = $Panel / VBoxContainer / StrengthHBoxContainer / CurrentStrength
@onready var dexterity_label: Label = $Panel / VBoxContainer / DexterityHBoxContainer2 / CurrentDexterity
@onready var stamina_label: Label = $Panel / VBoxContainer / StaminaHBoxContainer3 / CurrentStamina

@onready var strength_btn: Button = $Panel / VBoxContainer / StrengthHBoxContainer / Button
@onready var dexterity_btn: Button = $Panel / VBoxContainer / DexterityHBoxContainer2 / Button
@onready var stamina_btn: Button = $Panel / VBoxContainer / StaminaHBoxContainer3 / Button

@onready var cancel_button: Button = $Panel / VBoxContainer / Cancel

var _character_name = ""

func _ready() -> void :

    if not NetworkManager.is_connected("physical_attributes_data_received", Callable(self, "_on_data")):
        NetworkManager.connect("physical_attributes_data_received", Callable(self, "_on_data"))


    if strength_btn:
        strength_btn.pressed.connect(_on_strength_pressed)
    if dexterity_btn:
        dexterity_btn.pressed.connect(_on_dexterity_pressed)
    if stamina_btn:
        stamina_btn.pressed.connect(_on_stamina_pressed)


    if cancel_button:
        cancel_button.pressed.connect(_on_cancel_pressed)

func enter(character_data) -> void :

    _character_name = str(character_data.name)
    visible = true
    NetworkManager.rpc("request_physical_attributes_data", _character_name)

func _on_strength_pressed() -> void :
    if _character_name != "":
        NetworkManager.rpc("request_increase_physical_attribute", _character_name, "strength")
    hide()

func _on_dexterity_pressed() -> void :
    if _character_name != "":
        NetworkManager.rpc("request_increase_physical_attribute", _character_name, "dexterity")
    hide()

func _on_stamina_pressed() -> void :
    if _character_name != "":
        NetworkManager.rpc("request_increase_physical_attribute", _character_name, "stamina")
    hide()

func _on_cancel_pressed() -> void :
    hide()

func _on_data(data: Dictionary) -> void :

    strength_label.text = str(int(data.get("strength", 0)))
    dexterity_label.text = str(int(data.get("dexterity", 0)))
    stamina_label.text = str(int(data.get("stamina", 0)))
