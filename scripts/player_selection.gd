extends Control

@onready var option_button: OptionButton = $Panel / VBoxContainer / OptionButton
@onready var title_label: Label = $Panel / VBoxContainer / Label
@onready var cancel_button: Button = $Panel / VBoxContainer / HBoxContainer / Cancel
@onready var select_button: Button = $Panel / VBoxContainer / HBoxContainer / Select

var character_data: CharacterData
var current_mode: String = ""
var selection_target: String = ""
var mentor_subject: String = ""

func _ready() -> void :
    cancel_button.pressed.connect(_on_cancel_pressed)
    select_button.pressed.connect(_on_select_pressed)


    if not NetworkManager.is_connected("zone_character_list_received", Callable(self, "_on_receive_zone_character_list")):
        NetworkManager.connect("zone_character_list_received", Callable(self, "_on_receive_zone_character_list"))

    if not NetworkManager.is_connected("all_character_names_received", Callable(self, "_on_receive_all_character_names")):
        NetworkManager.connect("all_character_names_received", Callable(self, "_on_receive_all_character_names"))


    if not NetworkManager.is_connected("mentor_target_list_received", Callable(self, "_on_mentor_target_list")):
        NetworkManager.connect("mentor_target_list_received", Callable(self, "_on_mentor_target_list"))

    if not NetworkManager.is_connected("mentor_discipline_list_received", Callable(self, "_on_mentor_discipline_list")):
        NetworkManager.connect("mentor_discipline_list_received", Callable(self, "_on_mentor_discipline_list"))

    if not NetworkManager.is_connected("mentor_teaching_options_received", Callable(self, "_on_mentor_teaching_options")):
        NetworkManager.connect("mentor_teaching_options_received", Callable(self, "_on_mentor_teaching_options"))

func enter_state(mode: String, data: Resource, target: Variant = null) -> void :
    current_mode = mode
    character_data = data
    selection_target = ""
    mentor_subject = ""
    if target != null:
        if target is Dictionary:
            var tdict: Dictionary = target as Dictionary
            selection_target = String(tdict.get("student", ""))
            mentor_subject = String(tdict.get("subject", ""))
        else:
            selection_target = String(target)

    option_button.clear()
    select_button.disabled = true
    _set_title_text()

    match current_mode:

        "whisper", "possess", "delete", "view_description", "edit", "GroupInvite", "GiveBloodSelectTarget":
            NetworkManager.rpc("set_peer_mode", current_mode)
            NetworkManager.rpc("request_zone_character_list", character_data.name)

        "teleport_to_character", "summon", "tell", "STDamage", "STGiveAP":
            NetworkManager.rpc("set_peer_mode", current_mode)
            NetworkManager.rpc("request_all_character_names", character_data.name)


        "MentorSelectStudent":

            NetworkManager.rpc("request_mentor_target_list", character_data.name)

        "MentorSelectDiscipline":

            if selection_target == "":
                push_warning("MentorSelectDiscipline requires a student target.")
            else:
                NetworkManager.rpc("request_mentor_discipline_list", character_data.name, selection_target)

        "MentorTeachSelectStudent":
            NetworkManager.rpc("request_mentor_target_list", character_data.name)

        "MentorTeachSelectTopic":
            if selection_target == "" or mentor_subject == "":
                push_warning("MentorTeachSelectTopic requires a student target and subject.")
            else:
                NetworkManager.rpc("request_mentor_teaching_options", character_data.name, selection_target, mentor_subject)

        _:
            print("⚠ Unknown mode passed to PlayerSelection:", current_mode)

    var viewport_size: Vector2 = get_viewport_rect().size
    global_position = (viewport_size - size) / 2
    self.visible = true



func _on_receive_zone_character_list(names: Array) -> void :
    if current_mode not in ["whisper", "possess", "delete", "view_description", "edit", "GroupInvite", "GiveBloodSelectTarget"]:
        return
    option_button.clear()
    for char_name_v in names:
        var char_name: = String(char_name_v)

        if current_mode == "GiveBloodSelectTarget" and char_name == character_data.name:
            continue
        option_button.add_item(char_name)
    select_button.disabled = option_button.item_count == 0

func _on_receive_all_character_names(names: Array) -> void :
    if current_mode not in ["teleport_to_character", "summon", "tell", "STDamage", "STGiveAP"]:
        return
    option_button.clear()
    for char_name_v in names:
        var char_name: = String(char_name_v)
        if char_name == character_data.name:
            continue
        option_button.add_item(char_name)
    select_button.disabled = option_button.item_count == 0



func _on_mentor_target_list(names: Array) -> void :
    if current_mode not in ["MentorSelectStudent", "MentorTeachSelectStudent"]:
        return
    option_button.clear()
    for n in names:
        option_button.add_item(String(n))
    select_button.disabled = option_button.item_count == 0

func _on_mentor_discipline_list(student_name: String, disciplines: Array) -> void :
    if current_mode != "MentorSelectDiscipline":
        return

    if String(student_name) != selection_target:
        return
    option_button.clear()
    for d in disciplines:
        option_button.add_item(String(d))
    select_button.disabled = option_button.item_count == 0

