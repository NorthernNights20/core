extends Control

var current_mode: String = "roll"

var character_data: Resource


@onready var attribute_dropdown = $Panel / VBoxContainer / HBoxContainer / VBoxContainer / HBoxContainer / OptionButton
@onready var attribute_value_label = $Panel / VBoxContainer / HBoxContainer / VBoxContainer / HBoxContainer / Panel / Label

@onready var ability_dropdown = $Panel / VBoxContainer / HBoxContainer / VBoxContainer2 / HBoxContainer / OptionButton
@onready var ability_value_label = $Panel / VBoxContainer / HBoxContainer / VBoxContainer2 / HBoxContainer / Panel / Label

@onready var cancel_button = $Panel / VBoxContainer / HBoxContainer2 / Cancel
@onready var public_button = $Panel / VBoxContainer / HBoxContainer2 / Public
@onready var private_button = $Panel / VBoxContainer / HBoxContainer2 / Private

@onready var difficulty_label = $Panel / VBoxContainer / DifficultyContainer / Panel / Label
@onready var increase_button = $Panel / VBoxContainer / DifficultyContainer / VBoxContainer / Increase
@onready var decrease_button = $Panel / VBoxContainer / DifficultyContainer / VBoxContainer / Decrease


@onready var header_label: Label = $Panel / Label


@onready var specialization_button: BaseButton = $Panel / SpecializationButton
@onready var willpower_button: BaseButton = $Panel / WillpowerButton



enum RollMode{PUBLIC, PRIVATE}


var character_name: String = ""
var difficulty: int = 6
var current_attribute: String = ""
var current_ability: String = ""
var attribute_value: int = 0
var ability_value: int = 0

func _ready():
    if not NetworkManager.is_connected("stat_value_received", Callable(self, "update_stat_display")):
        NetworkManager.connect("stat_value_received", Callable(self, "update_stat_display"))

    cancel_button.pressed.connect( func(): self.visible = false)
    public_button.pressed.connect(_on_public_pressed)
    private_button.pressed.connect(_on_private_pressed)

    attribute_dropdown.item_selected.connect(_on_attribute_selected)
    ability_dropdown.item_selected.connect(_on_ability_selected)

    increase_button.pressed.connect( func():
        if difficulty < 10:
            difficulty += 1
            difficulty_label.text = str(difficulty)
    )
    decrease_button.pressed.connect( func():
        if difficulty > 2:
            difficulty -= 1
            difficulty_label.text = str(difficulty)
    )


    if is_instance_valid(specialization_button):
        specialization_button.toggle_mode = true

        specialization_button.mouse_filter = Control.MOUSE_FILTER_IGNORE
        specialization_button.modulate.a = 0.35


    if is_instance_valid(willpower_button):
        willpower_button.toggle_mode = true
        willpower_button.mouse_filter = Control.MOUSE_FILTER_STOP
        willpower_button.modulate.a = 1.0


func enter_state(mode: String, data: Resource):
    character_data = data
    current_mode = mode
    character_name = character_data.name
    self.visible = true

    if current_mode == "roll":

        $Panel / VBoxContainer / HBoxContainer / VBoxContainer / Label.text = "Attribute"
        $Panel / VBoxContainer / HBoxContainer / VBoxContainer2 / Label.text = "Ability"

        $Panel / VBoxContainer / HBoxContainer / VBoxContainer / HBoxContainer / Panel.show()
        $Panel / VBoxContainer / HBoxContainer / VBoxContainer2 / HBoxContainer / Panel.show()

        attribute_dropdown.clear()
        attribute_dropdown.add_item("---")
        for attr in ["Strength", "Dexterity", "Stamina", "Charisma", "Manipulation", "Appearance", "Perception", "Intelligence", "Wits"]:
            attribute_dropdown.add_item(attr)
        attribute_dropdown.select(0)

        var all_abilities: = [
            "alertness", "athletics", "awareness", "brawl", "empathy", "expression", "intimidation", "leadership", "streetwise", "subterfuge", 
            "animal_ken", "crafts", "drive", "etiquette", "firearms", "larceny", "melee", "performance", "stealth", "survival", 
            "academics", "computer", "finance", "investigation", "law", "medicine", "occult", "politics", "science", "technology"
        ]
        ability_dropdown.clear()
        ability_dropdown.add_item("---")
        for ability in all_abilities:
            var label = ability.capitalize().replace("_", " ")
            ability_dropdown.add_item(label)
        ability_dropdown.select(0)

        attribute_value_label.text = "-"
        ability_value_label.text = "-"
        current_attribute = ""
        current_ability = ""
        attribute_value = 0
        ability_value = 0

        if is_instance_valid(specialization_button):
            specialization_button.visible = true
            specialization_button.mouse_filter = Control.MOUSE_FILTER_IGNORE
            specialization_button.modulate.a = 0.35

        if is_instance_valid(willpower_button):
            willpower_button.visible = true
            willpower_button.mouse_filter = Control.MOUSE_FILTER_IGNORE
            willpower_button.modulate.a = 0.35
            willpower_button.button_pressed = false
            NetworkManager.rpc("request_has_willpower", character_name)


        if has_node("Panel/Label2"):
            $Panel / Label2.show()

        if is_instance_valid(header_label):
            header_label.show()

    else:

        $Panel / VBoxContainer / HBoxContainer / VBoxContainer / Label.text = "Pool 1"
        $Panel / VBoxContainer / HBoxContainer / VBoxContainer2 / Label.text = "Pool 2"

        $Panel / VBoxContainer / HBoxContainer / VBoxContainer / HBoxContainer / Panel.hide()
        $Panel / VBoxContainer / HBoxContainer / VBoxContainer2 / HBoxContainer / Panel.hide()

        attribute_dropdown.clear()
        for i in range(21):
            attribute_dropdown.add_item(str(i))
        attribute_dropdown.select(0)

        ability_dropdown.clear()
        for i in range(21):
            ability_dropdown.add_item(str(i))
        ability_dropdown.select(0)

        current_attribute = ""
        current_ability = ""
        attribute_value = 0
        ability_value = 0

        if is_instance_valid(specialization_button):
            specialization_button.visible = false

        if is_instance_valid(willpower_button):
            willpower_button.hide()
            willpower_button.button_pressed = false
            willpower_button.mouse_filter = Control.MOUSE_FILTER_IGNORE
            willpower_button.modulate.a = 0.35


        if has_node("Panel/Label2"):
            $Panel / Label2.hide()

        if is_instance_valid(header_label):
            header_label.hide()

    difficulty = 6
    difficulty_label.text = str(difficulty)

    var viewport_size = get_viewport_rect().size
    global_position = (viewport_size - size) / 2


