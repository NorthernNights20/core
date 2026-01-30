extends Control

signal subject_selected(student_name: String, subject: String)

@onready var _path_button: Button = $Panel / VBoxContainer / HBoxContainer / Path
@onready var _ability_button: Button = $Panel / VBoxContainer / HBoxContainer / Ability
@onready var _discipline_button: Button = $Panel / VBoxContainer / HBoxContainer / Discipline

var _student_name: String = ""

func _ready() -> void :
    visible = false
    _path_button.pressed.connect( func(): _on_subject_pressed("Path"))
    _ability_button.pressed.connect( func(): _on_subject_pressed("Ability"))
    _discipline_button.pressed.connect( func(): _on_subject_pressed("Discipline"))

func open_for_student(student_name: String) -> void :
    _student_name = student_name
    visible = true
    move_to_front()

func _on_subject_pressed(subject: String) -> void :
    visible = false
    emit_signal("subject_selected", _student_name, subject)
