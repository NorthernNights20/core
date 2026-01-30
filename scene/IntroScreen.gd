extends Control

const CONFIG_FILE_PATH = "res://server_config.json"

var server_ip: String = "127.0.0.1"
var server_port: int = 43210


@onready var storyteller_button = $ButtonMenu / StorytellerButton
@onready var words_input_panel = $WordsInputPanel
@onready var name_input_box = $WordsInputPanel / WordsInputPanelPanel / VBoxContainer / InputBox
@onready var confirm_button = $WordsInputPanel / WordsInputPanelPanel / VBoxContainer / HBoxContainer / SendButton

@onready var load_button = $ButtonMenu / LoadCharacterButton
@onready var login_ui = $LoginUI
@onready var new_character_button = $ButtonMenu / NewCharacterButton


func _ready():
    _load_server_config()
    
    storyteller_button.pressed.connect(_on_storyteller_button_pressed)
    words_input_panel.visible = false
    load_button.pressed.connect(_on_load_character_pressed)
    new_character_button.pressed.connect(_on_new_character_pressed)

    MusicManager.play_music(preload("res://sound/music/Ready to be a Vampire.mp3"))

func _load_server_config() -> void:
    if not FileAccess.file_exists(CONFIG_FILE_PATH):
        print("⚠️ Config file not found at:", CONFIG_FILE_PATH)
        print("ℹ️ Using default values: IP=", server_ip, " Port=", server_port)
        return
    
    var file = FileAccess.open(CONFIG_FILE_PATH, FileAccess.READ)
    if file == null:
        print("❌ Failed to open config file:", CONFIG_FILE_PATH)
        print("ℹ️ Using default values: IP=", server_ip, " Port=", server_port)
        return
    
    var json_string = file.get_as_text()
    file.close()
    
    var json = JSON.new()
    var parse_result = json.parse(json_string)
    
    if parse_result != OK:
        print("❌ Failed to parse config JSON:", json.get_error_message())
        print("ℹ️ Using default values: IP=", server_ip, " Port=", server_port)
        return
    
    var config = json.get_data()
    
    if config.has("server_ip"):
        server_ip = config["server_ip"]
        print("✅ Loaded server_ip from config:", server_ip)
    
    if config.has("server_port"):
        server_port = config["server_port"]
        print("✅ Loaded server_port from config:", server_port)

func _on_new_character_pressed():
    print("🧬 New Character button pressed.")
    MusicManager.fade_out()
    _connect_to_server_for_character_creation()

func _connect_to_server_for_character_creation():
    multiplayer.multiplayer_peer = null
    var peer = ENetMultiplayerPeer.new()
    peer.create_client(server_ip, server_port)
    multiplayer.multiplayer_peer = peer

    multiplayer.connected_to_server.connect(_on_connected_for_character_creation)
    multiplayer.connection_failed.connect(_on_failed)
    multiplayer.server_disconnected.connect(_on_disconnected)

func _on_connected_for_character_creation():
    print("✅ Connected to server for new character creation.")
    await get_tree().create_timer(0.1).timeout

    var character_creation_scene = load("res://scene/character_creation.tscn")
    if character_creation_scene == null:
        print("❌ Failed to load character creation scene.")
        return

    var character_creation = character_creation_scene.instantiate()
    get_tree().root.add_child(character_creation)

    var old_scene = get_tree().current_scene
    get_tree().current_scene = character_creation
    if old_scene:
        old_scene.queue_free()

    print("🧬 Entered character creation screen.")

func _on_load_character_pressed():
    print("🔁 Load Character button pressed.")
    MusicManager.fade_out()
    _connect_to_server_for_loading()

func _connect_to_server_for_loading():
    multiplayer.multiplayer_peer = null
    var peer = ENetMultiplayerPeer.new()
    peer.create_client(server_ip, server_port)
    multiplayer.multiplayer_peer = peer

    multiplayer.connected_to_server.connect(_on_connected_for_loading)
    multiplayer.connection_failed.connect(_on_failed)
    multiplayer.server_disconnected.connect(_on_disconnected)

func _on_connected_for_loading():
    print("✅ Connected to server for character loading.")
    await get_tree().create_timer(0.1).timeout
    login_ui.visible = true

func _on_storyteller_button_pressed():
    print("🧙 Storyteller button pressed.")
    MusicManager.fade_out()
    _connect_to_server_for_loading()

func _on_login_cancelled():
    print("🔙 Login cancelled by user.")

func _on_failed():
    print("❌ Connection failed. Staying on intro screen.")

func _on_disconnected():
    print("🔌 Disconnected from server.")
