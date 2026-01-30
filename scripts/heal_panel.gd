extends Control

var character_data

func set_character_data(data):
    character_data = data

func _ready() -> void :
    var btn_bash: Button = get_node("Panel/HBoxContainer/Bash_Lethal") as Button
    if btn_bash and not btn_bash.is_connected("pressed", Callable(self, "_on_bash_lethal_pressed")):
        btn_bash.pressed.connect(_on_bash_lethal_pressed)

    var btn_agg: Button = get_node_or_null("Panel/HBoxContainer/Aggravated") as Button
    if btn_agg and not btn_agg.is_connected("pressed", Callable(self, "_on_aggravated_pressed")):
        btn_agg.pressed.connect(_on_aggravated_pressed)

    var btn_cancel: Button = get_node("Panel/HBoxContainer/Cancel") as Button
    if btn_cancel and not btn_cancel.is_connected("pressed", Callable(self, "_on_cancel_pressed")):
        btn_cancel.pressed.connect(_on_cancel_pressed)

func _on_bash_lethal_pressed() -> void :
    if not character_data:
        return
    get_node("/root/NetworkManager").rpc("request_heal_bash_lethal", character_data.name)

func _on_aggravated_pressed() -> void :
    if not character_data:
        return
    get_node("/root/NetworkManager").rpc("request_heal_aggravated", character_data.name)

func _on_cancel_pressed() -> void :
    self.visible = false
