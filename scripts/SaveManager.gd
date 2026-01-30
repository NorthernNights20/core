extends Node

func _init():
    print("🧠 SaveManager script loaded.")


const SAVE_DIR: = "user://characters/"

func _ready():
    DirAccess.make_dir_recursive_absolute(SAVE_DIR)

func save_character(char_data: Resource) -> void :
    var path: String = SAVE_DIR + char_data.name + ".tres"
    var err: = ResourceSaver.save(char_data, path)
    if err != OK:
        print("❌ Failed to save character:", char_data.name)
    else:
        print("✅ Character saved:", char_data.name)
