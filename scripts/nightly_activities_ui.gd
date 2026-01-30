extends Control

var dragging: = false
var drag_offset: = Vector2.ZERO


var saved_position: Vector2 = Vector2.ZERO
var position_saved: bool = false


var attribute_upgrade_button_theme: = preload("res://Image/UI/BloodButtonCompleted.tres")
var _last_discipline_payload: Dictionary = {}

func _ready() -> void :

    $Panel / Cancel.pressed.connect(_on_Cancel_pressed)
    $Panel / NightlyActivitiesScroller / NightlyActivitiesContainer / HuntingContainer / HuntingButton.pressed.connect(_on_HuntingButton_pressed)
    $Panel / NightlyActivitiesScroller / NightlyActivitiesContainer / WillpowerRecoverContainer2 / WillpowerRecoverButton.pressed.connect(_on_WillpowerRecoverButton_pressed)
    $Panel / NightlyActivitiesScroller / NightlyActivitiesContainer / AttributesIncreaseContainer / AttributesIncreaseButton.pressed.connect(_on_AttributesIncreaseButton_pressed)
    $Panel / NightlyActivitiesScroller / NightlyActivitiesContainer / AbilitiesIncreaseContainer2 / AbilitiesIncreaseButton.pressed.connect(_on_AbilitiesIncreaseButton_pressed)
    $Panel / NightlyActivitiesScroller / NightlyActivitiesContainer / VirtueIncreaseContainer3 / VirtueIncreaseButton.pressed.connect(_on_VirtueIncreaseButton_pressed)
    $Panel / NightlyActivitiesScroller / NightlyActivitiesContainer / HerdManagerContainer4 / HerdManagerButton.pressed.connect(_on_HerdManagerButton_pressed)
    $Panel / WillpowerButtonDetailContainer.pressed.connect(_on_WillpowerButton_pressed)
    $Panel / NightlyActivitiesScroller / NightlyActivitiesContainer / DisciplineIncreaseContainer / DisciplineButton.pressed.connect(_on_DisciplineIncreaseButton_pressed)
    $Panel / NightlyActivitiesScroller / NightlyActivitiesContainer / DisciplineTeachContainer / DisciplineTeachButton.pressed.connect(_on_DisciplineTeachButton_pressed)
    $Panel / NightlyActivitiesScroller / NightlyActivitiesContainer / MentorAStudentContainer2 / MentorAStudentButton.pressed.connect(_on_MentorAStudentButton_pressed)


    $Panel / DetailScrollContainer.horizontal_scroll_mode = ScrollContainer.SCROLL_MODE_DISABLED
    $Panel2.visibility_changed.connect(_on_Panel2_visibility_changed)
    var mentor_subject_panel: Node = get_node_or_null("MentorSelectionSubject")
    if mentor_subject_panel and mentor_subject_panel.has_signal("subject_selected"):
        mentor_subject_panel.connect("subject_selected", Callable(self, "_on_mentor_subject_selected"))


    if NetworkManager.has_signal("herd_feed_result"):
        NetworkManager.herd_feed_result.connect(_on_herd_feed_result)
    if NetworkManager.has_signal("group_summary_received"):
        NetworkManager.group_summary_received.connect(_on_group_summary_received)
    self.visibility_changed.connect(_on_NAU_visibility_changed_status)
    if NetworkManager.has_signal("group_presence_received"):
        NetworkManager.group_presence_received.connect(_on_group_presence_received)
    if NetworkManager.has_signal("member_na_panel_status"):
        NetworkManager.member_na_panel_status.connect(_on_member_na_panel_status)


    await get_tree().process_frame
    const DETAIL_PX_WIDTH: = 329
    var sc: = $Panel / DetailScrollContainer as ScrollContainer
    var vbox: = $Panel / DetailScrollContainer / DetailVBoxContainer as VBoxContainer
    if sc and vbox:
        vbox.size_flags_horizontal = Control.SIZE_SHRINK_CENTER
        vbox.custom_minimum_size.x = DETAIL_PX_WIDTH
        sc.horizontal_scroll_mode = ScrollContainer.SCROLL_MODE_DISABLED


    apply_saved_position()

func _gui_input(event: InputEvent) -> void :
    if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
        dragging = event.pressed
        if dragging:
            drag_offset = get_global_mouse_position() - $Panel.global_position
    elif event is InputEventMouseMotion and dragging:
        $Panel.global_position = get_global_mouse_position() - drag_offset

func _on_Cancel_pressed() -> void :
    remember_position()
    clear_children($Panel / DetailScrollContainer / DetailVBoxContainer)
    _wp_armed = false
    _hide_willpower_button()
    self.visible = false

func _format_roll_bbcode(opt: Dictionary) -> String:
    var roll_arr: Array = opt.get("roll", [])
    var a: String = String(roll_arr[0]) if roll_arr.size() > 0 else "?"
    var b: String = String(roll_arr[1]) if roll_arr.size() > 1 else "?"
    var diff_bb: String = String(opt.get("difficulty_bbcode", str(opt.get("difficulty", 6))))
    return "Roll: %s + %s   (Difficulty %s)" % [a, b, diff_bb]


func _on_HuntingButton_pressed() -> void :
    clear_children($Panel / DetailScrollContainer / DetailVBoxContainer)


    _wp_armed = false
    _hide_willpower_button()


    if "ensure_loaded" in HuntScenarioManager:
        HuntScenarioManager.ensure_loaded()

    var label: = Label.new()
    label.text = "Select Hunting Method"
    label.add_theme_color_override("font_color", Color.WHITE)
    label.add_theme_font_size_override("font_size", 16)
    $Panel / DetailScrollContainer / DetailVBoxContainer.add_child(label)


    var is_nosferatu: = false
    if GameManager.character_data:
        var clan_l: = String(GameManager.character_data.clan).to_lower()
        is_nosferatu = (clan_l == "nosferatu" or clan_l == "nosferatu antitribu")

    if not is_nosferatu:
        _add_hunt_type_button("Social", "Social")
    _add_hunt_type_button("Prowling", "Prowl")

    _scroll_detail_to_top()

func _add_hunt_type_button(label_text: String, hunt_type: String) -> void :
    var hbox: = HBoxContainer.new()
    hbox.size_flags_horizontal = Control.SIZE_EXPAND_FILL

    var label: = Label.new()
    label.text = label_text + " Hunt"
    label.size_flags_horizontal = Control.SIZE_EXPAND_FILL
    label.custom_minimum_size = Vector2(200, 0)
    hbox.add_child(label)

    var button: = Button.new()
    button.custom_minimum_size = Vector2(40, 0)
    button.theme = preload("res://Image/UI/BloodButtonCompleted.tres")
    button.pressed.connect( func():
        if GameManager.character_data:
            NetworkManager.rpc("request_hunt_scenario_list", GameManager.character_data.name, hunt_type)
    )
    hbox.add_child(button)

    $Panel / DetailScrollContainer / DetailVBoxContainer.add_child(hbox)

func _on_WillpowerRecoverButton_pressed() -> void :
    if GameManager.character_data:
        NetworkManager.rpc("request_NA_WillpowerRecover", GameManager.character_data.name)


func _on_AttributesIncreaseButton_pressed() -> void :
    if GameManager.character_data:
        NetworkManager.rpc("request_attribute_upgrade_data", GameManager.character_data.name)


func _on_AbilitiesIncreaseButton_pressed() -> void :
    if GameManager.character_data:
        NetworkManager.rpc("request_ability_upgrade_data", GameManager.character_data.name)

func _on_VirtueIncreaseButton_pressed() -> void :
    if GameManager.character_data:
        NetworkManager.rpc("request_virtue_upgrade_data", GameManager.character_data.name)




