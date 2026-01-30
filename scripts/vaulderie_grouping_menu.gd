
extends Control

@onready var host_btn: Button = $"Panel/VBoxContainer/HBoxContainer/Host Vaulderie"
@onready var participate_btn: Button = $"Panel/VBoxContainer/HBoxContainer/Participate Vaulderie"
@onready var view_btn: Button = $"Panel/VBoxContainer/HBoxContainer/View Vinculum"
@onready var cancel_btn: Button = $"Panel/VBoxContainer/Cancel"

func _ready() -> void :
    host_btn.pressed.connect(_on_host_pressed)
    participate_btn.pressed.connect(_on_participate_pressed)
    view_btn.pressed.connect(_on_view_pressed)
    cancel_btn.pressed.connect(_on_cancel_pressed)


    visibility_changed.connect(_on_visibility_changed)

    _refresh_buttons()

func _on_visibility_changed() -> void :
    if visible:
        _refresh_buttons()

func _refresh_buttons() -> void :
    var cd = GameManager.character_data
    var has_char: = cd != null

    host_btn.disabled = not has_char or (has_char and cd.rituals < 1)
    participate_btn.disabled = not has_char
    view_btn.disabled = not has_char


    var host_tip: = ""
    if host_btn.disabled:
        if not has_char:
            host_tip = "No character loaded."
        else:
            host_tip = "You do not know the Ritual of Vaulderie."
    host_btn.tooltip_text = host_tip

    participate_btn.tooltip_text = "No character loaded." if participate_btn.disabled else ""
    view_btn.tooltip_text = "No character loaded." if view_btn.disabled else ""

func _on_host_pressed() -> void :
    var cd = GameManager.character_data
    if cd == null or cd.rituals < 1:
        hide()
        return
    var vaulderie_panel = get_parent().get_node_or_null("VaulderiePanel")
    if vaulderie_panel:
        vaulderie_panel.visible = true
    hide()

func _on_participate_pressed() -> void :
    var cd = GameManager.character_data
    if cd == null:
        hide()
        return
    NetworkManager.rpc("request_open_vaulderie_participant", cd.name, cd.current_zone)
    hide()

func _on_view_pressed() -> void :
    var vinculum_menu = get_parent().get_node_or_null("VinculumMenu")
    if vinculum_menu:
        vinculum_menu.visible = true
        var cd = GameManager.character_data
        if cd:
            NetworkManager.rpc("request_vinculum_data", cd.name)
    hide()

func _on_cancel_pressed() -> void :
    hide()
