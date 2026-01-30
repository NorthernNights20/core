extends Button

func _pressed():
    var main_ui = get_tree().current_scene
    var character = main_ui.character_data


    var zone_data_node = main_ui.get_node("Zone")
    if not zone_data_node:
        print("Zone data node not found.")
        return

    var zone_info = zone_data_node.zones.get(character.current_zone)
    if not zone_info:
        print("Zone '%s' not found." % character.current_zone)
        return

    var description = zone_info.get("description", "No description available.")


    var label = main_ui.get_node("TextPanel/DisplayText")
    if label:
        label.text += "\n\n" + description
    else:
        print("DisplayText label not found.")