func populate_from_server_data(data: Dictionary) -> void :
    $Panel / CharacterInformationPanel / CharacterInformationContainer / LocationContainer / LocationAnswer.text = data.get("zone", "Unknown")
    $Panel / CharacterInformationPanel / CharacterInformationContainer / ActivityContainer / ActivityPointCurrent.text = str(data.get("ap_current", 0))
    $Panel / CharacterInformationPanel / CharacterInformationContainer / ActivityContainer / ActivityPointMax.text = str(data.get("ap_max", 0))
    $Panel / CharacterInformationPanel / CharacterInformationContainer / BloodContainer / BloodCurrent.text = str(data.get("blood_current", 0))
    $Panel / CharacterInformationPanel / CharacterInformationContainer / BloodContainer / BloodMax.text = str(data.get("blood_max", 0))
    $Panel / CharacterInformationPanel / CharacterInformationContainer / WillpowerContainer / WillpowerCurrent.text = str(data.get("wp_current", 0))
    $Panel / CharacterInformationPanel / CharacterInformationContainer / WillpowerContainer / WillpowerMax.text = str(data.get("wp_max", 0))

    var ap_current: int = int(data.get("ap_current", 0))
    var wp_current: int = int(data.get("wp_current", 0))
    var wp_max: int = int(data.get("wp_max", 0))


    var herd_dots: int = 0
    if data.has("herd_dots"):
        herd_dots = int(data["herd_dots"])
    elif GameManager.character_data:
        herd_dots = int(GameManager.character_data.herd)


    $Panel / NightlyActivitiesScroller / NightlyActivitiesContainer / AttributesIncreaseContainer / AttributesIncreaseButton.disabled = ap_current <= 0
    $Panel / NightlyActivitiesScroller / NightlyActivitiesContainer / AbilitiesIncreaseContainer2 / AbilitiesIncreaseButton.disabled = ap_current <= 0
    $Panel / NightlyActivitiesScroller / NightlyActivitiesContainer / HuntingContainer / HuntingButton.disabled = ap_current <= 0


    var disc_btn: Button = $Panel / NightlyActivitiesScroller / NightlyActivitiesContainer / DisciplineIncreaseContainer / DisciplineButton
    if disc_btn:
        disc_btn.disabled = ap_current <= 0
        disc_btn.tooltip_text = "Not enough Activity Points." if ap_current <= 0 else ""

    var mentor_btn: Button = $Panel / NightlyActivitiesScroller / NightlyActivitiesContainer / MentorAStudentContainer2 / MentorAStudentButton
    if mentor_btn:
        mentor_btn.disabled = ap_current <= 0
        mentor_btn.tooltip_text = "Not enough Activity Points." if ap_current <= 0 else ""


    var herd_btn: Button = $Panel / NightlyActivitiesScroller / NightlyActivitiesContainer / HerdManagerContainer4 / HerdManagerButton
    herd_btn.disabled = (ap_current <= 0) or (herd_dots <= 0)
    if herd_dots <= 0:
        herd_btn.tooltip_text = "You have no herd."
    elif ap_current <= 0:
        herd_btn.tooltip_text = "Not enough Activity Points."
    else:
        herd_btn.tooltip_text = ""

    $Panel / NightlyActivitiesScroller / NightlyActivitiesContainer / WillpowerRecoverContainer2 / WillpowerRecoverButton.disabled = (ap_current <= 0) or (wp_current >= wp_max)


    print("NA summary → ap_current=", ap_current, " herd_dots=", herd_dots)


func populate_attribute_upgrade_panel(data: Dictionary) -> void :
    var container: = $Panel / DetailScrollContainer / DetailVBoxContainer
    clear_children(container)

    _add_header_row(container)

    var attribute_names: = [
        "strength", "dexterity", "stamina", 
        "charisma", "manipulation", "appearance", 
        "perception", "intelligence", "wits"
    ]

    for attr in attribute_names:
        container.add_child(_create_ability_row(attr, data))

func populate_ability_upgrade_panel(data: Dictionary) -> void :
    var container: = $Panel / DetailScrollContainer / DetailVBoxContainer
    clear_children(container)

    _add_header_row(container)

    _add_ability_section("Talents", [
        "alertness", "athletics", "awareness", "brawl", "empathy", 
        "expression", "intimidation", "leadership", "streetwise", "subterfuge"
    ], data)

    _add_ability_section("Skills", [
        "animal_ken", "crafts", "drive", "etiquette", "firearms", 
        "larceny", "melee", "performance", "stealth", "survival"
    ], data)

    _add_ability_section("Knowledges", [
        "academics", "computer", "finance", "investigation", "law", 
        "medicine", "occult", "politics", "science", "technology"
    ], data)

func _add_ability_section(title: String, abilities: Array, data: Dictionary) -> void :
    var container: = $Panel / DetailScrollContainer / DetailVBoxContainer

    var header: = Label.new()
    header.text = title
    header.add_theme_font_size_override("font_size", 14)
    header.add_theme_color_override("font_color", Color.SKY_BLUE)
    container.add_child(header)

    for ability in abilities:
        container.add_child(_create_ability_row(ability, data))

func _add_header_row(container: VBoxContainer) -> void :
    var header: = HBoxContainer.new()

    var name_label: = Label.new()
    name_label.text = "Trait"
    name_label.size_flags_horizontal = Control.SIZE_EXPAND_FILL
    name_label.custom_minimum_size = Vector2(160, 0)
    header.add_child(name_label)

    var dot_label: = Label.new()
    dot_label.text = "Dot"
    dot_label.size_flags_horizontal = Control.SIZE_EXPAND_FILL
    dot_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
    dot_label.custom_minimum_size = Vector2(40, 0)
    header.add_child(dot_label)

    var progress_label: = Label.new()
    progress_label.text = "Prog%"
    progress_label.size_flags_horizontal = Control.SIZE_EXPAND_FILL
    progress_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
    progress_label.custom_minimum_size = Vector2(40, 0)
    header.add_child(progress_label)


    var spacer: = Control.new()
    spacer.custom_minimum_size = Vector2(40, 0)
    header.add_child(spacer)

    container.add_child(header)

func _create_ability_row(stat: String, data: Dictionary) -> HBoxContainer:
    return _create_ability_row_discipline(stat, data.get(stat, 0), data.get(stat + "_progress", 0))

func _create_ability_row_discipline(stat: String, rating: int, progress_raw: float) -> HBoxContainer:
    var hbox: = HBoxContainer.new()
    hbox.size_flags_horizontal = Control.SIZE_EXPAND_FILL

    var name_label: = Label.new()
    name_label.text = stat.capitalize().replace("_", " ")
    name_label.size_flags_horizontal = Control.SIZE_EXPAND_FILL
    name_label.custom_minimum_size = Vector2(160, 0)
    name_label.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
    hbox.add_child(name_label)

    var value_label: = Label.new()
    value_label.text = str(rating)
    value_label.size_flags_horizontal = Control.SIZE_EXPAND_FILL
    value_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
    value_label.custom_minimum_size = Vector2(40, 0)
    hbox.add_child(value_label)

    var progress_label: = Label.new()
    progress_label.text = str("%.1f" % (progress_raw / 100.0)) + "%"
    progress_label.size_flags_horizontal = Control.SIZE_EXPAND_FILL
    progress_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
    progress_label.custom_minimum_size = Vector2(40, 0)
    hbox.add_child(progress_label)

    var button: = Button.new()
    button.text = "+"
    button.name = stat + "_upgrade_button"
    button.custom_minimum_size = Vector2(40, 0)
    button.size_flags_horizontal = Control.SIZE_EXPAND_FILL
    button.theme = attribute_upgrade_button_theme
    button.pressed.connect( func():
        if GameManager.character_data:
            NetworkManager.rpc("request_increase_stat", GameManager.character_data.name, stat)
    )
    hbox.add_child(button)

    return hbox

func clear_children(container: Control) -> void :
    for child in container.get_children():
        container.remove_child(child)
        child.queue_free()


@onready var herd_ui: Control = $HerdUI
@onready var group_vbox: VBoxContainer = $Panel / GroupScrollContainer / GroupVBoxContainer

var _member_status_labels: = {}
var _member_state: = {}


func _on_HerdManagerButton_pressed() -> void :
    var cd: CharacterData = GameManager.character_data
    if cd == null:
        return


    if int(cd.herd) <= 0:
        var container: VBoxContainer = $Panel / DetailScrollContainer / DetailVBoxContainer
        clear_children(container)
        var msg: Label = Label.new()
        msg.text = "You have no herd."
        msg.autowrap_mode = TextServer.AUTOWRAP_WORD
        msg.add_theme_font_size_override("font_size", 14)
        msg.add_theme_color_override("font_color", Color(1.0, 0.8, 0.8))
        container.add_child(msg)
        return


    if not is_instance_valid(herd_ui):
        push_error("HerdUI child is missing under NightlyActivitiesUI.")
        return

    herd_ui.visible = true


    if herd_ui.has_method("move_to_front"):
        herd_ui.call("move_to_front")
    elif herd_ui.get_parent() != null:
        var p: Node = herd_ui.get_parent()
        p.move_child(herd_ui, p.get_child_count() - 1)


    if herd_ui is Control:
        (herd_ui as Control).grab_focus()
    if herd_ui.has_method("open"):
        herd_ui.call("open")



func _add_hunt_option(container: VBoxContainer, label_text: String, hunt_type: String) -> void :
    var hbox: = HBoxContainer.new()
    hbox.size_flags_horizontal = Control.SIZE_EXPAND_FILL

    var label: = Label.new()
    label.text = label_text
    label.size_flags_horizontal = Control.SIZE_EXPAND_FILL
    label.custom_minimum_size = Vector2(200, 0)
    hbox.add_child(label)

    var button: = Button.new()
    button.text = ""
    button.custom_minimum_size = Vector2(40, 0)
    button.size_flags_horizontal = Control.SIZE_EXPAND_FILL
    button.theme = attribute_upgrade_button_theme
    button.pressed.connect( func():
        print("Selected hunt type:", hunt_type)
    )
    hbox.add_child(button)

    container.add_child(hbox)

