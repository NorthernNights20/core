extends Control

@onready var item_container: VBoxContainer = $Panel / VBoxContainer / HBoxContainer / VBoxContainer / ScrollContainer / VBoxContainer
@onready var armor_container: VBoxContainer = $Panel / VBoxContainer / HBoxContainer / VBoxContainer2 / ScrollContainer / VBoxContainer
@onready var melee_container: VBoxContainer = $Panel / VBoxContainer / HBoxContainer / VBoxContainer3 / ScrollContainer / VBoxContainer
@onready var ranged_container: VBoxContainer = $Panel / VBoxContainer / HBoxContainer / VBoxContainer4 / ScrollContainer / VBoxContainer
@onready var text_edit: LineEdit = $Panel / VBoxContainer / HBoxContainer2 / Panel / TextEdit

@onready var close_button: Button = $Panel / VBoxContainer / Close
@onready var acquire_button: Button = $Panel / VBoxContainer / HBoxContainer2 / Button

var tooltip_panel: Panel
var tooltip_label: Label
var selected_button: Button = null


func _ready() -> void :

    tooltip_panel = Panel.new()
    tooltip_panel.visible = false
    tooltip_panel.mouse_filter = Control.MOUSE_FILTER_IGNORE
    tooltip_panel.custom_minimum_size = Vector2(160, 60)
    add_child(tooltip_panel)

    var stylebox: = StyleBoxFlat.new()
    stylebox.bg_color = Color(0, 0, 0, 0.85)
    stylebox.corner_radius_top_left = 8
    stylebox.corner_radius_top_right = 8
    stylebox.corner_radius_bottom_left = 8
    stylebox.corner_radius_bottom_right = 8
    tooltip_panel.add_theme_stylebox_override("panel", stylebox)

    tooltip_label = Label.new()
    tooltip_label.text = ""
    tooltip_label.autowrap_mode = TextServer.AUTOWRAP_WORD
    tooltip_label.add_theme_font_size_override("font_size", 18)
    tooltip_label.add_theme_color_override("font_color", Color.WHITE)
    tooltip_label.add_theme_color_override("font_outline_color", Color.BLACK)
    tooltip_label.add_theme_constant_override("outline_size", 2)
    tooltip_label.size_flags_horizontal = Control.SIZE_SHRINK_CENTER
    tooltip_label.size_flags_vertical = Control.SIZE_SHRINK_CENTER
    tooltip_panel.add_child(tooltip_label)
    tooltip_panel.set_anchors_preset(Control.PRESET_TOP_LEFT)

    if close_button:
        close_button.pressed.connect(_on_close_pressed)
    if acquire_button:
        acquire_button.pressed.connect(_on_acquire_pressed)


    text_edit.editable = false

    _populate_items()
    _populate_armor()
    _populate_melee()
    _populate_ranged()


func _process(_delta: float) -> void :
    if tooltip_panel.visible:
        var mouse_pos: Vector2 = get_local_mouse_position() + Vector2(20, 20)
        tooltip_panel.position = mouse_pos
        tooltip_panel.size = tooltip_label.get_combined_minimum_size() + Vector2(20, 16)


func _on_close_pressed() -> void :
    _clear_text_edit()
    self.visible = false
    var main_ui: Node = get_parent()
    if main_ui:
        var inv_menu: Node = main_ui.get_node_or_null("InventoryMenu")
        if inv_menu:
            inv_menu.visible = true


