extends Control

signal selection_made(paths: Array[String])

@onready var dots_label: Label = $"Panel/VBoxContainer/Thaumaturgy Dots"
@onready var paths_label: Label = $"Panel/VBoxContainer/Thaumaturgy Paths"


@onready var ob1: OptionButton = $"Panel/VBoxContainer/HBoxContainer2/OptionButton"
@onready var down1: Button = $"Panel/VBoxContainer/HBoxContainer2/Button"
@onready var up1: Button = $"Panel/VBoxContainer/HBoxContainer2/Button2"
@onready var val1: Label = $"Panel/VBoxContainer/HBoxContainer2/Label"


@onready var ob2: OptionButton = $"Panel/VBoxContainer/HBoxContainer3/OptionButton"
@onready var down2: Button = $"Panel/VBoxContainer/HBoxContainer3/Button"
@onready var up2: Button = $"Panel/VBoxContainer/HBoxContainer3/Button2"
@onready var val2: Label = $"Panel/VBoxContainer/HBoxContainer3/Label"


@onready var ob3: OptionButton = $"Panel/VBoxContainer/HBoxContainer4/OptionButton"
@onready var down3: Button = $"Panel/VBoxContainer/HBoxContainer4/Button"
@onready var up3: Button = $"Panel/VBoxContainer/HBoxContainer4/Button2"
@onready var val3: Label = $"Panel/VBoxContainer/HBoxContainer4/Label"


@onready var select_button: Button = $"Panel/VBoxContainer/HBoxContainer/Select"
@onready var cancel_button: Button = $"Panel/VBoxContainer/HBoxContainer/Cancel"


var T: int = 0
var P: int = 0
var S1: int = 0
var S2: int = 0


const THAUMATURGY_PATHS: PackedStringArray = [
    "The Path of Blood", 
    "The Blessings of the Great Dark Mother", 
    "Elemental Mastery", 
    "The Green Path", 
    "Hands of Destruction", 
    "The Lure of Flames", 
    "Mastery of the Mortal Shell", 
    "Movement of the Mind", 
    "Neptune's Might", 
    "The Path of Conjuring", 
    "The Path of Corruption", 
    "The Path of Mars", 
    "Path of Spirit Manipulation", 
    "The Path of Technomancy", 
    "The Path of the Father's Vengeance", 
    "Path of the Focused Mind", 
    "Path of the Levinbolt", 
    "Potestas Motus (Power of Motion)", 
    "Thaumaturgical Countermagic", 
    "Weather Control", 
    "Cammano-deuonertos"
]

func _ready() -> void :
    up1.pressed.connect(_on_up1_pressed)
    down1.pressed.connect(_on_down1_pressed)

    up2.pressed.connect(_on_up2_pressed)
    down2.pressed.connect(_on_down2_pressed)

    up3.pressed.connect(_on_up3_pressed)
    down3.pressed.connect(_on_down3_pressed)

    select_button.pressed.connect(_on_select_pressed)
    cancel_button.pressed.connect(_on_cancel_pressed)

    self.visible = false

func show_paths_mode(
        thauma_dots: int, 
        path_names: PackedStringArray, 
        dots_label_text: String = "Thaumaturgy Dots", 
        paths_label_text: String = "Thaumaturgy Paths"
    ) -> void :

    T = max(0, thauma_dots)
    P = 0
    S1 = 0
    S2 = 0


    self.process_mode = Node.PROCESS_MODE_INHERIT
    self.set_process_input(true)
    self.mouse_filter = Control.MOUSE_FILTER_STOP


    val1.text = "0"
    val2.text = "0"
    val3.text = "0"
    dots_label.text = "%s: %s" % [dots_label_text, str(T)]
    paths_label.text = paths_label_text


    var names: PackedStringArray
    if path_names.size() > 0:
        names = path_names
    else:
        names = THAUMATURGY_PATHS


    for ob in [ob1, ob2, ob3]:
        ob.clear()
        for n in names:
            ob.add_item(n)
        ob.select(-1)

    _refresh_ui()
    self.visible = true
    $Panel.visible = true


func _remaining() -> int:
    return T - (P + S1 + S2)

func _secondary_cap() -> int:
    if P <= 4:
        return max(0, P - 1)
    return 5

func _row2_unlocked() -> bool:
    return P >= 2

func _row3_unlocked() -> bool:
    return P >= 2 and S1 >= 1

func _primary_named() -> bool:
    return ob1.get_selected_id() != -1