func show_hunt_scenario_options(hunt_type: String, scenario_ids: Array[String]) -> void :
    print("📥 Showing hunt scenarios for:", hunt_type)

    var container: VBoxContainer = $Panel / DetailScrollContainer / DetailVBoxContainer
    clear_children(container)


    _wp_armed = false
    _hide_willpower_button()


    var title: Label = Label.new()
    title.text = "Choose your Scenario"
    title.add_theme_font_size_override("font_size", 14)
    title.add_theme_color_override("font_color", Color.SKY_BLUE)
    container.add_child(title)

    var subtitle: Label = Label.new()
    subtitle.text = "Selecting a scenario costs 1 Activity Point."
    subtitle.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
    subtitle.add_theme_font_size_override("font_size", 12)
    subtitle.modulate = Color(0.85, 0.85, 0.85)
    container.add_child(subtitle)

    var head_spacer: Control = Control.new()
    head_spacer.custom_minimum_size = Vector2(0, 6)
    container.add_child(head_spacer)


    var has_ap: bool = false
    if GameManager.character_data:
        has_ap = int(GameManager.character_data.action_points_current) > 0


    if scenario_ids.is_empty():
        var none: = Label.new()
        none.text = "No scenarios are available right now."
        none.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
        container.add_child(none)
        _scroll_detail_to_top()
        return

    for scenario_id in scenario_ids:

        var scenario_data: Dictionary = HuntScenarioManager.get_scenario(hunt_type, scenario_id)
        var name_txt: = String(scenario_data.get("scenario_name", scenario_id))
        var desc_txt: = String(scenario_data.get("description", ""))

        var row: HBoxContainer = HBoxContainer.new()
        row.size_flags_horizontal = Control.SIZE_EXPAND_FILL
        row.custom_minimum_size.y = 60
        row.add_theme_constant_override("separation", 20)

        var label_box: VBoxContainer = VBoxContainer.new()
        label_box.size_flags_horizontal = Control.SIZE_EXPAND_FILL

        var name_label: Label = Label.new()
        name_label.text = name_txt
        name_label.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
        name_label.size_flags_horizontal = Control.SIZE_EXPAND_FILL
        name_label.add_theme_font_size_override("font_size", 16)
        label_box.add_child(name_label)

        var desc_label: Label = Label.new()
        desc_label.text = desc_txt
        desc_label.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
        desc_label.size_flags_horizontal = Control.SIZE_EXPAND_FILL
        desc_label.add_theme_font_size_override("font_size", 13)
        desc_label.modulate = Color(0.8, 0.8, 0.8)
        label_box.add_child(desc_label)

        row.add_child(label_box)

        var button: Button = Button.new()
        button.custom_minimum_size = Vector2(36, 36)
        button.theme = attribute_upgrade_button_theme
        button.disabled = not has_ap
        button.tooltip_text = "Start this hunting scenario (costs 1 AP)" if has_ap else "Not enough Activity Points"
        button.pressed.connect(_on_hunt_scenario_selected.bind(hunt_type, scenario_id))
        row.add_child(button)

        container.add_child(row)

    _scroll_detail_to_top()
    print("✅ Hunt scenarios populated in UI.")


func _on_hunt_scenario_selected(hunt_type: String, scenario_id: String) -> void :
    NetworkManager.rpc("request_hunt_contact_phase", GameManager.character_data.name, hunt_type, scenario_id)





func _format_roll_string(roll: Array, difficulty: int) -> String:
    var a: String = "?"
    if roll.size() > 0:
        a = String(roll[0])

    var b: String = "?"
    if roll.size() > 1:
        b = String(roll[1])

    return "Roll: %s + %s   (Difficulty %d)" % [a, b, difficulty]


func show_contact_phase(hunt_type: String, scenario_id: String, data: Dictionary) -> void :
    var container: VBoxContainer = $Panel / DetailScrollContainer / DetailVBoxContainer
    clear_children(container)


    var header: VBoxContainer = VBoxContainer.new()
    header.size_flags_horizontal = Control.SIZE_EXPAND_FILL

    var name_label: Label = Label.new()
    name_label.text = String(data.get("scenario_name", scenario_id))
    name_label.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
    name_label.add_theme_font_size_override("font_size", 18)
    header.add_child(name_label)

    var desc_label: Label = Label.new()
    desc_label.text = String(data.get("description", ""))
    desc_label.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
    desc_label.add_theme_font_size_override("font_size", 13)
    desc_label.modulate = Color(0.8, 0.8, 0.8)
    header.add_child(desc_label)

    var spacer: Control = Control.new()
    spacer.custom_minimum_size = Vector2(0, 8)
    header.add_child(spacer)
    container.add_child(header)


    var section: Label = Label.new()
    section.text = "Contact: choose your approach"
    section.add_theme_font_size_override("font_size", 14)
    section.add_theme_color_override("font_color", Color.SKY_BLUE)
    container.add_child(section)


    var options_any: Variant = data.get("options", [])
    var options: Array[Dictionary] = []
    if options_any is Array:
        for v in (options_any as Array):
            if v is Dictionary:
                options.append(v as Dictionary)

    if options.is_empty():
        var none: Label = Label.new()
        none.text = "No contact options defined."
        container.add_child(none)
        _hide_willpower_button()
        return

    for opt in options:
        var row: HBoxContainer = HBoxContainer.new()
        row.size_flags_horizontal = Control.SIZE_EXPAND_FILL
        row.custom_minimum_size.y = 64
        row.add_theme_constant_override("separation", 16)

        var info: VBoxContainer = VBoxContainer.new()
        info.size_flags_horizontal = Control.SIZE_EXPAND_FILL

        var t: Label = Label.new()
        t.text = String(opt.get("title", "Untitled"))
        t.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
        t.add_theme_font_size_override("font_size", 15)
        info.add_child(t)

        var d: Label = Label.new()
        d.text = String(opt.get("description", ""))
        d.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
        d.add_theme_font_size_override("font_size", 12)
        d.modulate = Color(0.85, 0.85, 0.85)
        info.add_child(d)


        var roll_any: Variant = opt.get("roll", [])
        var roll_arr: Array = []
        if roll_any is Array:
            roll_arr = roll_any as Array

        var a_txt: String = (String(roll_arr[0]) if roll_arr.size() > 0 else "?")
        var b_txt: String = (String(roll_arr[1]) if roll_arr.size() > 1 else "?")

        var diff_val: int = int(opt.get("difficulty", 6))
        var diff_hex: String = String(opt.get("difficulty_color_hex", ""))

        var roll_row: = HBoxContainer.new()
        roll_row.size_flags_horizontal = Control.SIZE_EXPAND_FILL

        var pre: = Label.new()
        pre.text = "Roll: %s + %s   (Difficulty " % [a_txt, b_txt]
        pre.add_theme_font_size_override("font_size", 12)
        pre.modulate = Color(0.9, 0.9, 0.9)
        roll_row.add_child(pre)

        var diff: = Label.new()
        diff.text = str(diff_val)
        diff.add_theme_font_size_override("font_size", 12)
        if diff_hex != "":
            diff.add_theme_color_override("font_color", Color(diff_hex))
        roll_row.add_child(diff)

        var post: = Label.new()
        post.text = ")"
        post.add_theme_font_size_override("font_size", 12)
        post.modulate = Color(0.9, 0.9, 0.9)
        roll_row.add_child(post)

        info.add_child(roll_row)

        row.add_child(info)

        var btn: Button = Button.new()
        btn.custom_minimum_size = Vector2(36, 36)
        btn.theme = attribute_upgrade_button_theme
        btn.tooltip_text = "Attempt this approach"
        btn.pressed.connect(_on_contact_option_button_pressed.bind(hunt_type, scenario_id, int(opt.get("index", 0))))
        row.add_child(btn)

        container.add_child(row)

    _maybe_show_willpower_button_for_next_roll()
    _scroll_detail_to_top()
    print("✅ Contact phase rendered for %s/%s with %d options." % [hunt_type, scenario_id, options.size()])



func _add_roll_result_block(parent: VBoxContainer, roll: Dictionary) -> void :
    var box: VBoxContainer = VBoxContainer.new()
    box.size_flags_horizontal = Control.SIZE_EXPAND_FILL
    box.add_theme_constant_override("separation", 2)


    var top: Label = Label.new()
    var a: String = String(roll.get("attribute", "?"))
    var b: String = String(roll.get("ability", "?"))
    var diff: int = int(roll.get("difficulty", 6))
    var total_dice: int = int(roll.get("total_dice", 0))
    top.text = "%s + %s  •  Pool %d  •  Difficulty %d" % [a, b, total_dice, diff]
    top.add_theme_font_size_override("font_size", 13)
    box.add_child(top)


    var rolls_any: Variant = roll.get("rolls", [])
    var rolls_arr: Array = []
    if rolls_any is Array:
        rolls_arr = rolls_any as Array

    var rolls_label: Label = Label.new()
    rolls_label.text = "Rolls: " + str(rolls_arr)
    rolls_label.add_theme_font_size_override("font_size", 12)
    rolls_label.modulate = Color(0.9, 0.9, 0.9)
    box.add_child(rolls_label)


    var s_line: Label = Label.new()
    var succ: int = int(roll.get("successes", 0))
    var ones: int = int(roll.get("ones", 0))
    var eff_ones: int = int(roll.get("effective_ones", ones))
    var net: int = int(roll.get("net_successes", 0))
    var rtype: String = String(roll.get("result_type", ""))
    s_line.text = "Successes %d  •  1s %d (eff %d)  •  Net %d  •  %s" % [succ, ones, eff_ones, net, rtype]
    s_line.add_theme_font_size_override("font_size", 12)
    s_line.modulate = Color(0.9, 0.9, 0.9)
    box.add_child(s_line)

    parent.add_child(box)




