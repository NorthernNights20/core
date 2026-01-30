extends Control

var character_data



func set_character_data(data: CharacterData) -> void :

    GameManager.character_data = data


    if character_data != null and NetworkManager.is_connected("message_received", Callable(self, "_on_message_received")):
        NetworkManager.disconnect("message_received", Callable(self, "_on_message_received"))

    character_data = data


    $TextPanel / InputButtons.set_character_data(data)
    $ActionPanel.set_character_data(data)


    GameManager.character_uis[data.name] = self


    if not NetworkManager.is_connected("message_received", Callable(self, "_on_message_received")):
        NetworkManager.connect("message_received", Callable(self, "_on_message_received"))

    print("📘 Registered UI for", data.name)


    NetworkManager.rpc("request_zone_viewpoint_data", data.name)




func _ready():
    multiplayer.server_disconnected.connect(_on_server_disconnected)
    multiplayer.connection_failed.connect(_on_server_disconnected)


    var tt: = $TypingTooltip
    if tt:

        tt.autowrap_mode = TextServer.AUTOWRAP_OFF


    $Decoration1 / TypingIndicator.connect("gui_input", Callable(self, "_on_TypingIndicator_gui_input"))

    var image_rect: TextureRect = $ZoneImagePanel / ViewpointImage
    image_rect.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED

    if character_data.is_storyteller:
        var buttons_container = $ActionPanel / TabContainer
        var button = Button.new()
        button.name = "Storyteller"
        buttons_container.add_child(button)

    NetworkManager.typing_update_received.connect(_on_typing_update_received)
    NetworkManager.zone_meta_received.connect(_on_zone_meta_received)

func _on_server_disconnected():
    print("💀 Disconnected from server.")
    _on_message_received({"message": "[i]The world grows dark around you.[/i]"})



func update_viewpoint_image(path: String) -> void :
    print("🖼 Trying to load image from path:", path)
    if path == "":
        print("⚠ No path provided for viewpoint image.")
        return

    var tex = load(path)
    if tex and $ZoneImagePanel / ViewpointImage is TextureRect:
        $ZoneImagePanel / ViewpointImage.texture = tex
        print("🖼 Loaded image:", path)
    else:
        print("❌ Failed to load or apply image:", path)


func _on_message_received(data: Dictionary) -> void :
    var message = data.get("message", "")
    print("🧠 _on_message_received triggered in MainUI:", message)
    var display_text = $TextPanel / DisplayText
    var sb = null
    var was_at_bottom: = true
    var previous_scroll_value: = 0.0
    if display_text is RichTextLabel and display_text.has_method("get_v_scroll_bar"):
        sb = display_text.get_v_scroll_bar()
        if sb:
            previous_scroll_value = sb.value
            was_at_bottom = (sb.value + sb.page) >= (sb.max_value - 1.0)
    if display_text is RichTextLabel and display_text.has_method("append_text"):
        display_text.append_text("\n" + message)
    else:
        display_text.text += "\n" + message
    if sb and not was_at_bottom:
        sb.value = previous_scroll_value


func play_zone_description_audio(sound_path: String) -> void :
    if sound_path == "":
        print("⚠ No sound path provided for zone description.")
        return

    var stream = load(sound_path)
    if stream and $AudioPlayer:
        $AudioPlayer.stream = stream
        $AudioPlayer.play()
        print("🔊 Playing zone description audio:", sound_path)
    else:
        print("❌ Failed to load or play zone description audio:", sound_path)

func set_narrator_volume_db(value: float) -> void :
    if $AudioPlayer:
        $AudioPlayer.volume_db = value

var typers_in_zone: = {}

func _on_typing_update_received(data: Dictionary) -> void :
    var typer_name: String = data.get("name", "")
    var is_typing: bool = data.get("is_typing", false)
    var local_name: String = character_data.name

    print("📨 Typing update received from:", typer_name, "is_typing:", is_typing)

    if typer_name == local_name:
        return

    if is_typing:
        typers_in_zone[typer_name] = true
    else:
        typers_in_zone.erase(typer_name)

    update_typing_indicator()

func update_typing_indicator():
    var someone_typing = typers_in_zone.size() > 0
    $Decoration1 / TypingIndicator.texture = preload("res://Image/UI/CandleLit.png") if someone_typing else preload("res://Image/UI/CandleUnlit.png")

func _on_TypingIndicator_mouse_entered():
    if typers_in_zone.size() == 0:
        return

    var names: = typers_in_zone.keys()
    names.sort()

    for i in range(names.size()):
        names[i] = names[i].replace(" ", " ")

    var display_text: = "\n".join(names)
    print("🧾 Tooltip content:", display_text)

    var tt: = $TypingTooltip
    if tt:
        tt.autowrap_mode = TextServer.AUTOWRAP_OFF
        tt.text = display_text
        tt.visible = true
        tt.reset_size()
        tt.global_position = get_viewport().get_mouse_position() + Vector2(12, 12)


func _on_TypingIndicator_mouse_exited():
    $TypingTooltip.visible = false


func _process(_delta):
    if $TypingTooltip.visible:
        $TypingTooltip.global_position = get_viewport().get_mouse_position() + Vector2(12, 12)


func _on_TypingIndicator_gui_input(event: InputEvent) -> void :
    if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
        if $TypingTooltip.visible:
            $TypingTooltip.visible = false
            return

        if typers_in_zone.size() == 0:
            return

        var names: = typers_in_zone.keys()
        names.sort()
        for i in range(names.size()):
            names[i] = names[i].replace(" ", " ")

        var tt: = $TypingTooltip
        if tt:
            tt.autowrap_mode = TextServer.AUTOWRAP_OFF
            tt.text = "\n".join(names)
            tt.visible = true
            tt.reset_size()
            tt.global_position = get_viewport().get_mouse_position() + Vector2(12, 12)





func show_character_display(character_name: String, description: String, image_bytes: PackedByteArray) -> void :
    var character_display: = $CharacterDisplay

    if not is_instance_valid(character_display):
        print("❌ CharacterDisplay node not found!")
        return


    character_display.display_image(image_bytes)


    if character_display.has_method("set_description_text"):
        character_display.set_description_text(character_name, description)


    character_display.visible = true
    print("📣 CharacterDisplay is now visible")


func _on_zone_meta_received(_category: String, is_neighborhood: bool) -> void :
    var ind: = $ZoneImagePanel / NeighIndicator
    if is_instance_valid(ind):
        ind.visible = is_neighborhood