func _on_attribute_selected(index: int):
    if index == 0:
        attribute_value_label.text = "-"
        current_attribute = ""
        return

    current_attribute = attribute_dropdown.get_item_text(index)
    attribute_value_label.text = "..."
    NetworkManager.request_stat_value(character_name, current_attribute)


func _on_ability_selected(index: int):
    if index == 0:
        ability_value_label.text = "-"
        current_ability = ""
        if is_instance_valid(specialization_button):
            specialization_button.mouse_filter = Control.MOUSE_FILTER_IGNORE
            specialization_button.modulate.a = 0.35
            specialization_button.button_pressed = false
        return

    current_ability = ability_dropdown.get_item_text(index)
    ability_value_label.text = "..."
    NetworkManager.request_stat_value(character_name, current_ability)


func update_stat_display(stat_name: String, value: int):
    if stat_name == current_attribute:
        attribute_value = value
        attribute_value_label.text = str(value)
    elif stat_name == current_ability:
        ability_value = value
        ability_value_label.text = str(value)
        if is_instance_valid(specialization_button):
            var enable_spec: = ability_value >= 4
            specialization_button.mouse_filter = Control.MOUSE_FILTER_STOP if enable_spec else Control.MOUSE_FILTER_IGNORE
            specialization_button.modulate.a = 1.0 if enable_spec else 0.35
            if not enable_spec:
                specialization_button.button_pressed = false


func _on_public_pressed():
    _execute_roll(RollMode.PUBLIC)

func _on_private_pressed():
    _execute_roll(RollMode.PRIVATE)

func update_willpower_button(has_willpower: bool) -> void :
    print("🎮 [update_willpower_button] Updating UI — has_willpower:", has_willpower)
    if is_instance_valid(willpower_button):
        willpower_button.mouse_filter = Control.MOUSE_FILTER_STOP if has_willpower else Control.MOUSE_FILTER_IGNORE
        willpower_button.modulate.a = 1.0 if has_willpower else 0.35
        if not has_willpower:
            willpower_button.button_pressed = false




func _execute_roll(mode: RollMode):
    if current_mode == "custom":
        var pool_1 = attribute_dropdown.get_selected()
        var pool_2 = ability_dropdown.get_selected()
        var total_dice = pool_1 + pool_2

        if total_dice == 0:
            print("⚠ Cannot roll 0 dice.")
            return


        NetworkManager.rpc("request_dice_roll", character_name, "Custom", "Custom", difficulty, int(mode), pool_1, pool_2, false, false)
    else:
        if current_attribute == "" or current_ability == "":
            print("⚠ Cannot roll without selecting both an attribute and an ability.")
            return

        var use_specialization: = false
        var use_willpower: = false

        if is_instance_valid(specialization_button):
            use_specialization = specialization_button.button_pressed and ability_value >= 4

        if is_instance_valid(willpower_button):
            use_willpower = willpower_button.button_pressed

        NetworkManager.rpc("request_dice_roll", character_name, current_attribute, current_ability, difficulty, int(mode), 0, 0, use_specialization, use_willpower)

    self.visible = false
