extends Button

@onready var character_scene = preload("res://scene/Character.tscn")
@onready var main_ui_scene = preload("res://scene/main_ui.tscn")
@onready var zone_scene = preload("res://scene/zone.tscn")

func _ready():
    connect("pressed", Callable(self, "_on_pressed"))

func _on_pressed():
    var character_creation = preload("res://scene/character_creation.tscn").instantiate()
    var root = get_tree().get_root()


    var peer = ENetMultiplayerPeer.new()
    peer.create_client("127.0.0.1", 12345)
    multiplayer.multiplayer_peer = peer

    multiplayer.connected_to_server.connect( func():
        print("✅ Connected to server for character creation.")


        get_tree().current_scene.queue_free()
        root.add_child(character_creation)
        get_tree().set_current_scene(character_creation)

        print("🧬 Entered character creation screen.")
    )

    multiplayer.connection_failed.connect( func():
        print("❌ Failed to connect to server.")
    )