func _on_mentor_teaching_options(student_name: String, subject: String, options: Array, auto_select: bool, auto_value: String, auto_label: String) -> void :
    if current_mode != "MentorTeachSelectTopic":
        return
    if String(student_name) != selection_target or String(subject) != mentor_subject:
        return

    if auto_select:
        _send_mentor_training_invite(auto_value, auto_label)
        self.visible = false
        return

    option_button.clear()
    for entry_v in options:
        if entry_v is Dictionary:
            var entry: Dictionary = entry_v as Dictionary
            var label: String = String(entry.get("label", ""))
            var value: String = String(entry.get("value", ""))
            var idx: int = option_button.item_count
            option_button.add_item(label)
            option_button.set_item_metadata(idx, value)
        else:
            var item_label: String = String(entry_v)
            var idx2: int = option_button.item_count
            option_button.add_item(item_label)
            option_button.set_item_metadata(idx2, item_label)
    select_button.disabled = option_button.item_count == 0



func _on_cancel_pressed() -> void :
    self.visible = false

func _on_select_pressed() -> void :
    if option_button.item_count == 0:
        return
    var selected_text: String = option_button.get_item_text(option_button.selected)

    match current_mode:

        "whisper":
            var words_input_panel: Node = get_parent().get_node("WordsInputPanel")
            words_input_panel.call("enter_state", "whisper", character_data, selected_text)
            self.visible = false

        "tell":
            var words_input_panel2: Node = get_parent().get_node("WordsInputPanel")
            words_input_panel2.call("enter_state", "tell", character_data, selected_text)
            self.visible = false

        "possess":
            NetworkManager.rpc("request_possess", selected_text)
            self.visible = false

        "delete":
            NetworkManager.rpc("request_delete_character", selected_text)
            self.visible = false

        "teleport_to_character":
            NetworkManager.rpc("request_zone_move_to", character_data.name, selected_text, "to_character")
            self.visible = false

        "summon":
            NetworkManager.rpc("request_zone_move_to", selected_text, character_data.name, "summon")
            self.visible = false

        "view_description":
            NetworkManager.rpc("request_character_description", character_data.name, selected_text)
            self.visible = false

        "edit":
            var character_ui: Node = get_parent()
            var editable_panel: Node = character_ui.get_node("CharacterSheetEditableUI")
            if editable_panel:
                editable_panel.visible = true
                editable_panel.call("load_character", selected_text)
            else:
                print("⚠️ Editable panel not found.")
            self.visible = false

        "GroupInvite":
            print("📨 Inviting %s to group..." % selected_text)
            NetworkManager.rpc("request_send_group_invitation", character_data.name, selected_text)
            self.visible = false

        "STDamage":
            var st_panel: Node = get_parent().get_node_or_null("STHealingPanel")
            if st_panel:
                st_panel.visible = true
                if st_panel.has_method("set_target"):
                    st_panel.call("set_target", selected_text)
                else:
                    print("⚠️ set_target() not found on STHealingPanel.")
                if st_panel.has_method("set_character_data"):
                    st_panel.call("set_character_data", character_data)
                else:
                    print("⚠️ set_character_data() not found on STHealingPanel.")
            else:
                print("❌ STHealingPanel not found under parent.")
            self.visible = false

        "STGiveAP":
            NetworkManager.rpc("request_grant_ap", selected_text)
            self.visible = false


        "MentorSelectStudent":

            selection_target = selected_text
            current_mode = "MentorSelectDiscipline"
            option_button.clear()
            select_button.disabled = true
            NetworkManager.rpc("request_mentor_discipline_list", character_data.name, selection_target)

        "MentorSelectDiscipline":

            var discipline: String = selected_text
            NetworkManager.rpc("request_send_mentor_invite", character_data.name, selection_target, discipline)
            self.visible = false

        "MentorTeachSelectStudent":
            selection_target = selected_text
            var mentor_subject_panel: Node = get_parent().get_node_or_null("MentorSelectionSubject")
            if mentor_subject_panel and mentor_subject_panel.has_method("open_for_student"):
                mentor_subject_panel.call("open_for_student", selection_target)
                self.visible = false
            else:
                print("⚠️ MentorSelectionSubject panel not found.")
                self.visible = false

        "MentorTeachSelectTopic":
            var selected_idx: int = option_button.selected
            var meta: Variant = option_button.get_item_metadata(selected_idx)
            var topic_value: String = String(meta) if meta != null else selected_text
            _send_mentor_training_invite(topic_value, selected_text)
            self.visible = false


        "GiveBloodSelectTarget":

            NetworkManager.rpc("request_send_blood_offer", character_data.name, selected_text)
            self.visible = false

        _:
            print("⚠ No selection behavior defined for mode:", current_mode)
            self.visible = false

func _send_mentor_training_invite(topic_value: String, topic_label: String) -> void :
    if character_data == null or selection_target == "":
        return
    NetworkManager.rpc(
        "request_send_mentor_invite", 
        character_data.name, 
        selection_target, 
        topic_value, 
        mentor_subject, 
        "mentor_training", 
        topic_label
    )

func _set_title_text() -> void :
    if current_mode == "MentorTeachSelectTopic":
        title_label.text = "What will you teach?"
    else:
        title_label.text = "Who do you select?"
