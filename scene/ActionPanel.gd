extends Control

@onready var tab_container = $TabContainer
@onready var buttons_container = $ButtonsContainer
@onready var display_text = $"../TextPanel/DisplayText"

const CHAT_DIVIDER: = "[color=gray]────────────────────[/color]\n"

var character_data

func _ready():
    buttons_container.custom_minimum_size = Vector2(300, 200)
    tab_container.tab_changed.connect(_on_tab_changed)
    tab_container.current_tab = 0
    _on_tab_changed(tab_container.current_tab)


    if display_text is RichTextLabel:
        display_text.bbcode_enabled = true


    if not NetworkManager.is_connected("zone_character_list_received", Callable(self, "_on_zone_character_list_received")):
        NetworkManager.connect("zone_character_list_received", Callable(self, "_on_zone_character_list_received"))

    if not NetworkManager.is_connected("zone_name_received", Callable(self, "_on_zone_name_received")):
        NetworkManager.connect("zone_name_received", Callable(self, "_on_zone_name_received"))

    if not NetworkManager.is_connected("zone_description_received", Callable(self, "_on_zone_description_received")):
        NetworkManager.connect("zone_description_received", Callable(self, "_on_zone_description_received"))
    
    if not NetworkManager.is_connected("zone_info_received", Callable(self, "_on_zone_info_received")):
        NetworkManager.connect("zone_info_received", Callable(self, "_on_zone_info_received"))

func set_character_data(data):
    character_data = data

func _on_tab_changed(tab_index: int) -> void :
    for child in buttons_container.get_children():
        child.queue_free()

    match tab_index:
        0:
            _add_button("Move")
            _add_button("Secret Move")
            _add_button("Temporary Zone")
            _add_button("Where?")
            _add_button("Who?")
            _add_button("View Character")
            _add_button("Description")
            _add_button("Viewpoint")
        1:
            _add_button("Nightly Activities")
            _add_button("Dice Roller")
            _add_button("Dice Roller Custom")
            _add_button("Group")
        2:
            _add_button("Write Description")
            _add_button("Character Sheet")
            _add_button("Inventory")
            _add_button("Notes")
            _add_button("Date")
        3:
            _add_button("Lose One Blood")
            _add_button("Give Blood")
            _add_button("Vaulderie")
            _add_button("Blood Bond")
            _add_button("Blush of Life")
            _add_button("Heal")
            _add_button("Physical Attributes")
        4:
            _add_button("Sounds")
            _add_button("Settings")
            _add_button("Image")
            _add_button("See Self-Image")
            _add_button("Save")
        5:
            _add_button("Create Character" )
            _add_button("Possess" )
            _add_button("Release" )
            _add_button("Delete" )
            _add_button("Teleport" )
            _add_button("Teleport to Character" )
            _add_button("Summon Character" )
            _add_button("Test Path" )
            _add_button("Test Frenzy" )
            _add_button("Test Rötschreck" )
            _add_button("Edit Character" )
            _add_button("Describe" )
            _add_button("Post Order" )
            _add_button("Damage" )
            _add_button("Grant AP")
        _:
            pass

func _add_button(text: String) -> void :
    var button = Button.new()
    button.text = text
    button.custom_minimum_size = Vector2(150, 30)
    button.pressed.connect( func(): _on_button_pressed(text))
    buttons_container.add_child(button)

