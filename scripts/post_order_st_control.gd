extends Control
class_name PostOrderSTControl

const DEBUG: = true

@onready var btn_next: Button = $"Panel/HBoxContainer/Next"
@onready var btn_back: Button = $"Panel/HBoxContainer/Back"
@onready var btn_quit: Button = $"Panel/HBoxContainer/Quit"

var _current_zone: String = ""
var _order: Array[String] = []

func _ready() -> void :

    _make_click_through_except_buttons(self)


    set_anchors_preset(Control.PRESET_TOP_LEFT)
    size_flags_horizontal = Control.SIZE_SHRINK_BEGIN
    size_flags_vertical = Control.SIZE_SHRINK_BEGIN
    focus_mode = Control.FOCUS_NONE


    if GameManager.character_data == null or not GameManager.character_data.is_storyteller:
        hide()
        return

    hide()


    if not NetworkManager.is_connected("post_order_received", Callable(self, "_on_post_order_received")):
        NetworkManager.connect("post_order_received", Callable(self, "_on_post_order_received"))
    if not NetworkManager.is_connected("post_order_cleared", Callable(self, "_on_post_order_cleared")):
        NetworkManager.connect("post_order_cleared", Callable(self, "_on_post_order_cleared"))


    if GameManager.has_signal("local_zone_changed"):
        if not GameManager.is_connected("local_zone_changed", Callable(self, "_on_local_zone_changed")):
            GameManager.connect("local_zone_changed", Callable(self, "_on_local_zone_changed"))


    btn_next.pressed.connect(_on_next_pressed)
    btn_back.pressed.connect(_on_back_pressed)
    btn_quit.pressed.connect(_on_quit_pressed)


    var guess: = _raw_current_zone()
    if guess != "":
        _current_zone = guess
        NetworkManager.rpc_id(1, "request_get_post_order", guess)





func _on_post_order_received(zone_name: String, order_any: Array) -> void :
    _current_zone = str(zone_name)
    _order = _to_string_array(order_any)
    if _order.is_empty():
        hide()
    else:
        _update_buttons_state()
        show()
    if DEBUG:
        print("[PostOrderSTControl] received for zone=", _current_zone, " → ", _order)

func _on_post_order_cleared(_zone_name: String) -> void :
    _order.clear()
    _update_buttons_state()
    hide()
    _hide_viewer_if_present()
    if DEBUG:
        print("[PostOrderSTControl] cleared")

func _on_local_zone_changed(_new_zone_name: String) -> void :

    var z: = _raw_current_zone()
    if z == "":
        hide()
        return
    _current_zone = z
    NetworkManager.rpc_id(1, "request_get_post_order", z)





func _on_next_pressed() -> void :
    if _order.size() <= 1:
        return
    _order = _rotate_forward(_order)
    _update_buttons_state()
    var z: = _ensure_zone()
    NetworkManager.rpc_id(1, "request_set_post_order", z, _order)

    NetworkManager.emit_signal("post_order_received", z, _order)

func _on_back_pressed() -> void :
    if _order.size() <= 1:
        return
    _order = _rotate_backward(_order)
    _update_buttons_state()
    var z: = _ensure_zone()
    NetworkManager.rpc_id(1, "request_set_post_order", z, _order)

    NetworkManager.emit_signal("post_order_received", z, _order)

func _on_quit_pressed() -> void :
    var z: = _ensure_zone()
    if z == "":
        return
    hide()
    _hide_viewer_if_present()
    NetworkManager.rpc_id(1, "request_clear_post_order", z)

    NetworkManager.emit_signal("post_order_cleared", z)
    NetworkManager.emit_signal("post_order_received", z, [])





func _raw_current_zone() -> String:
    if GameManager.character_data == null:
        return ""
    return str(GameManager.character_data.current_zone)

func _ensure_zone() -> String:
    if _current_zone != "":
        return _current_zone
    return _raw_current_zone()

func _rotate_forward(a: Array[String]) -> Array[String]:
    if a.size() <= 1:
        return a.duplicate()
    var out: = a.duplicate()
    out.push_back(out.pop_front())
    return out

func _rotate_backward(a: Array[String]) -> Array[String]:
    if a.size() <= 1:
        return a.duplicate()
    var out: = a.duplicate()
    out.push_front(out.pop_back())
    return out

func _update_buttons_state() -> void :
    var enabled: = _order.size() > 1
    btn_next.disabled = not enabled
    btn_back.disabled = not enabled

func _to_string_array(a: Array) -> Array[String]:
    var out: Array[String] = []
    for v in a:
        out.append(str(v))
    return out

func _hide_viewer_if_present() -> void :
    var main_ui: = get_tree().root.get_node_or_null("MainUI")
    if main_ui:
        var viewer: = main_ui.get_node_or_null("PostOrderDisplay")
        if viewer and viewer.has_method("hide"):
            viewer.hide()

func _make_click_through_except_buttons(node: Node) -> void :
    if node is Control:
        var c: Control = node
        if c is Button:
            c.focus_mode = Control.FOCUS_ALL
        else:
            c.mouse_filter = Control.MOUSE_FILTER_IGNORE
            c.focus_mode = Control.FOCUS_NONE
    for child in node.get_children():
        _make_click_through_except_buttons(child)
