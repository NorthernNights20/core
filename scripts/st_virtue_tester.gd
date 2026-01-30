extends Control


@onready var header_label = $Panel / VBoxContainer / Label
@onready var difficulty_label = $Panel / VBoxContainer / DifficultyContainer / Panel / Label
@onready var increase_button = $Panel / VBoxContainer / DifficultyContainer / VBoxContainer / Increase
@onready var decrease_button = $Panel / VBoxContainer / DifficultyContainer / VBoxContainer / Decrease
@onready var option_button = $Panel / VBoxContainer / HBoxContainer / VBoxContainer2 / HBoxContainer / OptionButton
@onready var cancel_button = $Panel / VBoxContainer / HBoxContainer2 / Cancel
@onready var confirm_button = $Panel / VBoxContainer / HBoxContainer2 / Public


var current_mode = ""
var character_data
var difficulty: = 8

func _ready():
    cancel_button.pressed.connect(_on_cancel_pressed)
    confirm_button.pressed.connect(_on_confirm_pressed)
    increase_button.pressed.connect(_on_increase_pressed)
    decrease_button.pressed.connect(_on_decrease_pressed)


    if not NetworkManager.is_connected("zone_character_list_received", Callable(self, "_on_receive_zone_character_list")):
        NetworkManager.connect("zone_character_list_received", Callable(self, "_on_receive_zone_character_list"))


func enter_mode(mode: String, data: Resource) -> void :
    current_mode = mode
    character_data = data
    self.visible = true

    match mode:
        "path":
            header_label.text = "Test Path"
        "frenzy":
            header_label.text = "Test Frenzy"
        "rotschreck":
            header_label.text = "Test Rötschreck"

    difficulty = 8
    _update_difficulty_display()


    NetworkManager.rpc("request_zone_character_list", character_data.name)


func _on_receive_zone_character_list(names: Array) -> void :
    option_button.clear()
    for char_name in names:
        option_button.add_item(char_name)
    if names.size() > 0:
        option_button.selected = 0


func _on_increase_pressed() -> void :
    if difficulty < 10:
        difficulty += 1
        _update_difficulty_display()

func _on_decrease_pressed() -> void :
    if difficulty > 2:
        difficulty -= 1
        _update_difficulty_display()

func _update_difficulty_display() -> void :
    difficulty_label.text = str(difficulty)


func _on_cancel_pressed() -> void :
    self.visible = false

func _on_confirm_pressed() -> void :
    if option_button.item_count == 0:
        print("⚠ No target selected.")
        return

    var target_name = option_button.get_item_text(option_button.selected)

    print("🎯 ST requests a", current_mode, "roll for", target_name, "at difficulty", difficulty)


    NetworkManager.rpc("request_virtue_roll", character_data.name, target_name, difficulty, current_mode)

    self.visible = false
