
extends Control
class_name PostOrderDisplay

const DEBUG: = true

@onready var current_label: Label = $"Panel/HBoxContainer/CurrentName"
@onready var next_label: Label = $"Panel/HBoxContainer/NextName"

func _ready() -> void :

    mouse_filter = Control.MOUSE_FILTER_IGNORE
    focus_mode = Control.FOCUS_NONE
    if has_node("Panel"):
        $Panel.mouse_filter = Control.MOUSE_FILTER_IGNORE
    if has_node("Panel/HBoxContainer"):
        $"Panel/HBoxContainer".mouse_filter = Control.MOUSE_FILTER_IGNORE

    _hide_and_clear()


    if not NetworkManager.is_connected("post_order_received", Callable(self, "_on_post_order_received")):
        NetworkManager.connect("post_order_received", Callable(self, "_on_post_order_received"))
    if not NetworkManager.is_connected("post_order_cleared", Callable(self, "_on_post_order_cleared")):
        NetworkManager.connect("post_order_cleared", Callable(self, "_on_post_order_cleared"))


    if GameManager.has_signal("local_zone_changed"):
        if not GameManager.is_connected("local_zone_changed", Callable(self, "on_local_zone_changed")):
            GameManager.connect("local_zone_changed", Callable(self, "on_local_zone_changed"))


    _request_current_zone_order()





func apply_server_post_order(zone_name: String, order: Array) -> void :
    var my_zone: = _get_current_zone()
    var recv_zone: = _canonical_zone(zone_name)
    if recv_zone != my_zone:
        if DEBUG:
            print("[PostOrderDisplay] update ignored; zone mismatch. got=", recv_zone, " me=", my_zone)
        return
    _update_labels_from_order(_to_string_array(order))

func set_order_for_current_zone(order: Array[String]) -> void :
    _update_labels_from_order(order)

func on_local_zone_changed(_new_zone_name: String) -> void :
    _request_current_zone_order()





func _on_post_order_received(zone_name: String, order: Array) -> void :
    apply_server_post_order(zone_name, order)

func _on_post_order_cleared(zone_name: String) -> void :
    var my_zone: = _get_current_zone()
    var recv_zone: = _canonical_zone(zone_name)
    if recv_zone != my_zone:
        if DEBUG:
            print("[PostOrderDisplay] clear ignored; zone mismatch. got=", recv_zone, " me=", my_zone)
        return
    _hide_and_clear()





func _request_current_zone_order() -> void :
    var zone: = _get_current_zone()
    if zone == "":
        _hide_and_clear()
        return
    if DEBUG:
        print("[PostOrderDisplay] Requesting post order for zone (canonical):", zone)
    NetworkManager.rpc_id(1, "request_get_post_order", zone)

func _get_current_zone() -> String:
    if GameManager.character_data == null:
        return ""
    return _canonical_zone(str(GameManager.character_data.current_zone))

func _canonical_zone(z: String) -> String:
    var s: = str(z).strip_edges().to_lower()

    if ZoneManager.zones.has(s):
        return s

    for key in ZoneManager.zones.keys():
        var zone = ZoneManager.zones[key]
        var disp: = ""
        if typeof(zone) == TYPE_DICTIONARY:
            disp = str(zone.get("display_name", zone.get("name", ""))).strip_edges().to_lower()
            if zone.has("aliases"):
                for a in (zone["aliases"] as Array):
                    if str(a).strip_edges().to_lower() == s:
                        return str(key)
        else:
            if "display_name" in zone:
                disp = str(zone.display_name).strip_edges().to_lower()
            elif zone.has_method("get_name"):
                disp = str(zone.get_name()).strip_edges().to_lower()
        if disp == s:
            return str(key)
    return s

func _update_labels_from_order(order: Array[String]) -> void :
    var clean: Array[String] = []
    for n in order:
        if typeof(n) == TYPE_STRING:
            var s: = str(n).strip_edges()
            if s != "":
                clean.append(s)

    if clean.size() == 0:
        _hide_and_clear()
        return

    show()
    current_label.text = clean[0]
    next_label.text = clean[1] if clean.size() > 1 else ""
    if DEBUG:
        print("[PostOrderDisplay] Displaying order:", clean)

func _hide_and_clear() -> void :
    hide()
    if is_instance_valid(current_label):
        current_label.text = ""
    if is_instance_valid(next_label):
        next_label.text = ""

func _to_string_array(a: Array) -> Array[String]:
    var out: Array[String] = []
    for v in a:
        out.append(str(v))
    return out
