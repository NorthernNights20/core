extends Control

@onready var label_target: Label = $Panel / VBoxContainer / Label
@onready var bl_line: LineEdit = $Panel / VBoxContainer / Bash_LethalHBoxContainer / LineEdit
@onready var bl_btn: Button = $Panel / VBoxContainer / Bash_LethalHBoxContainer / Button
@onready var agg_line: LineEdit = $Panel / VBoxContainer / AggravatedHBoxContainer2 / LineEdit
@onready var agg_btn: Button = $Panel / VBoxContainer / AggravatedHBoxContainer2 / Button
@onready var heal_agg_line: LineEdit = $Panel / VBoxContainer / HealAggravatedHBoxContainer3 / LineEdit
@onready var heal_agg_btn: Button = $Panel / VBoxContainer / HealAggravatedHBoxContainer3 / Button
@onready var cancel_btn: Button = $Panel / VBoxContainer / Cancel

var character_data
var target_name: String = ""

func _ready():
    bl_btn.pressed.connect(_on_bl_pressed)
    agg_btn.pressed.connect(_on_agg_pressed)
    heal_agg_btn.pressed.connect(_on_heal_agg_pressed)
    cancel_btn.pressed.connect(_on_cancel_pressed)

func set_character_data(data):
    character_data = data

func set_target(target_player_name: String) -> void :
    target_name = target_player_name
    label_target.text = "Damage : " + target_player_name

func _on_bl_pressed() -> void :
    if target_name == "":
        return
    var amt: = int(bl_line.text.strip_edges())
    if amt <= 0:
        return
    get_node("/root/NetworkManager").rpc("request_st_damage_bash_lethal", target_name, amt)

func _on_agg_pressed() -> void :
    if target_name == "":
        return
    var amt: = int(agg_line.text.strip_edges())
    if amt <= 0:
        return
    get_node("/root/NetworkManager").rpc("request_st_damage_aggravated", target_name, amt)

func _on_heal_agg_pressed() -> void :
    if target_name == "":
        return
    var amt: = int(heal_agg_line.text.strip_edges())
    if amt <= 0:
        return
    get_node("/root/NetworkManager").rpc("request_st_heal_aggravated", target_name, amt)

func _on_cancel_pressed() -> void :
    bl_line.text = ""
    agg_line.text = ""
    heal_agg_line.text = ""
    hide()