func _secondary1_named_if_used() -> bool:
    return S1 == 0 or ob2.get_selected_id() != -1

func _secondary2_named_if_used() -> bool:
    return S2 == 0 or ob3.get_selected_id() != -1

func _names_unique() -> bool:
    var names: Array[String] = []
    if P > 0 and ob1.get_selected_id() != -1:
        names.append(ob1.get_item_text(ob1.get_selected_id()))
    if S1 > 0 and ob2.get_selected_id() != -1:
        names.append(ob2.get_item_text(ob2.get_selected_id()))
    if S2 > 0 and ob3.get_selected_id() != -1:
        names.append(ob3.get_item_text(ob3.get_selected_id()))


    var seen: = {}
    for n in names:
        if seen.has(n):
            return false
        seen[n] = true
    return true

func _down1_allowed() -> bool:
    if P <= 0:
        return false
    var newP: int = P - 1

    if newP < 2 and (S1 > 0 or S2 > 0):
        return false

    var cap: int
    if newP <= 4:
        cap = max(0, newP - 1)
    else:
        cap = 5
    if S1 > cap or S2 > cap:
        return false
    return true

func _down2_allowed() -> bool:
    if S1 <= 0:
        return false

    if S1 == 1 and S2 > 0:
        return false
    return true

func _down3_allowed() -> bool:
    return S2 > 0

func _up1_allowed() -> bool:
    if P >= 5:
        return false
    return _remaining() > 0

func _up2_allowed() -> bool:
    if not _row2_unlocked():
        return false
    var cap: int = _secondary_cap()
    if S1 >= cap:
        return false
    return _remaining() > 0

func _up3_allowed() -> bool:
    if not _row3_unlocked():
        return false
    var cap: int = _secondary_cap()
    if S2 >= cap:
        return false
    return _remaining() > 0

func _refresh_ui() -> void :

    var r2: = _row2_unlocked()
    var r3: = _row3_unlocked()

    ob2.disabled = not r2
    down2.disabled = not r2 or not _down2_allowed()
    up2.disabled = not r2 or not _up2_allowed()

    ob3.disabled = not r3
    down3.disabled = not r3 or not _down3_allowed()
    up3.disabled = not r3 or not _up3_allowed()

    down1.disabled = not _down1_allowed()
    up1.disabled = not _up1_allowed()


    val1.text = str(P)
    val2.text = str(S1)
    val3.text = str(S2)
    dots_label.text = str(_remaining())


    var base_ok: = (T == 0) or (P >= 1 and _primary_named())
    var names_ok: = _secondary1_named_if_used() and _secondary2_named_if_used() and _names_unique()
    select_button.disabled = not (base_ok and names_ok)


func _on_up1_pressed() -> void :
    if not _up1_allowed():
        return
    P += 1
    _refresh_ui()

func _on_down1_pressed() -> void :
    if not _down1_allowed():
        return
    P -= 1
    _refresh_ui()

func _on_up2_pressed() -> void :
    if not _up2_allowed():
        return
    S1 += 1
    _refresh_ui()

func _on_down2_pressed() -> void :
    if not _down2_allowed():
        return
    S1 -= 1
    _refresh_ui()

func _on_up3_pressed() -> void :
    if not _up3_allowed():
        return
    S2 += 1
    _refresh_ui()

func _on_down3_pressed() -> void :
    if not _down3_allowed():
        return
    S2 -= 1
    _refresh_ui()

func _on_select_pressed() -> void :

    if T > 0 and (P < 1 or not _primary_named()):
        return
    if not _secondary1_named_if_used():
        return
    if not _secondary2_named_if_used():
        return
    if not _names_unique():
        return
    if _remaining() != 0:

        pass

    var result: Array[String] = []


    if P > 0 and ob1.get_selected_id() != -1:
        var n1: = ob1.get_item_text(ob1.get_selected_id())
        result.append("%s:%d" % [n1, P])


    if S1 > 0 and ob2.get_selected_id() != -1:
        var n2: = ob2.get_item_text(ob2.get_selected_id())
        result.append("%s:%d" % [n2, S1])


    if S2 > 0 and ob3.get_selected_id() != -1:
        var n3: = ob3.get_item_text(ob3.get_selected_id())
        result.append("%s:%d" % [n3, S2])


    self.visible = false
    self.process_mode = Node.PROCESS_MODE_DISABLED
    self.set_process_input(false)
    emit_signal("selection_made", result)

func _on_cancel_pressed() -> void :
    self.visible = false
