extends Control


@onready var _label: Label = $Panel / VBoxContainer / Label
@onready var _btn_approve: Button = $Panel / VBoxContainer / HBoxContainer / Approve
@onready var _btn_decline: Button = $Panel / VBoxContainer / HBoxContainer / Disapprove

var _pending_teacher: String = ""
var _pending_student: String = ""
var _pending_subject: String = ""
var _pending_topic_label: String = ""

func _ready() -> void :
    visible = false
    _btn_approve.pressed.connect(_on_approve_pressed)
    _btn_decline.pressed.connect(_on_decline_pressed)


    if not NetworkManager.is_connected("mentor_invite_received", Callable(self, "_on_mentor_invite_received")):
        NetworkManager.connect("mentor_invite_received", Callable(self, "_on_mentor_invite_received"))

func _on_mentor_invite_received(packet: Dictionary) -> void :

    var me: String = ""
    if GameManager.character_data:
        me = String(GameManager.character_data.name)

    var student: String = String(packet.get("student", ""))
    if me == "" or student == "" or me != student:

        return

    _pending_teacher = String(packet.get("teacher", ""))
    _pending_student = student
    _pending_subject = String(packet.get("subject", "Discipline"))
    _pending_topic_label = String(packet.get("topic_label", ""))


    var who: String = _pending_teacher if _pending_teacher != "" else "Someone"
    var what: String = _pending_topic_label
    if what == "":
        what = String(packet.get("discipline", ""))
    if what == "":
        what = _pending_subject if _pending_subject != "" else "something"
    _label.text = "%s wants to teach you %s.\nAccept?" % [who, what]

    _btn_approve.disabled = false
    _btn_decline.disabled = false
    visible = true
    move_to_front()

func _on_approve_pressed() -> void :
    if _pending_student == "":
        return
    _btn_approve.disabled = true
    _btn_decline.disabled = true
    NetworkManager.rpc("request_respond_mentor_invite", _pending_student, true)
    _close()

func _on_decline_pressed() -> void :
    if _pending_student == "":
        return
    _btn_approve.disabled = true
    _btn_decline.disabled = true
    NetworkManager.rpc("request_respond_mentor_invite", _pending_student, false)
    _close()

func _close() -> void :
    visible = false
    _label.text = ""
    _pending_teacher = ""
    _pending_student = ""
    _pending_subject = ""
    _pending_topic_label = ""
