extends Control

@onready var panel: = $Panel
@onready var scroll: = $Panel / MarginContainer / ScrollContainer
@onready var vbox: = $Panel / MarginContainer / ScrollContainer / VBoxContainer
@onready var close_button: = $Panel / CloseButton

func _ready() -> void :
    close_button.pressed.connect( func(): self.visible = false)
    self.visible = false

func display_vinculum_data(vinculum: Dictionary) -> void :
    self.visible = true
    clear_info()

    if vinculum.is_empty():
        var label: = Label.new()
        label.text = "You’ve never participated in a Vaulderie."
        label.size_flags_horizontal = Control.SIZE_EXPAND_FILL
        label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
        label.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
        label.add_theme_color_override("font_color", Color.BLACK)
        vbox.add_child(label)
        return



    var sorted_keys: = vinculum.keys()
    sorted_keys.sort()

    for partner_name in sorted_keys:
        var rating = vinculum[partner_name]
        var label: = Label.new()
        label.text = "%s → %d" % [partner_name, rating]
        label.size_flags_horizontal = Control.SIZE_EXPAND_FILL
        vbox.add_child(label)

func clear_info() -> void :
    for child in vbox.get_children():
        child.queue_free()