func show_contact_result(hunt_type: String, scenario_id: String, result_payload: Dictionary) -> void :
    var container: VBoxContainer = $Panel / DetailScrollContainer / DetailVBoxContainer
    clear_children(container)


    _wp_armed = false


    var header: VBoxContainer = VBoxContainer.new()
    header.size_flags_horizontal = Control.SIZE_EXPAND_FILL

    var name_label: Label = Label.new()
    name_label.text = String(result_payload.get("scenario_name", scenario_id))
    name_label.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
    name_label.add_theme_font_size_override("font_size", 18)
    header.add_child(name_label)

    var desc_label: Label = Label.new()
    desc_label.text = String(result_payload.get("description", ""))
    desc_label.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
    desc_label.add_theme_font_size_override("font_size", 13)
    desc_label.modulate = Color(0.8, 0.8, 0.8)
    header.add_child(desc_label)

    var spacer: Control = Control.new()
    spacer.custom_minimum_size = Vector2(0, 8)
    header.add_child(spacer)
    container.add_child(header)


    var outcome: String = String(result_payload.get("outcome", "failure"))
    var outcome_label: Label = Label.new()
    match outcome:
        "success":
            outcome_label.text = "Contact Result: SUCCESS"
            outcome_label.add_theme_color_override("font_color", Color(0.6, 1.0, 0.6))
        "botch":
            outcome_label.text = "Contact Result: BOTCH"
            outcome_label.add_theme_color_override("font_color", Color(1.0, 0.5, 0.5))
        _:
            outcome_label.text = "Contact Result: FAILURE"
            outcome_label.add_theme_color_override("font_color", Color(1.0, 0.7, 0.5))
    outcome_label.add_theme_font_size_override("font_size", 14)
    container.add_child(outcome_label)


    var narrative: Label = Label.new()
    narrative.text = String(result_payload.get("narrative", ""))
    narrative.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
    narrative.add_theme_font_size_override("font_size", 13)
    container.add_child(narrative)


    var roll_block: VBoxContainer = VBoxContainer.new()
    roll_block.size_flags_horizontal = Control.SIZE_EXPAND_FILL
    var rr_any: Variant = result_payload.get("roll_result", {})
    var rr: Dictionary = {}
    if rr_any is Dictionary:
        rr = rr_any as Dictionary
    _add_roll_result_block(roll_block, rr)
    container.add_child(roll_block)


    if outcome == "success":
        var next_any: Variant = result_payload.get("next", {})
        var next: Dictionary = {}
        if next_any is Dictionary:
            next = next_any as Dictionary

        var options_any: Variant = next.get("options", [])
        var options: Array[Dictionary] = []
        if options_any is Array:
            for v in (options_any as Array):
                if v is Dictionary:
                    options.append(v as Dictionary)

        var h_spacer: Control = Control.new()
        h_spacer.custom_minimum_size = Vector2(0, 10)
        container.add_child(h_spacer)

        var section: Label = Label.new()
        section.text = "Hunt: choose your approach"
        section.add_theme_font_size_override("font_size", 14)
        section.add_theme_color_override("font_color", Color.SKY_BLUE)
        container.add_child(section)

        if options.is_empty():
            var none: Label = Label.new()
            none.text = "No hunt options available."
            container.add_child(none)
            _hide_willpower_button()
            _scroll_detail_to_top()
            return

        for opt in options:
            var row: HBoxContainer = HBoxContainer.new()
            row.size_flags_horizontal = Control.SIZE_EXPAND_FILL
            row.custom_minimum_size.y = 64
            row.add_theme_constant_override("separation", 16)

            var info: VBoxContainer = VBoxContainer.new()
            info.size_flags_horizontal = Control.SIZE_EXPAND_FILL

            var t: Label = Label.new()
            t.text = String(opt.get("title", "Untitled"))
            t.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
            t.add_theme_font_size_override("font_size", 15)
            info.add_child(t)

            var d: Label = Label.new()
            d.text = String(opt.get("description", ""))
            d.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
            d.add_theme_font_size_override("font_size", 12)
            d.modulate = Color(0.85, 0.85, 0.85)
            info.add_child(d)


            var roll_any: Variant = opt.get("roll", [])
            var roll_arr: Array = []
            if roll_any is Array:
                roll_arr = roll_any as Array

            var a_txt: String = "?"
            if roll_arr.size() > 0:
                a_txt = String(roll_arr[0])
            var b_txt: String = "?"
            if roll_arr.size() > 1:
                b_txt = String(roll_arr[1])

            var diff_val: int = int(opt.get("difficulty", 6))
            var diff_hex: String = String(opt.get("difficulty_color_hex", ""))

            var roll_row: = HBoxContainer.new()
            roll_row.size_flags_horizontal = Control.SIZE_EXPAND_FILL

            var pre: = Label.new()
            pre.text = "Roll: %s + %s   (Difficulty " % [a_txt, b_txt]
            pre.add_theme_font_size_override("font_size", 12)
            pre.modulate = Color(0.9, 0.9, 0.9)
            roll_row.add_child(pre)

            var diff: = Label.new()
            diff.text = str(diff_val)
            diff.add_theme_font_size_override("font_size", 12)
            if diff_hex != "":
                diff.add_theme_color_override("font_color", Color(diff_hex))
            roll_row.add_child(diff)

            var post: = Label.new()
            post.text = ")"
            post.add_theme_font_size_override("font_size", 12)
            post.modulate = Color(0.9, 0.9, 0.9)
            roll_row.add_child(post)

            info.add_child(roll_row)

            row.add_child(info)

            var btn: Button = Button.new()
            btn.custom_minimum_size = Vector2(36, 36)
            btn.theme = attribute_upgrade_button_theme
            btn.tooltip_text = "Attempt this hunt approach"
            btn.pressed.connect(_on_hunt_option_button_pressed.bind(hunt_type, scenario_id, int(opt.get("index", 0))))
            row.add_child(btn)

            container.add_child(row)


        _maybe_show_willpower_button_for_next_roll()
    else:

        _hide_willpower_button()

    _scroll_detail_to_top()
    print("✅ Contact result rendered for %s/%s" % [hunt_type, scenario_id])



func _on_contact_option_button_pressed(hunt_type: String, scenario_id: String, option_index: int) -> void :
    print("🧭 Contact option selected:", hunt_type, scenario_id, "index:", option_index)
    if GameManager.character_data:
        NetworkManager.rpc(
            "request_hunt_contact_choice", 
            GameManager.character_data.name, 
            hunt_type, 
            scenario_id, 
            option_index, 
            false, 
            false
        )



func _on_hunt_option_button_pressed(hunt_type: String, scenario_id: String, option_index: int) -> void :
    print("🎯 Hunt option selected:", hunt_type, scenario_id, "index:", option_index)
    if GameManager.character_data:
        NetworkManager.rpc(
            "request_hunt_choice", 
            GameManager.character_data.name, 
            hunt_type, 
            scenario_id, 
            option_index, 
            false, 
            false
        )



func show_hunt_result(hunt_type: String, scenario_id: String, result_payload: Dictionary) -> void :
    var container: VBoxContainer = $Panel / DetailScrollContainer / DetailVBoxContainer
    clear_children(container)


    _wp_armed = false


    var header: = VBoxContainer.new()
    header.size_flags_horizontal = Control.SIZE_EXPAND_FILL

    var name_label: = Label.new()
    name_label.text = String(result_payload.get("scenario_name", scenario_id))
    name_label.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
    name_label.add_theme_font_size_override("font_size", 18)
    header.add_child(name_label)

    var desc_label: = Label.new()
    desc_label.text = String(result_payload.get("description", ""))
    desc_label.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
    desc_label.add_theme_font_size_override("font_size", 13)
    desc_label.modulate = Color(0.8, 0.8, 0.8)
    header.add_child(desc_label)

    var spacer: = Control.new()
    spacer.custom_minimum_size = Vector2(0, 8)
    header.add_child(spacer)
    container.add_child(header)


    var outcome: = String(result_payload.get("outcome", "failure"))
    var outcome_label: = Label.new()
    match outcome:
        "success":
            outcome_label.text = "Hunt Result: SUCCESS"
            outcome_label.add_theme_color_override("font_color", Color(0.6, 1.0, 0.6))
        _:
            outcome_label.text = "Hunt Result: FAILURE"
            outcome_label.add_theme_color_override("font_color", Color(1.0, 0.7, 0.5))
    outcome_label.add_theme_font_size_override("font_size", 14)
    container.add_child(outcome_label)


    var narrative: = Label.new()
    narrative.text = String(result_payload.get("narrative", ""))
    narrative.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
    narrative.add_theme_font_size_override("font_size", 13)
    container.add_child(narrative)


    var roll_block: = VBoxContainer.new()
    roll_block.size_flags_horizontal = Control.SIZE_EXPAND_FILL
    var rr_any: Variant = result_payload.get("roll_result", {})
    var rr: Dictionary = {}
    if rr_any is Dictionary:
        rr = rr_any as Dictionary
    _add_roll_result_block(roll_block, rr)
    container.add_child(roll_block)


    if outcome == "success":
        var next_any: Variant = result_payload.get("next", {})
        var next: Dictionary = {}
        if next_any is Dictionary:
            next = next_any as Dictionary

        var options_any: Variant = next.get("options", [])
        var options: Array[Dictionary] = []
        if options_any is Array:
            for v in (options_any as Array):
                if v is Dictionary:
                    options.append(v as Dictionary)

        var h_spacer: = Control.new()
        h_spacer.custom_minimum_size = Vector2(0, 10)
        container.add_child(h_spacer)

        var section: = Label.new()
        section.text = "Defeat: choose your approach"
        section.add_theme_font_size_override("font_size", 14)
        section.add_theme_color_override("font_color", Color.SKY_BLUE)
        container.add_child(section)

        if options.is_empty():
            var none: = Label.new()
            none.text = "No defeat options available."
            container.add_child(none)
            _hide_willpower_button()
            _scroll_detail_to_top()
            return

        for opt in options:
            var row: = HBoxContainer.new()
            row.size_flags_horizontal = Control.SIZE_EXPAND_FILL
            row.custom_minimum_size.y = 64
            row.add_theme_constant_override("separation", 16)

            var info: = VBoxContainer.new()
            info.size_flags_horizontal = Control.SIZE_EXPAND_FILL

            var t: = Label.new()
            t.text = String(opt.get("title", "Untitled"))
            t.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
            t.add_theme_font_size_override("font_size", 15)
            info.add_child(t)

            var d: = Label.new()
            d.text = String(opt.get("description", ""))
            d.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
            d.add_theme_font_size_override("font_size", 12)
            d.modulate = Color(0.85, 0.85, 0.85)
            info.add_child(d)

            var roll_any: Variant = opt.get("roll", [])
            var roll_arr: Array = []
            if roll_any is Array:
                roll_arr = roll_any as Array
            var difficulty: int = int(opt.get("difficulty", 6))

            var roll_line: = Label.new()
            roll_line.text = _format_roll_string(roll_arr, difficulty)
            roll_line.add_theme_font_size_override("font_size", 12)
            roll_line.modulate = Color(0.9, 0.9, 0.9)
            info.add_child(roll_line)

            row.add_child(info)

            var btn: = Button.new()
            btn.custom_minimum_size = Vector2(36, 36)
            btn.theme = attribute_upgrade_button_theme
            btn.tooltip_text = "Attempt this defeat approach"
            btn.pressed.connect(_on_defeat_option_button_pressed.bind(hunt_type, scenario_id, int(opt.get("index", 0))))
            row.add_child(btn)

            container.add_child(row)


        _maybe_show_willpower_button_for_next_roll()
    else:

        _hide_willpower_button()


    _scroll_detail_to_top()

    print("✅ Hunt result rendered for %s/%s" % [hunt_type, scenario_id])



