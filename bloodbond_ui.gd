extends Control

@onready var panel: Panel = $Panel
@onready var scroll: ScrollContainer = $Panel / MarginContainer / ScrollContainer
@onready var vbox: VBoxContainer = $Panel / MarginContainer / ScrollContainer / VBoxContainer
@onready var close_button: Button = $Panel / CloseButton

func _ready() -> void :
    visible = false
    close_button.pressed.connect( func(): visible = false)

func display_blood_bond_data(bonds: Dictionary) -> void :
    visible = true
    clear_info()

    if bonds.is_empty():
        var label: = Label.new()
        label.text = "You have no blood bonds."
        label.size_flags_horizontal = Control.SIZE_EXPAND_FILL
        label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
        label.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
        vbox.add_child(label)
        return

    var partner_names: Array = bonds.keys()
    partner_names.sort()

    for partner_name in partner_names:
        var value: int = int(bonds[partner_name])

        var row: = HBoxContainer.new()
        row.size_flags_horizontal = Control.SIZE_EXPAND_FILL

        var name_label: = Label.new()
        name_label.text = str(partner_name)
        name_label.size_flags_horizontal = Control.SIZE_EXPAND_FILL

        var value_label: = Label.new()
        value_label.text = str(value)
        value_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_RIGHT
        value_label.custom_minimum_size = Vector2(48, 0)

        row.add_child(name_label)
        row.add_child(value_label)
        vbox.add_child(row)

func clear_info() -> void :
    for child in vbox.get_children():
        child.queue_free()