func _on_button_pressed(action: String) -> void :
    print("Button pressed:", action)

    match action:
        "Move":
            var location_selection = get_parent().get_node("LocationSelection")
            location_selection.enter(character_data)
        "Viewpoint":
            var location_selection = get_parent().get_node("LocationSelection")
            location_selection.enter(character_data, "viewpoint")
        "Where?":
            NetworkManager.rpc("request_zone_name", character_data.name)
        "Who?":
            NetworkManager.rpc("request_zone_character_list", character_data.name)
        "Description":
            NetworkManager.rpc("request_zone_description", character_data.name)
        "Dice Roller":
            var dice_roller = get_parent().get_node("DiceRollerUI")
            dice_roller.enter_state("roll", character_data)
        "Dice Roller Custom":
            var dice_roller = get_parent().get_node("DiceRollerUI")
            dice_roller.enter_state("custom", character_data)
        "Character Sheet":
            var sheet_ui = get_parent().get_node("CharacterSheetUI")
            sheet_ui.load_character(character_data.name)

        "Secret Move":
            var words_input = get_parent().get_node("WordsInputPanel")
            words_input.enter_state("secret_move", character_data)
        "Save":
            if not character_data:
                _append_to_display("\n❌ No character data to save.")
                return
            if character_data.character_password == "":
                _append_to_display("\n Please enter a password for your character.")
                var words_input = get_node("/root/MainUI/WordsInputPanel")
                words_input.enter_state("set_password", character_data)
            else:

                var minimal_dict: = {"name": character_data.name}
                NetworkManager.rpc("request_save_character", minimal_dict)
                _append_to_display("\n Your character has been saved.")
        "Write Description":
            var words_input = get_parent().get_node("WordsInputPanel")
            words_input.enter_state("write_description", character_data)
        "View Character":
            var player_selection = get_parent().get_node("PlayerSelection")
            player_selection.enter_state("view_description", character_data)
        "Temporary Zone":
            if not character_data:
                _append_to_display("\n No character data.")
                return
            # Richiedi info zona dal server
            pending_zone_action = "Temporary Zone"
            NetworkManager.rpc("request_zone_info", character_data.name, character_data.current_zone)
        "Notes":
            var words_input = get_parent().get_node("WordsInputPanel")
            words_input.enter_state("write_notes", character_data)
        "Sounds":
            var sound_ui = get_parent().get_node_or_null("AudioSettingsUI")
            if sound_ui:
                sound_ui.visible = true
            else:
                print("⚠️ AudioSettingsUI not found.")
        "Host Vaulderie":
            if not character_data:
                _append_to_display("\nNo character loaded.")
                return
            if character_data.rituals < 1:
                _append_to_display("\nYou do not know the Ritual of Vaulderie.")
                return
            var vaulderie_panel = get_parent().get_node("VaulderiePanel")
            if vaulderie_panel:
                vaulderie_panel.visible = true
        "Participate Vaulderie":
            if not character_data:
                _append_to_display("\n❌ No character loaded.")
                return
            NetworkManager.rpc("request_open_vaulderie_participant", character_data.name, character_data.current_zone)
        "View Vinculum":
            var vinculum_menu = get_parent().get_node_or_null("VinculumMenu")
            if vinculum_menu:
                vinculum_menu.visible = true
                NetworkManager.rpc("request_vinculum_data", character_data.name)
            else:
                _append_to_display("\n❌ Vinculum Menu not found.")
        "Settings":
            var settings_panel = get_parent().get_node_or_null("Settings")
            if settings_panel:
                settings_panel.visible = true
            else:
                print("❌ Settings not found.")
        "Image":
            var file_selector = get_parent().get_node_or_null("FileSelector")
            if file_selector:
                file_selector.show()
                file_selector.open_selector()
            else:
                print("❌ FileSelector not found.")
        "See Self-Image":
            if not character_data:
                _append_to_display("\n❌ No character loaded.")
                return
            NetworkManager.rpc("request_self_image_preview", character_data.name)
        "Vaulderie":
            var menu = get_parent().get_node_or_null("VaulderieGroupingMenu")
            if menu:
                menu.visible = true
            else:
                _append_to_display("\n❌ Vaulderie menu not found.")
        "Group":
            var group_menu = get_parent().get_node_or_null("GroupMenu")
            if group_menu:
                group_menu.visible = true
            else:
                _append_to_display("\n❌ Group Menu not found.")
        "Date":
            if not character_data:
                _append_to_display("\n❌ No character loaded.")
                return
            NetworkManager.rpc("request_current_ic_time", character_data.name)
        "Nightly Activities":
            if not character_data:
                _append_to_display("\n❌ No character loaded.")
                return
            # Richiedi info zona dal server
            pending_zone_action = "Nightly Activities"
            NetworkManager.rpc("request_zone_info", character_data.name, character_data.current_zone)
        "Lose One Blood":
            if character_data == null:
                _append_to_display("\n❌ No character loaded.")
            else:
                NetworkManager.rpc("request_lose_one_blood", character_data.name)
        "Blood Bond":
            if not character_data:
                _append_to_display("\n❌ No character loaded.")
                return
            var menu = get_parent().get_node_or_null("BloodBondMenu")
            if menu == null:
                menu = get_parent().get_node_or_null("bloodbondUI")
            if menu:
                menu.visible = true
                NetworkManager.rpc("request_blood_bond_data", character_data.name)
            else:
                _append_to_display("\n❌ Blood Bond UI not found.")
        "Give Blood":
            if not character_data:
                _append_to_display("\n❌ No character loaded.")
                return
            var player_selection = get_parent().get_node("PlayerSelection")
            player_selection.enter_state("GiveBloodSelectTarget", character_data)
        "Blush of Life":
            if not character_data:
                _append_to_display("\n❌ No character loaded.")
                return
            NetworkManager.rpc("request_blush_of_life", character_data.name)
        "Heal":
            if not character_data:
                _append_to_display("\n❌ No character loaded.")
                return
            var heal_panel = get_parent().get_node_or_null("HealPanel")
            if heal_panel:
                heal_panel.visible = true
                if heal_panel.has_method("set_character_data"):
                    heal_panel.set_character_data(character_data)
            else:
                _append_to_display("\n❌ HealPanel not found.")
        "Inventory":
            if not character_data:
                _append_to_display("\n❌ No character loaded.")
                return
            var inventory_menu = get_parent().get_node_or_null("InventoryMenu")
            if inventory_menu:
                inventory_menu.visible = true
            else:
                _append_to_display("\n❌ InventoryMenu not found.")
        "Physical Attributes":
            if not character_data:
                _append_to_display("\n❌ No character loaded.")
                return
            var inc_ui = get_parent().get_node_or_null("IncreasePhysicalAttributesUI")
            if inc_ui:
                inc_ui.enter(character_data)
            else:
                _append_to_display("\n❌ IncreasePhysicalAttributesUI not found.")
        "Create Character":
            var panel = get_parent().get_node_or_null("CreateCharacterUI")
            if panel:
                panel.enter_mode(character_data)
            else:
                print("⚠️ CreateCharacterUI not found.")

        "Possess":
            var panel = get_parent().get_node_or_null("PlayerSelection")
            if panel:
                print("✅ Possess button clicked")
                panel.enter_state("possess", character_data)
            else:
                print("⚠️ PlayerSelection panel not found.")

        "Release":
            print("🔁 Release clicked")
            get_node("/root/NetworkManager").rpc("request_release_control")

        "Delete":
            var panel = get_parent().get_node_or_null("PlayerSelection")
            if panel:
                print("🗑️ Delete button clicked")
                panel.enter_state("delete", character_data)
            else:
                print("⚠️ PlayerSelection panel not found.")

        "Teleport":
            var panel = get_parent().get_node_or_null("LocationSelection")
            if panel:
                print("🌀 Teleport button clicked")
                panel.enter(character_data, "teleport")
            else:
                print("⚠️ LocationSelection panel not found.")

        "Teleport to Character":
            var panel = get_parent().get_node_or_null("PlayerSelection")
            if panel:
                print("🧭 Teleport to Character clicked")
                panel.enter_state("teleport_to_character", character_data)
            else:
                print("⚠️ PlayerSelection panel not found.")

        "Summon Character":
            var panel = get_parent().get_node_or_null("PlayerSelection")
            if panel:
                print("🧲 Summon Character clicked")
                panel.enter_state("summon", character_data)
            else:
                print("⚠️ PlayerSelection panel not found.")

        "Test Path":
            var virtue_tester = get_parent().get_node_or_null("STVirtueTester")
            if virtue_tester:
                virtue_tester.visible = true
                virtue_tester.enter_mode("path", character_data)
            else:
                print("⚠️ STVirtueTester not found under MainUI.")

        "Test Frenzy":
            var virtue_tester = get_parent().get_node_or_null("STVirtueTester")
            if virtue_tester:
                virtue_tester.visible = true
                virtue_tester.enter_mode("frenzy", character_data)
            else:
                print("⚠️ STVirtueTester not found under MainUI.")

        "Test Rötschreck":
            var virtue_tester = get_parent().get_node_or_null("STVirtueTester")
            if virtue_tester:
                virtue_tester.visible = true
                virtue_tester.enter_mode("rotschreck", character_data)
            else:
                print("⚠️ STVirtueTester not found under MainUI.")

        "Edit Character":
            var panel = get_parent().get_node_or_null("PlayerSelection")
            if panel:
                print("✏️ Edit Character clicked")
                panel.enter_state("edit", character_data)
            else:
                print("⚠️ PlayerSelection panel not found.")
        "Describe":
            var panel = get_parent().get_node_or_null("WordsInputPanel")
            if panel:
                print("📝 Describe Scene clicked")
                panel.enter_state("describe", character_data)
            else:
                print("⚠️ WordsInputPanel not found.")
        "Post Order":
            var panel = get_parent().get_node_or_null("PostOrderST")
            if panel:
                panel.visible = true

                get_node("/root/NetworkManager").rpc("request_zone_character_list", character_data.name)
            else:
                print("⚠️ PostOrderST panel not found.")
        "Damage":
            var panel = get_parent().get_node_or_null("PlayerSelection")
            if panel:
                panel.enter_state("STDamage", character_data)
            else:
                print("⚠️ PlayerSelection panel not found.")
        "Grant AP":
            var panel = get_parent().get_node_or_null("PlayerSelection")
            if panel:
                panel.enter_state("STGiveAP", character_data)
            else:
                print("⚠️ PlayerSelection panel not found.")
        _:
            _append_to_display("\nPressed: " + action)





