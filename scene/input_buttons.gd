extends Control

@onready var speak_button = $SpeakButton
@onready var whisper_button = $WhisperButton
@onready var emote_button = $EmoteButton
@onready var ooc_button = $OOCButton
@onready var tell_button = $TellButton

@onready var words_input_panel = $"../../WordsInputPanel"

var character_data

func _ready():

    speak_button.pressed.connect(_on_speak_pressed)
    whisper_button.pressed.connect(_on_whisper_pressed)
    emote_button.pressed.connect(_on_emote_pressed)
    ooc_button.pressed.connect(_on_ooc_pressed)
    tell_button.pressed.connect(_on_tell_pressed)

func set_character_data(data):
    character_data = data

func _on_speak_pressed():
    words_input_panel.enter_state("speak", character_data)

func _on_whisper_pressed():
    var player_selection = $"../../PlayerSelection"
    player_selection.enter_state("whisper", character_data)

    var viewport_size = get_viewport_rect().size
    player_selection.global_position = (viewport_size - player_selection.size) / 2
    player_selection.visible = true

func _on_emote_pressed():
    words_input_panel.enter_state("emote", character_data)

func _on_ooc_pressed():
    words_input_panel.enter_state("ooc", character_data)

func _on_tell_pressed():
    var player_selection = $"../../PlayerSelection"
    player_selection.enter_state("tell", character_data)

    var viewport_size = get_viewport_rect().size
    player_selection.global_position = (viewport_size - player_selection.size) / 2
    player_selection.visible = true
