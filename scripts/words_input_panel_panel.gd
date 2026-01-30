extends Panel

var dragging: = false
var drag_offset: = Vector2.ZERO


var saved_position: Vector2 = Vector2.ZERO
var position_saved: bool = false

func _gui_input(event: InputEvent) -> void :
    if event is InputEventMouseButton:
        if event.button_index == MOUSE_BUTTON_LEFT:
            if event.pressed:
                dragging = true
                drag_offset = get_global_mouse_position() - get_parent().global_position
            else:
                dragging = false

    elif event is InputEventMouseMotion and dragging:
        get_parent().global_position = get_global_mouse_position() - drag_offset


func apply_saved_position():
    if position_saved:
        get_parent().global_position = saved_position
    else:
        var viewport_size = get_viewport_rect().size
        get_parent().global_position = (viewport_size - get_parent().size) / 2


func remember_position():
    saved_position = get_parent().global_position
    position_saved = true
