extends Control
class_name PostOrderST

signal order_selected(names: Array[String])
signal order_canceled()

const DEBUG: = true

@onready var root_vbox: VBoxContainer = $Panel / VBoxContainer
@onready var cancel_btn: Button = $Panel / VBoxContainer / HBoxContainer / Cancel
@onready var select_btn: Button = $Panel / VBoxContainer / HBoxContainer / Select

var list_scroll: ScrollContainer
var list_vbox: VBoxContainer

func _ready() -> void :
    if DEBUG: print("[PostOrderST] _ready")

    if GameManager.character_data == null or not GameManager.character_data.is_storyteller:
        if DEBUG: print("[PostOrderST] Not a storyteller. Hiding panel.")
        hide()
        return

    _build_list_area()

    cancel_btn.pressed.connect(_on_cancel_pressed)
    select_btn.pressed.connect(_on_select_pressed)


    if not NetworkManager.is_connected("zone_character_list_received", Callable(self, "_on_zone_character_list_received")):
        if DEBUG: print("[PostOrderST] Connecting to NetworkManager.zone_character_list_received")
        NetworkManager.connect("zone_character_list_received", Callable(self, "_on_zone_character_list_received"))


    var zone_name: = _get_current_zone()
    if zone_name != "":
        if DEBUG: print("[PostOrderST] Requesting current post order for zone:", zone_name)
        NetworkManager.rpc_id(1, "request_get_post_order", zone_name)




func _is_storyteller() -> bool:
    return GameManager.character_data != null and GameManager.character_data.is_storyteller

func _ensure_initialized() -> void :

    if list_scroll == null or list_vbox == null or not is_instance_valid(list_vbox):
        _build_list_area()




func _build_list_area() -> void :
    if DEBUG: print("[PostOrderST] _build_list_area begin")
    list_scroll = ScrollContainer.new()
    list_scroll.size_flags_vertical = Control.SIZE_EXPAND_FILL
    list_scroll.size_flags_horizontal = Control.SIZE_EXPAND_FILL
    list_scroll.follow_focus = true

    list_vbox = VBoxContainer.new()
    list_vbox.size_flags_horizontal = Control.SIZE_EXPAND_FILL
    list_vbox.size_flags_vertical = Control.SIZE_EXPAND_FILL
    list_vbox.add_theme_constant_override("separation", 6)
    list_scroll.add_child(list_vbox)


    root_vbox.add_child(list_scroll)
    root_vbox.move_child(list_scroll, 1)
    if DEBUG: print("[PostOrderST] _build_list_area end. Inserted list at index 1")

func _clear_list() -> void :
    _ensure_initialized()
    if DEBUG: print("[PostOrderST] _clear_list. Children before:", list_vbox.get_child_count())
    for c in list_vbox.get_children():
        c.queue_free()
    await get_tree().process_frame
    if DEBUG: print("[PostOrderST] _clear_list done. Children after:", list_vbox.get_child_count())


func _on_zone_character_list_received(names: Array) -> void :
    if DEBUG: print("[PostOrderST] _on_zone_character_list_received:", names)


    if _is_storyteller():
        var st_name: = GameManager.character_data.name
        if not names.has(st_name):
            names.push_front(st_name)


    _rebuild_rows_from_names(_to_string_array(names))





func apply_server_post_order(zone_name: String, order: Array[String]) -> void :

    if not _is_storyteller():
        return

    if zone_name != _get_current_zone():
        return
    if DEBUG: print("[PostOrderST] apply_server_post_order for zone:", zone_name, "order:", order)
    _ensure_initialized()
    _rebuild_rows_from_names(order)

func _rebuild_rows_from_names(names: Array[String]) -> void :
    _ensure_initialized()
    _clear_list()
    for n in names:
        if typeof(n) == TYPE_STRING and n != "":
            var row: = _make_name_row(n)
            list_vbox.add_child(row)
    if DEBUG: print("[PostOrderST] Built", list_vbox.get_child_count(), "name rows")

func _to_string_array(a: Array) -> Array[String]:
    var out: Array[String] = []
    for v in a:
        out.append(str(v))
    return out

func _get_current_zone() -> String:
    if GameManager.character_data == null:
        return ""
    return str(GameManager.character_data.current_zone)




class NameRow:
    extends HBoxContainer

    var char_name: String
    var name_label: Label
    var btn_down: Button
    var btn_up: Button

    func _init(_name: String) -> void :
        char_name = _name

    func _ready() -> void :
        size_flags_horizontal = Control.SIZE_EXPAND_FILL
        add_theme_constant_override("separation", 8)


        name_label = Label.new()
        name_label.text = char_name
        name_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_LEFT
        name_label.size_flags_horizontal = Control.SIZE_EXPAND_FILL
        add_child(name_label)


        btn_down = Button.new()
        btn_down.focus_mode = Control.FOCUS_NONE
        btn_down.custom_minimum_size = Vector2(36, 28)
        btn_down.theme = load("res://Image/UI/ButtonDownComplete.tres")
        add_child(btn_down)


        btn_up = Button.new()
        btn_up.focus_mode = Control.FOCUS_NONE
        btn_up.custom_minimum_size = Vector2(36, 28)
        btn_up.theme = load("res://Image/UI/ButtonUpComplete.tres")
        add_child(btn_up)

        btn_down.pressed.connect(_on_lower_pressed)
        btn_up.pressed.connect(_on_raise_pressed)

    func _on_lower_pressed() -> void :
        var parent_vbox: = get_parent()
        if parent_vbox == null: return
        var idx: = get_index()
        var last: = parent_vbox.get_child_count() - 1
        if idx < last:
            if PostOrderST.DEBUG: print("[NameRow] Lower:", char_name, "from", idx, "to", idx + 1)
            parent_vbox.move_child(self, idx + 1)

    func _on_raise_pressed() -> void :
        var parent_vbox: = get_parent()
        if parent_vbox == null: return
        var idx: = get_index()
        if idx > 0:
            if PostOrderST.DEBUG: print("[NameRow] Raise:", char_name, "from", idx, "to", idx - 1)
            parent_vbox.move_child(self, idx - 1)


func _make_name_row(char_name: String) -> NameRow:
    if DEBUG: print("[PostOrderST] _make_name_row:", char_name)
    var row: = NameRow.new(char_name)
    return row




func _on_cancel_pressed() -> void :
    if DEBUG: print("[PostOrderST] Cancel pressed")
    emit_signal("order_canceled")
    hide()

func _on_select_pressed() -> void :

    _ensure_initialized()


    var names: Array[String] = []
    for c in list_vbox.get_children():
        if c is NameRow:
            names.append(c.char_name)

    if DEBUG: print("[PostOrderST] Select pressed. Final order:", names)
    emit_signal("order_selected", names)


    var zone_name: = _get_current_zone()
    if zone_name != "":
        if DEBUG: print("[PostOrderST] Sending order to server for zone:", zone_name)
        NetworkManager.rpc_id(1, "request_set_post_order", zone_name, names)