func _on_acquire_pressed() -> void :
    if selected_button == null:
        return
    if not GameManager.character_data:
        return

    var item_name: String = String(text_edit.text).strip_edges()
    if item_name == "":
        return

    var item_type: String = "generic"
    if armor_container.get_children().has(selected_button):
        item_type = "armor"
    elif melee_container.get_children().has(selected_button):
        item_type = "melee"
    elif ranged_container.get_children().has(selected_button):
        item_type = "ranged"

    var base_name: String = selected_button.text
    var char_name: String = GameManager.character_data.name

    var packet: Dictionary = {
        "item_name": item_name, 
        "base_name": base_name, 
        "item_type": item_type, 
        "character_name": char_name
    }

    if has_node("/root/NetworkManager"):
        var network_manager: Node = get_node("/root/NetworkManager")
        if network_manager.has_method("request_add_item_to_inventory"):
            network_manager.rpc("request_add_item_to_inventory", packet)
            print("📦 Sent packet to server:", packet)


    _clear_text_edit()

    self.visible = false
    var main_ui: Node = get_parent()
    if main_ui:
        var inv_menu: Node = main_ui.get_node_or_null("InventoryMenu")
        if inv_menu:
            inv_menu.visible = true




func _populate_items() -> void :
    _clear_container(item_container)
    _add_button(item_container, "Item", "Generic Item")


func _populate_armor() -> void :
    _clear_container(armor_container)
    for key in InventoryManager.ARMOR_DATA.keys():
        var armor_info: Dictionary = InventoryManager.ARMOR_DATA[key]
        var hover_info: String = "Armor Rating: %d\nPenalty: %d" % [armor_info.armor_rating, armor_info.penalty]
        if armor_info.has("visibility"):
            hover_info += "\nVisibility: %s" % armor_info.visibility
        _add_button(armor_container, armor_info.name, hover_info)


func _populate_melee() -> void :
    _clear_container(melee_container)
    for weapon_name in InventoryManager.MELEE_WEAPONS.keys():
        var weapon: Dictionary = InventoryManager.MELEE_WEAPONS[weapon_name]
        var hover_info: String = "Damage: %s\nConceal: %s" % [weapon.damage, weapon.conceal]
        _add_button(melee_container, weapon_name, hover_info)


func _populate_ranged() -> void :
    _clear_container(ranged_container)
    for weapon_name in InventoryManager.RANGED_WEAPONS.keys():
        var weapon: Dictionary = InventoryManager.RANGED_WEAPONS[weapon_name]
        var hover_info: String = "Damage: %d\nRate: %d\nCapacity: %s\nConceal: %s" % [
            weapon.damage, 
            weapon.rate, 
            str(weapon.capacity), 
            weapon.conceal
        ]
        _add_button(ranged_container, weapon_name, hover_info)




func _clear_container(container: Node) -> void :
    for child in container.get_children():
        child.queue_free()


func _add_button(container: Node, item_name: String, hover_info: String) -> void :
    var button: Button = Button.new()
    button.text = item_name
    button.add_theme_color_override("font_color", Color.BLACK)
    button.flat = true
    button.focus_mode = Control.FOCUS_NONE
    button.mouse_entered.connect( func(): _show_tooltip(hover_info))
    button.mouse_exited.connect(_hide_tooltip)
    button.pressed.connect( func(): _on_item_selected(button, item_name))
    container.add_child(button)


func _on_item_selected(button: Button, item_name: String) -> void :
    if selected_button and selected_button != button:
        selected_button.remove_theme_color_override("font_color")
        selected_button.add_theme_color_override("font_color", Color.BLACK)
        selected_button.remove_theme_color_override("bg_color")

    selected_button = button
    button.add_theme_color_override("font_color", Color.WHITE)
    button.add_theme_color_override("bg_color", Color(0.4, 0, 0, 0.8))
    text_edit.text = item_name
    text_edit.editable = true


func _clear_text_edit() -> void :
    text_edit.text = ""
    text_edit.editable = false


func _show_tooltip(info_text: String) -> void :
    tooltip_label.text = info_text
    tooltip_label.add_theme_color_override("font_color", Color.WHITE)
    tooltip_panel.visible = true
    move_child(tooltip_panel, get_child_count() - 1)


func _hide_tooltip() -> void :
    tooltip_panel.visible = false