func _on_zone_character_list_received(names: Array):
    var msg: = ""
    if names.size() == 1 and names[0] == "The city stretches all around you.":
        msg = "The city stretches all around you."
    elif names.is_empty():
        msg = "There is no one of note in this area."
    else:
        msg = "Others in this zone: " + ", ".join(names)

    _append_to_display("\n" + CHAT_DIVIDER + msg)

func _on_zone_name_received(zone_name: String):
    _append_to_display("\n" + CHAT_DIVIDER + " You are currently in: [b]%s[/b]" % zone_name)

func _on_zone_description_received(data: Dictionary):
    var desc = data.get("description", "")
    var sound_path = data.get("sound_path", "")

    _append_to_display("\n" + CHAT_DIVIDER + "[b]Zone Description:[/b]\n" + desc)

    if sound_path != "":
        var main_ui = get_tree().get_root().get_node_or_null("MainUI")
        if main_ui:
            main_ui.play_zone_description_audio(sound_path)
        else:
            print("❌ MainUI not found.")

# Variabile per tenere traccia dell'ultima azione richiesta
var pending_zone_action: String = ""

func _on_zone_info_received(zone_name: String, zone_info: Dictionary):
    if not character_data:
        return
    
    # Controlla se la zona ricevuta è quella del personaggio corrente
    if zone_name != character_data.current_zone:
        return
    
    var is_neighborhood = zone_info.get("is_neighborhood", false)
    
    match pending_zone_action:
        "Temporary Zone":
            if not is_neighborhood:
                _append_to_display("\n You must be in a Neighborhood zone to create a Custom Zone.")
                return
            var words_input = get_parent().get_node("WordsInputPanel")
            words_input.custom_zone_payload = {}
            words_input.enter_state("custom_move_zone_name", character_data)
        
        "Nightly Activities":
            if not is_neighborhood:
                _append_to_display("\n[b]You must explore the streets.[/b]")
                return
            var nightly_ui = get_parent().get_node_or_null("NightlyActivitiesUI")
            if nightly_ui:
                nightly_ui.visible = true
                NetworkManager.rpc("request_nightly_activities_data", character_data.name)
                NetworkManager.rpc("request_group_summary", character_data.name)
            else:
                _append_to_display("\n❌ NightlyActivitiesUI not found.")
    
    # Reset dell'azione pendente
    pending_zone_action = ""



func _is_scrolled_to_bottom(rtl: RichTextLabel) -> bool:
    var sb = null
    if rtl.has_method("get_v_scroll_bar"):
        sb = rtl.get_v_scroll_bar()
    elif rtl.has_method("get_v_scroll"):
        sb = rtl.get_v_scroll()
    if sb == null:
        return true
    return (sb.value + sb.page) >= (sb.max_value - 1.0)

func _append_to_display(bbtext: String) -> void :
    var follow: = _is_scrolled_to_bottom(display_text)

    if display_text is RichTextLabel and display_text.has_method("append_text"):
        display_text.append_text(bbtext)
    else:
        display_text.text += bbtext
    if follow:
        if display_text.has_method("scroll_to_line"):
            display_text.scroll_to_line(display_text.get_line_count() - 1)
        else:
            var sb = null
            if display_text.has_method("get_v_scroll_bar"):
                sb = display_text.get_v_scroll_bar()
            elif display_text.has_method("get_v_scroll"):
                sb = display_text.get_v_scroll()
            if sb:
                sb.value = sb.max_value