func _on_defeat_option_button_pressed(hunt_type: String, scenario_id: String, option_index: int) -> void :
    print("🩸 Defeat option selected:", hunt_type, scenario_id, "index:", option_index)
    if GameManager.character_data:
        NetworkManager.rpc(
            "request_defeat_choice", 
            GameManager.character_data.name, 
            hunt_type, 
            scenario_id, 
            option_index, 
            false, 
            false
        )



func show_defeat_result(hunt_type: String, scenario_id: String, result_payload: Dictionary) -> void :
    var container: VBoxContainer = $Panel / DetailScrollContainer / DetailVBoxContainer
    clear_children(container)


    _wp_armed = false
    _hide_willpower_button()


    var header: = VBoxContainer.new()
    header.size_flags_horizontal = Control.SIZE_EXPAND_FILL

    var name_label: = Label.new()
    name_label.text = String(result_payload.get("scenario_name", scenario_id))
    name_label.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
    name_label.add_theme_font_size_override("font_size", 18)
    header.add_child(name_label)

    var desc_label: = Label.new()
    desc_label.text = String(result_payload.get("description", ""))
    desc_label.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
    desc_label.add_theme_font_size_override("font_size", 13)
    desc_label.modulate = Color(0.8, 0.8, 0.8)
    header.add_child(desc_label)

    var spacer: = Control.new()
    spacer.custom_minimum_size = Vector2(0, 8)
    header.add_child(spacer)
    container.add_child(header)


    var outcome: = String(result_payload.get("outcome", "failure"))
    var outcome_label: = Label.new()
    match outcome:
        "success":
            outcome_label.text = "Defeat Result: SUCCESS"
            outcome_label.add_theme_color_override("font_color", Color(0.6, 1.0, 0.6))
        _:
            outcome_label.text = "Defeat Result: FAILURE"
            outcome_label.add_theme_color_override("font_color", Color(1.0, 0.7, 0.5))
    outcome_label.add_theme_font_size_override("font_size", 14)
    container.add_child(outcome_label)


    var narrative: = Label.new()
    narrative.text = String(result_payload.get("narrative", ""))
    narrative.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
    narrative.add_theme_font_size_override("font_size", 13)
    container.add_child(narrative)


    var roll_block: = VBoxContainer.new()
    roll_block.size_flags_horizontal = Control.SIZE_EXPAND_FILL
    var rr_any: Variant = result_payload.get("roll_result", {})
    var rr: Dictionary = {}
    if rr_any is Dictionary:
        rr = rr_any as Dictionary
    _add_roll_result_block(roll_block, rr)
    container.add_child(roll_block)


    if outcome == "success":
        _add_feed_choice_row(container, hunt_type, scenario_id)

    _scroll_detail_to_top()
    print("✅ Defeat result rendered for %s/%s" % [hunt_type, scenario_id])



func _add_feed_choice_row(parent: VBoxContainer, hunt_type: String, scenario_id: String) -> void :
    var spacer: = Control.new()
    spacer.custom_minimum_size = Vector2(0, 10)
    parent.add_child(spacer)

    var section: = Label.new()
    section.text = "Feeding intensity"
    section.add_theme_font_size_override("font_size", 14)
    section.add_theme_color_override("font_color", Color.SKY_BLUE)
    section.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
    parent.add_child(section)

    var row: = HBoxContainer.new()
    row.size_flags_horizontal = Control.SIZE_EXPAND_FILL
    row.alignment = BoxContainer.ALIGNMENT_CENTER
    row.add_theme_constant_override("separation", 12)

    var choices: = [
        {"label": "SAFE", "mode": "safe"}, 
        {"label": "RISK", "mode": "risk"}, 
        {"label": "GORGE", "mode": "gorge"}, 
    ]

    for c in choices:
        var btn: = Button.new()
        btn.text = String(c["label"])
        btn.custom_minimum_size = Vector2(96, 36)
        btn.size_flags_horizontal = Control.SIZE_SHRINK_CENTER
        btn.theme = attribute_upgrade_button_theme
        btn.tooltip_text = "Choose %s feeding" % [c["label"]]
        btn.pressed.connect(_on_feed_choice_button_pressed.bind(hunt_type, scenario_id, String(c["mode"])))
        row.add_child(btn)

    parent.add_child(row)


func _on_feed_choice_button_pressed(hunt_type: String, scenario_id: String, mode: String) -> void :
    print("🍷 Feed choice selected:", mode, "for", hunt_type, scenario_id)
    if GameManager.character_data:
        NetworkManager.rpc(
            "request_feed_choice", 
            GameManager.character_data.name, 
            hunt_type, 
            scenario_id, 
            mode
        )

func show_feed_result(payload: Dictionary) -> void :
    var container: VBoxContainer = $Panel / DetailScrollContainer / DetailVBoxContainer

    var sc: = $Panel / DetailScrollContainer
    if sc:
        sc.horizontal_scroll_mode = ScrollContainer.SCROLL_MODE_DISABLED

    clear_children(container)


    _wp_armed = false
    _hide_willpower_button()


    var header: = VBoxContainer.new()
    header.size_flags_horizontal = Control.SIZE_EXPAND_FILL

    var name_label: = Label.new()
    name_label.text = String(payload.get("scenario_name", String(payload.get("scenario_id", ""))))
    name_label.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
    name_label.size_flags_horizontal = Control.SIZE_EXPAND_FILL
    name_label.add_theme_font_size_override("font_size", 18)
    header.add_child(name_label)

    var desc_label: = Label.new()
    desc_label.text = String(payload.get("description", ""))
    desc_label.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
    desc_label.size_flags_horizontal = Control.SIZE_EXPAND_FILL
    desc_label.add_theme_font_size_override("font_size", 13)
    desc_label.modulate = Color(0.8, 0.8, 0.8)
    header.add_child(desc_label)

    var spacer: = Control.new()
    spacer.custom_minimum_size = Vector2(0, 8)
    header.add_child(spacer)
    container.add_child(header)


    var summary: = Label.new()
    summary.text = String(payload.get("message", ""))
    summary.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
    summary.size_flags_horizontal = Control.SIZE_EXPAND_FILL
    summary.add_theme_font_size_override("font_size", 14)
    container.add_child(summary)


    var before: int = int(payload.get("blood_before", 0))
    var gained: int = int(payload.get("blood_gained", 0))
    var after: int = int(payload.get("blood_after", 0))
    var bmax: int = int(payload.get("blood_max", 0))

    var blood_line: = Label.new()
    blood_line.text = "Blood gained: %d   (Pool: %d → %d / %d)" % [gained, before, after, bmax]
    blood_line.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
    blood_line.size_flags_horizontal = Control.SIZE_EXPAND_FILL
    blood_line.add_theme_font_size_override("font_size", 12)
    blood_line.modulate = Color(0.9, 0.9, 0.9)
    container.add_child(blood_line)


    var victim_died: bool = bool(payload.get("victim_died", false))
    var victim_line: = Label.new()
    if victim_died:
        victim_line.text = "Victim: Dies"
        victim_line.add_theme_color_override("font_color", Color(1.0, 0.6, 0.6))
    else:
        victim_line.text = "Victim: Survives"
        victim_line.add_theme_color_override("font_color", Color(0.7, 1.0, 0.7))
    victim_line.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
    victim_line.size_flags_horizontal = Control.SIZE_EXPAND_FILL
    victim_line.add_theme_font_size_override("font_size", 12)
    container.add_child(victim_line)

    _add_conscience_result(container, payload)
    _update_top_blood_labels(after, bmax)

    _scroll_detail_to_top()
    print("✅ Feed result rendered.")



