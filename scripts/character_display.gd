extends Control

@onready var drag_surface: Control = $Panel
@onready var portrait_rect: TextureRect = $Panel / Portrait
@onready var close_button: Button = $Panel / Close

var dragging: bool = false
var drag_offset: Vector2 = Vector2.ZERO


var saved_position: Vector2 = Vector2.ZERO
var position_saved: bool = false


const CLAMP_PADDING: float = 16.0

func _ready() -> void :

    set_as_top_level(true)


    size = drag_surface.size
    drag_surface.resized.connect( func() -> void :
        size = drag_surface.size
    )


    drag_surface.gui_input.connect(_on_drag_surface_gui_input)


    close_button.pressed.connect( func() -> void :
        remember_position()
        hide()
    )


    visibility_changed.connect(_on_visibility_changed)

func _on_visibility_changed() -> void :
    if visible:
        apply_saved_position()
    else:
        remember_position()

func _on_drag_surface_gui_input(event: InputEvent) -> void :
    if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
        if event.pressed:

            var mouse_global: Vector2 = get_global_mouse_position()
            if _is_point_over_close(mouse_global):
                return
            dragging = true
            drag_offset = mouse_global - global_position

            move_to_front()
        else:
            dragging = false

    elif event is InputEventMouseMotion and dragging:
        var target: Vector2 = get_global_mouse_position() - drag_offset
        global_position = _clamp_to_viewport(target)

func display_image(image_bytes: PackedByteArray) -> void :
    var image: = Image.new()
    var err: = image.load_png_from_buffer(image_bytes)
    if err == OK:
        var texture: = ImageTexture.create_from_image(image)
        portrait_rect.texture = texture
        print("🖼️ Character portrait set.")
    else:
        print("❌ Failed to load portrait image from buffer. Error code:", err)

func apply_saved_position() -> void :
    if position_saved:
        global_position = _clamp_to_viewport(saved_position)
    else:

        var vp_size: Vector2 = get_viewport_rect().size
        var centered: Vector2 = (vp_size - size) / 2.0
        global_position = _clamp_to_viewport(centered)

func remember_position() -> void :
    saved_position = global_position
    position_saved = true

func _clamp_to_viewport(p: Vector2) -> Vector2:
    var vp: Vector2 = get_viewport_rect().size
    var min_x: float = CLAMP_PADDING
    var min_y: float = CLAMP_PADDING
    var max_x: float = maxf(CLAMP_PADDING, vp.x - size.x - CLAMP_PADDING)
    var max_y: float = maxf(CLAMP_PADDING, vp.y - size.y - CLAMP_PADDING)
    return Vector2(
        clampf(p.x, min_x, max_x), 
        clampf(p.y, min_y, max_y)
    )

func _is_point_over_close(point_global: Vector2) -> bool:
    var rect: Rect2 = Rect2(close_button.global_position, close_button.size)
    return rect.has_point(point_global)
