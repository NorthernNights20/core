extends Node2D

@onready var cup_sprite: = $CupSprite
var custom_font: Font = preload("res://Cinzel-VariableFont_wght.ttf")

var orbit_radius: float = 100.0
var orbit_speed: float = 1.0
var internal_timer: float = 0.0

var name_labels: Array[Label] = []

func _ready() -> void :
    set_process(true)

func update_names(participants: Array[String]) -> void :

    for label in name_labels:
        label.queue_free()
    name_labels.clear()


    for participant_name in participants:
        var label: = Label.new()
        label.text = participant_name
        label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
        label.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
        label.add_theme_font_override("font", custom_font)
        label.add_theme_color_override("font_color", Color.BLACK)
        add_child(label)
        name_labels.append(label)

func _process(delta: float) -> void :
    internal_timer += delta * orbit_speed

    var center: Vector2 = cup_sprite.global_position
    var count: int = name_labels.size()
    if count == 0:
        return

    for i in range(count):
        var angle: float = internal_timer + (i * TAU / count)
        var x: float = center.x + orbit_radius * cos(angle)
        var y: float = center.y + orbit_radius * sin(angle)
        name_labels[i].global_position = Vector2(x, y)

func clear_labels_and_stop() -> void :
    set_process(false)
    internal_timer = 0.0

    for label in name_labels:
        if is_instance_valid(label):
            label.queue_free()

    name_labels.clear()