func _update_top_blood_labels(current: int, maxv: int) -> void :
    var bp_cur: = $Panel / CharacterInformationPanel / CharacterInformationContainer / BloodContainer / BloodCurrent
    var bp_max: = $Panel / CharacterInformationPanel / CharacterInformationContainer / BloodContainer / BloodMax
    if bp_cur and bp_max:
        bp_cur.text = str(current)
        bp_max.text = str(maxv)

func _add_conscience_result(parent: VBoxContainer, payload: Dictionary) -> void :
    var trig: = String(payload.get("conscience_trigger", ""))
    if trig == "":
        return


    var section: = Label.new()
    section.text = "Conscience (Humanity) Check"
    section.add_theme_font_size_override("font_size", 14)
    section.add_theme_color_override("font_color", Color.SKY_BLUE)
    parent.add_child(section)


    var reason_text: = ""
    match trig:
        "gorge":
            reason_text = "Triggered by: Gorge"
        "risk_death":
            reason_text = "Triggered by: Risk (victim died)"
        "frenzy_death":
            reason_text = "Triggered by: Frenzy (victim died)"
        _:
            reason_text = "Triggered by: " + trig.capitalize()

    var reason: = Label.new()
    reason.text = reason_text
    reason.add_theme_font_size_override("font_size", 12)
    reason.modulate = Color(0.9, 0.9, 0.9)
    parent.add_child(reason)


    var c_any: Variant = payload.get("conscience_check", {})
    var c: Dictionary = {}
    if c_any is Dictionary:
        c = c_any as Dictionary

    var pool: = int(c.get("pool_used", 0))
    var diff: = int(c.get("difficulty", 8))

    var rolls_any: Variant = c.get("rolls", [])
    var rolls_arr: Array = []
    if rolls_any is Array:
        rolls_arr = rolls_any as Array

    var net: = int(c.get("net_successes", 0))
    var passed: = bool(c.get("passed", false))

    var line: = Label.new()
    line.text = "Pool %d vs Difficulty %d  •  Rolls %s  •  Net %d" % [pool, diff, str(rolls_arr), net]
    line.add_theme_font_size_override("font_size", 12)
    line.modulate = Color(0.9, 0.9, 0.9)
    parent.add_child(line)

    var verdict: = Label.new()
    verdict.text = "Result: " + ("PASSED" if passed else "FAILED")
    verdict.add_theme_font_size_override("font_size", 13)
    if passed:
        verdict.add_theme_color_override("font_color", Color(0.6, 1.0, 0.6))
    else:
        verdict.add_theme_color_override("font_color", Color(1.0, 0.6, 0.6))
    parent.add_child(verdict)

    var spacer: = Control.new()
    spacer.custom_minimum_size = Vector2(0, 6)
    parent.add_child(spacer)

func _hide_willpower_button() -> void :
    var cont: Control = $Panel / WillpowerButtonDetailContainer as Control
    if cont:
        cont.visible = false









func _scroll_detail_to_top() -> void :
    var sc: = $Panel / DetailScrollContainer
    if sc and sc is ScrollContainer:

        await get_tree().process_frame
        (sc as ScrollContainer).scroll_vertical = 0
        (sc as ScrollContainer).scroll_horizontal = 0


func apply_saved_position() -> void :
    if position_saved:
        $Panel.global_position = saved_position
    else:
        var viewport_size: = get_viewport_rect().size
        $Panel.global_position = (viewport_size - $Panel.size) / 2

func remember_position() -> void :
    saved_position = $Panel.global_position
    position_saved = true


var _wp_armed: bool = false

func _maybe_show_willpower_button_for_next_roll() -> void :
    var btn: Button = $Panel / WillpowerButtonDetailContainer as Button
    if btn == null:
        return

    var cd = GameManager.character_data

    if cd == null or int(cd.willpower_current) <= 0 or _wp_armed:
        btn.visible = false
        return

    btn.disabled = false
    btn.visible = true


func _on_Panel2_visibility_changed() -> void :
    if $Panel2.visible:
        if GameManager.character_data:
            NetworkManager.rpc("request_NA_CharacterSummary", GameManager.character_data.name)


func populate_character_summary_from_server(data: Dictionary) -> void :
    var container: VBoxContainer = $Panel2 / ScrollContainer / VBoxContainer
    clear_children(container)

    if data.is_empty():
        var none: = Label.new()
        none.text = "No character data available."
        container.add_child(none)
        return


    var status_header: = Label.new()
    status_header.text = "Status"
    status_header.add_theme_color_override("font_color", Color.SKY_BLUE)
    status_header.add_theme_font_size_override("font_size", 14)
    container.add_child(status_header)

    var blush: = Label.new()
    blush.text = "Blush of Life: " + ("Active" if bool(data.get("blush_of_life", false)) else "Inactive")
    container.add_child(blush)

    var health_levels: Array = data.get("health_levels", [])
    var health_index: int = int(data.get("health_index", -1))
    var health_level: = "Unknown"
    if health_levels is Array and health_index >= 0 and health_index < health_levels.size():
        health_level = String(health_levels[health_index])
    var health: = Label.new()
    health.text = "Health: " + health_level
    container.add_child(health)


    var attr_header: = Label.new()
    attr_header.text = "Attributes"
    attr_header.add_theme_color_override("font_color", Color.SKY_BLUE)
    attr_header.add_theme_font_size_override("font_size", 14)
    container.add_child(attr_header)

    var attributes: = {
        "Physical": [
            ["Strength", int(data.get("strength", 0))], 
            ["Dexterity", int(data.get("dexterity", 0))], 
            ["Stamina", int(data.get("stamina", 0))]
        ], 
        "Social": [
            ["Charisma", int(data.get("charisma", 0))], 
            ["Manipulation", int(data.get("manipulation", 0))], 
            ["Appearance", int(data.get("appearance", 0))]
        ], 
        "Mental": [
            ["Perception", int(data.get("perception", 0))], 
            ["Intelligence", int(data.get("intelligence", 0))], 
            ["Wits", int(data.get("wits", 0))]
        ]
    }

    for cat in attributes.keys():
        var cat_label: = Label.new()
        cat_label.text = cat
        cat_label.add_theme_color_override("font_color", Color(0.85, 0.85, 0.85))
        container.add_child(cat_label)
        for pair in attributes[cat]:
            var row: = Label.new()
            row.text = "%s: %d" % [pair[0], pair[1]]
            container.add_child(row)


    var ability_sets: = {
        "Talents": [
            ["Alertness", int(data.get("alertness", 0))], 
            ["Athletics", int(data.get("athletics", 0))], 
            ["Awareness", int(data.get("awareness", 0))], 
            ["Brawl", int(data.get("brawl", 0))], 
            ["Empathy", int(data.get("empathy", 0))], 
            ["Expression", int(data.get("expression", 0))], 
            ["Intimidation", int(data.get("intimidation", 0))], 
            ["Leadership", int(data.get("leadership", 0))], 
            ["Streetwise", int(data.get("streetwise", 0))], 
            ["Subterfuge", int(data.get("subterfuge", 0))]
        ], 
        "Skills": [
            ["Animal Ken", int(data.get("animal_ken", 0))], 
            ["Crafts", int(data.get("crafts", 0))], 
            ["Drive", int(data.get("drive", 0))], 
            ["Etiquette", int(data.get("etiquette", 0))], 
            ["Firearms", int(data.get("firearms", 0))], 
            ["Larceny", int(data.get("larceny", 0))], 
            ["Melee", int(data.get("melee", 0))], 
            ["Performance", int(data.get("performance", 0))], 
            ["Stealth", int(data.get("stealth", 0))], 
            ["Survival", int(data.get("survival", 0))]
        ], 
        "Knowledges": [
            ["Academics", int(data.get("academics", 0))], 
            ["Computer", int(data.get("computer", 0))], 
            ["Finance", int(data.get("finance", 0))], 
            ["Investigation", int(data.get("investigation", 0))], 
            ["Law", int(data.get("law", 0))], 
            ["Medicine", int(data.get("medicine", 0))], 
            ["Occult", int(data.get("occult", 0))], 
            ["Politics", int(data.get("politics", 0))], 
            ["Science", int(data.get("science", 0))], 
            ["Technology", int(data.get("technology", 0))]
        ]
    }

    for cat in ability_sets.keys():
        var cat_header: = Label.new()
        cat_header.text = cat
        cat_header.add_theme_color_override("font_color", Color.SKY_BLUE)
        cat_header.add_theme_font_size_override("font_size", 14)
        container.add_child(cat_header)
        for pair in ability_sets[cat]:
            var row: = Label.new()
            row.text = "%s: %d" % [pair[0], pair[1]]
            container.add_child(row)

func populate_virtue_upgrade_panel(data: Dictionary) -> void :
    var container: = $Panel / DetailScrollContainer / DetailVBoxContainer
    clear_children(container)
    _add_header_row(container)


    var pn: = str(data.get("path_name", "")).strip_edges().to_lower()
    var on_path: = (pn != "" and pn != "humanity")


    var conv: = int(data.get("conviction", 0))
    var inst: = int(data.get("instinct", 0))
    var sc: = int(data.get("self_control", 0))


    var morality_key: = ""
    if on_path or conv > 0:
        morality_key = "conviction"
    else:
        morality_key = "conscience"


    var control_key: = ""
    if inst > 0 and sc > 0:
        control_key = "instinct" if on_path else "self_control"
    elif inst > 0:
        control_key = "instinct"
    elif sc > 0:
        control_key = "self_control"
    else:
        control_key = "instinct" if on_path else "self_control"


    for k in [morality_key, control_key, "courage"]:
        container.add_child(_create_ability_row(k, data))


    container.add_child(_create_ability_row("path", data))


    container.add_child(_create_ability_row("willpower_max", data))

    _scroll_detail_to_top()


func _on_WillpowerButton_pressed() -> void :

    var cont: Control = $Panel / WillpowerButtonDetailContainer as Control
    if cont:
        cont.visible = false


    _wp_armed = true


    if GameManager.character_data:
        NetworkManager.rpc("request_arm_willpower_for_next_roll", GameManager.character_data.name)




func _on_herd_feed_result(res: Dictionary) -> void :
    var after: int = int(res.get("blood_after", -1))
    var maxv: int = int(res.get("blood_max", 0))
    if after >= 0:
        _update_top_blood_labels(after, maxv)





func _on_DisciplineIncreaseButton_pressed() -> void :

    var container: VBoxContainer = $Panel / DetailScrollContainer / DetailVBoxContainer
    clear_children(container)
    _wp_armed = false
    _hide_willpower_button()


    if GameManager.character_data:
        NetworkManager.rpc("request_discipline_upgrade_data", GameManager.character_data.name)


func populate_discipline_upgrade_panel(data: Dictionary) -> void :
    _last_discipline_payload = data.duplicate(true)
    var container: VBoxContainer = $Panel / DetailScrollContainer / DetailVBoxContainer
    clear_children(container)


    var primary: Array[Dictionary] = _as_dict_array(data.get("primary", []))
    var out_common: Array[Dictionary] = _as_dict_array(data.get("out_common", []))
    var out_clan: Array[Dictionary] = _as_dict_array(data.get("out_clan", []))
    var sorcery: Array[Dictionary] = _as_dict_array(data.get("sorcery", []))


    if primary.size() > 0:
        _add_section_header(container, "Primary Disciplines")
        _add_header_row(container)
        for e in primary:
            var row: HBoxContainer = _create_ability_row_discipline(
                String(e.get("name", "")), 
                int(e.get("rating", 0)), 
                int(e.get("progress", 0))
            )
            var btn: = row.get_child(row.get_child_count() - 1)
            if btn is Button:
                (btn as Button).tooltip_text = "Primary — normal progression"
            container.add_child(row)


    if out_common.size() > 0:
        _add_section_header(container, "Out-of-Clan — Common")
        _add_header_row(container)
        for e in out_common:
            var row_oc: HBoxContainer = _create_ability_row_discipline(
                String(e.get("name", "")), 
                int(e.get("rating", 0)), 
                int(e.get("progress", 0))
            )
            var btn_oc: = row_oc.get_child(row_oc.get_child_count() - 1)
            if btn_oc is Button:
                (btn_oc as Button).tooltip_text = "Out-of-Clan (Common) — 1.5× slower"
            container.add_child(row_oc)


    if out_clan.size() > 0:
        _add_section_header(container, "Out-of-Clan — Clan")
        _add_header_row(container)
        for e in out_clan:
            var row_cc: HBoxContainer = _create_ability_row_discipline(
                String(e.get("name", "")), 
                int(e.get("rating", 0)), 
                int(e.get("progress", 0))
            )
            var btn_cc: = row_cc.get_child(row_cc.get_child_count() - 1)
            if btn_cc is Button:
                (btn_cc as Button).tooltip_text = "Out-of-Clan (Clan) — 2× slower"
            container.add_child(row_cc)


    if sorcery.size() > 0:
        _add_section_header(container, "Sorcery")
        _add_header_row(container)
        for e in sorcery:
            var row_s: HBoxContainer = _create_ability_row_discipline(
                String(e.get("name", "")), 
                int(e.get("rating", 0)), 
                int(e.get("progress", 0))
            )
            var btn_s: = row_s.get_child(row_s.get_child_count() - 1)
            if btn_s is Button:
                (btn_s as Button).tooltip_text = "Sorcery (not primary) — 2.5× slower"
            container.add_child(row_s)


    _add_thaum_paths_section(container, data.get("thaum_paths", []))

    _add_necromancy_paths_section(container, data.get("necro_paths", []))

    _scroll_detail_to_top()

func receive_thaumaturgy_paths_data(paths_payload: Array) -> void :
    if _last_discipline_payload.is_empty():
        return
    _last_discipline_payload["thaum_paths"] = paths_payload
    populate_discipline_upgrade_panel(_last_discipline_payload)

func receive_necromancy_paths_data(paths_payload: Array) -> void :
    if _last_discipline_payload.is_empty():
        return
    _last_discipline_payload["necro_paths"] = paths_payload
    populate_discipline_upgrade_panel(_last_discipline_payload)






func _add_section_header(container: VBoxContainer, title: String) -> void :
    var header: = Label.new()
    header.text = title
    header.add_theme_font_size_override("font_size", 14)
    header.add_theme_color_override("font_color", Color.SKY_BLUE)
    container.add_child(header)

func _as_dict_array(v: Variant) -> Array[Dictionary]:
    var out: Array[Dictionary] = []
    if v is Array:
        for item in (v as Array):
            if item is Dictionary:
                out.append(item as Dictionary)
    return out


func _append_discipline_rows(container: VBoxContainer, entries: Array[Dictionary], tooltip: String, seen_lc: Dictionary) -> void :
    for e in entries:
        var nm: = String(e.get("name", "")).strip_edges()
        if nm == "":
            continue
        var key: = nm.to_lower()
        if seen_lc.has(key):
            continue
        var row: HBoxContainer = _create_ability_row_discipline(
            nm, 
            int(e.get("rating", 0)), 
            int(e.get("progress", 0))
        )
        var btn: = row.get_child(row.get_child_count() - 1)
        if btn is Button:
            (btn as Button).tooltip_text = tooltip
        container.add_child(row)
        seen_lc[key] = true



func _add_thaum_paths_section(container: VBoxContainer, paths_any: Variant) -> void :
    if paths_any == null:
        return
    var paths: Array[Dictionary] = []
    if paths_any is Array:
        for v in (paths_any as Array):
            if v is Dictionary:
                paths.append(v as Dictionary)
    if paths.is_empty():
        return

    _add_section_header(container, "Thaumaturgy Paths")
    _add_header_row(container)

    var ap_available: = false
    if GameManager.character_data:
        ap_available = int(GameManager.character_data.action_points_current) > 0

    for p in paths:
        var path_name: = String(p.get("name", ""))
        var rating: = int(p.get("rating", 0))
        var prog: = int(p.get("progress", 0))
        var is_primary: = bool(p.get("primary", false))
        container.add_child(_create_thaum_path_row(path_name, rating, prog, ap_available, is_primary))


func _add_necromancy_paths_section(container: VBoxContainer, paths_any: Variant) -> void :
    if paths_any == null:
        return
    var paths: Array[Dictionary] = []
    if paths_any is Array:
        for v in (paths_any as Array):
            if v is Dictionary:
                paths.append(v as Dictionary)
    if paths.is_empty():
        return

    _add_section_header(container, "Necromancy Paths")
    _add_header_row(container)

    var ap_available: = false
    if GameManager.character_data:
        ap_available = int(GameManager.character_data.action_points_current) > 0

    for p in paths:
        var path_name: = String(p.get("name", ""))
        var rating: = int(p.get("rating", 0))
        var prog: = int(p.get("progress", 0))
        var is_primary: = bool(p.get("primary", false))
        container.add_child(_create_necromancy_path_row(path_name, rating, prog, ap_available, is_primary))


func _create_thaum_path_row(path_name: String, rating: int, progress_raw: int, ap_available: bool, is_primary: bool) -> HBoxContainer:
    var hbox: = HBoxContainer.new()
    hbox.size_flags_horizontal = Control.SIZE_EXPAND_FILL

    var name_label: = Label.new()
    name_label.text = path_name
    name_label.size_flags_horizontal = Control.SIZE_EXPAND_FILL
    name_label.custom_minimum_size = Vector2(160, 0)
    name_label.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
    if is_primary:
        name_label.add_theme_color_override("font_color", Color(0.85, 1.0, 0.95))
    hbox.add_child(name_label)

    var value_label: = Label.new()
    value_label.text = str(rating)
    value_label.size_flags_horizontal = Control.SIZE_EXPAND_FILL
    value_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
    value_label.custom_minimum_size = Vector2(40, 0)
    hbox.add_child(value_label)

    var progress_label: = Label.new()
    progress_label.text = str("%.1f" % (float(progress_raw) / 100.0)) + "%"
    progress_label.size_flags_horizontal = Control.SIZE_EXPAND_FILL
    progress_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
    progress_label.custom_minimum_size = Vector2(40, 0)
    hbox.add_child(progress_label)

    var button: = Button.new()
    button.text = "+"
    button.custom_minimum_size = Vector2(40, 0)
    button.size_flags_horizontal = Control.SIZE_EXPAND_FILL
    button.theme = attribute_upgrade_button_theme
    button.disabled = ( not ap_available) or (rating >= 5)
    if rating >= 5:
        button.tooltip_text = "Path is at maximum (5)."
    elif not ap_available:
        button.tooltip_text = "Not enough Activity Points."
    else:
        button.tooltip_text = "Study this path (costs 1 AP)."

    button.pressed.connect( func():
        if GameManager.character_data:
            _wp_armed = false
            _hide_willpower_button()
            NetworkManager.rpc("request_thaum_path_progress", GameManager.character_data.name, path_name)
    )

    hbox.add_child(button)
    return hbox


func _create_necromancy_path_row(path_name: String, rating: int, progress_raw: int, ap_available: bool, is_primary: bool) -> HBoxContainer:
    var hbox: = HBoxContainer.new()
    hbox.size_flags_horizontal = Control.SIZE_EXPAND_FILL

    var name_label: = Label.new()
    name_label.text = path_name
    name_label.size_flags_horizontal = Control.SIZE_EXPAND_FILL
    name_label.custom_minimum_size = Vector2(160, 0)
    name_label.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
    if is_primary:
        name_label.add_theme_color_override("font_color", Color(0.85, 1.0, 0.95))
    hbox.add_child(name_label)

    var value_label: = Label.new()
    value_label.text = str(rating)
    value_label.size_flags_horizontal = Control.SIZE_EXPAND_FILL
    value_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
    value_label.custom_minimum_size = Vector2(40, 0)
    hbox.add_child(value_label)

    var progress_label: = Label.new()
    progress_label.text = str("%.1f" % (float(progress_raw) / 100.0)) + "%"
    progress_label.size_flags_horizontal = Control.SIZE_EXPAND_FILL
    progress_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
    progress_label.custom_minimum_size = Vector2(40, 0)
    hbox.add_child(progress_label)

    var button: = Button.new()
    button.text = "+"
    button.custom_minimum_size = Vector2(40, 0)
    button.size_flags_horizontal = Control.SIZE_EXPAND_FILL
    button.theme = attribute_upgrade_button_theme
    button.disabled = ( not ap_available) or (rating >= 5)
    if rating >= 5:
        button.tooltip_text = "Path is at maximum (5)."
    elif not ap_available:
        button.tooltip_text = "Not enough Activity Points."
    else:
        button.tooltip_text = "Study this path (costs 1 AP)."

    button.pressed.connect( func():
        if GameManager.character_data:
            _wp_armed = false
            _hide_willpower_button()
            NetworkManager.rpc("request_necromancy_path_progress", GameManager.character_data.name, path_name)
    )

    hbox.add_child(button)
    return hbox





func _on_NAU_visibility_changed_status() -> void :
    if not GameManager.character_data:
        return
    var me: = String(GameManager.character_data.name)
    NetworkManager.rpc("request_notify_na_panel_open", me, self.visible)

    if self.visible:
        NetworkManager.rpc("request_group_presence", me)

func _on_group_summary_received(group_name: String, members: Array[String], founder: String) -> void :
    var container: VBoxContainer = group_vbox
    clear_children(container)
    _member_status_labels.clear()
    _member_state.clear()


    var BOX_W: = 296.0
    var SEP: = 8.0
    var STATUS_COL_W: = 48.0
    var NAME_COL_W: = BOX_W - (2.0 * STATUS_COL_W) - (2.0 * SEP)

    if group_name.strip_edges() == "" or members.is_empty():
        var none: = Label.new()
        none.text = "Not in a group."
        container.add_child(none)
        return

    var title: = Label.new()
    title.text = "Group: " + group_name
    title.add_theme_font_size_override("font_size", 14)
    title.add_theme_color_override("font_color", Color.SKY_BLUE)
    container.add_child(title)


    var header: = HBoxContainer.new()
    header.size_flags_horizontal = Control.SIZE_SHRINK_CENTER
    header.add_theme_constant_override("separation", int(SEP))

    var h_name: = Label.new()
    h_name.text = "Member"
    h_name.custom_minimum_size = Vector2(NAME_COL_W, 0)
    h_name.size_flags_horizontal = Control.SIZE_SHRINK_CENTER
    header.add_child(h_name)

    var h_zone: = Label.new()
    h_zone.text = "Zone"
    h_zone.custom_minimum_size = Vector2(STATUS_COL_W, 0)
    h_zone.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
    h_zone.size_flags_horizontal = Control.SIZE_SHRINK_CENTER
    header.add_child(h_zone)

    var h_ui: = Label.new()
    h_ui.text = "Panel"
    h_ui.custom_minimum_size = Vector2(STATUS_COL_W, 0)
    h_ui.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
    h_ui.size_flags_horizontal = Control.SIZE_SHRINK_CENTER
    header.add_child(h_ui)

    container.add_child(header)


    for member_name in members:
        var row: = HBoxContainer.new()
        row.size_flags_horizontal = Control.SIZE_SHRINK_CENTER
        row.add_theme_constant_override("separation", int(SEP))

        var name_lbl: = Label.new()
        var suffix: = ""
        if String(member_name) == String(founder):
            suffix = " (Host)"
        name_lbl.text = String(member_name) + suffix
        name_lbl.custom_minimum_size = Vector2(NAME_COL_W, 0)
        name_lbl.clip_text = true
        name_lbl.size_flags_horizontal = Control.SIZE_SHRINK_CENTER
        row.add_child(name_lbl)

        var zone_lbl: = Label.new()
        zone_lbl.text = "?"
        zone_lbl.custom_minimum_size = Vector2(STATUS_COL_W, 0)
        zone_lbl.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
        zone_lbl.size_flags_horizontal = Control.SIZE_SHRINK_CENTER
        row.add_child(zone_lbl)

        var ui_lbl: = Label.new()
        ui_lbl.text = "?"
        ui_lbl.custom_minimum_size = Vector2(STATUS_COL_W, 0)
        ui_lbl.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
        ui_lbl.size_flags_horizontal = Control.SIZE_SHRINK_CENTER
        row.add_child(ui_lbl)

        container.add_child(row)

        _member_status_labels[String(member_name)] = {"zone": zone_lbl, "ui": ui_lbl}
        _member_state[String(member_name)] = {"same_zone": false, "na_open": false}


    if GameManager.character_data:
        NetworkManager.rpc("request_group_presence", String(GameManager.character_data.name))

func _on_group_presence_received(entries: Array) -> void :
    for e in entries:
        if not (e is Dictionary):
            continue
        var member_name: = String(e.get("name", ""))
        if member_name == "":
            continue
        var same_zone: = bool(e.get("same_zone", false))
        var na_open: = bool(e.get("na_open", false))
        _member_state[member_name] = {"same_zone": same_zone, "na_open": na_open}
        _update_member_status_labels(member_name)

func _on_member_na_panel_status(member_name: String, opened: bool) -> void :
    if not _member_state.has(member_name):
        _member_state[member_name] = {"same_zone": false, "na_open": opened}
    else:
        _member_state[member_name]["na_open"] = opened
    _update_member_status_labels(member_name)

func _update_member_status_labels(member_name: String) -> void :
    if not _member_status_labels.has(member_name):
        return

    var labels: Dictionary = _member_status_labels[member_name]
    var state: Dictionary = _member_state.get(member_name, {})

    var zone_lbl: = labels.get("zone", null) as Label
    var ui_lbl: = labels.get("ui", null) as Label

    if zone_lbl:
        var sz: = bool(state.get("same_zone", false))
        zone_lbl.text = "✓"
        if not sz:
            zone_lbl.text = "✗"
        var zcol: Color = Color(0.7, 1.0, 0.7)
        if not sz:
            zcol = Color(0.8, 0.8, 0.8)
        zone_lbl.add_theme_color_override("font_color", zcol)

    if ui_lbl:
        var is_open: = bool(state.get("na_open", false))
        ui_lbl.text = "✓"
        if not is_open:
            ui_lbl.text = "✗"
        var ucol: Color = Color(0.7, 1.0, 0.7)
        if not is_open:
            ucol = Color(0.8, 0.8, 0.8)
        ui_lbl.add_theme_color_override("font_color", ucol)

func _find_player_selection() -> Node:
    var n: Node = get_node_or_null("PlayerSelection")
    if n != null:
        return n
    var parent: Node = get_parent()
    if parent != null:
        var n2: Node = parent.get_node_or_null("PlayerSelection")
        if n2 != null:
            return n2
    return null


func _on_DisciplineTeachButton_pressed() -> void :
    var ps: Node = _find_player_selection()
    if ps == null:
        push_error("PlayerSelection not found under NightlyActivitiesUI or its parent.")
        return

    var cd: CharacterData = GameManager.character_data
    if cd == null:
        return



    ps.call("enter_state", "MentorSelectStudent", cd, null)

func _on_MentorAStudentButton_pressed() -> void :
    var ps: Node = _find_player_selection()
    if ps == null:
        push_error("PlayerSelection not found under NightlyActivitiesUI or its parent.")
        return

    var cd: CharacterData = GameManager.character_data
    if cd == null:
        return

    ps.call("enter_state", "MentorTeachSelectStudent", cd, null)

func _on_mentor_subject_selected(student_name: String, subject: String) -> void :
    var ps: Node = _find_player_selection()
    if ps == null:
        push_error("PlayerSelection not found under NightlyActivitiesUI or its parent.")
        return

    var cd: CharacterData = GameManager.character_data
    if cd == null:
        return

    ps.call("enter_state", "MentorTeachSelectTopic", cd, {"student": student_name, "subject": subject})
