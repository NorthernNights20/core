extends Node

func apply_login_effects(character: CharacterData, peer_id: int) -> void :
    if not character.is_vampire:
        print("🧍 Skipping wake-up effects (not a vampire):", character.name)
        return

    print("⏰ WakeUpManager running for", character.name, " (Peer:", peer_id, ")")

    var calendar: Node = get_node("/root/CalendarManager")
    var current_date: String = calendar.get_current_date_string()
    var is_second_half: bool = calendar.is_second_half

    var wakeup_triggered: = false
    var ap_reset_triggered: = false
    var blush_reset_triggered: = false


    if character.last_time_woken_up != current_date:
        var old_bp: int = character.blood_pool
        var old_wp: int = character.willpower_current

        character.blood_pool = max(character.blood_pool - 1, 0)
        character.willpower_current = min(character.willpower_current + 1, character.willpower_max)
        character.last_time_woken_up = current_date
        wakeup_triggered = true


        if character.blush_of_life:
            character.blush_of_life = false
            blush_reset_triggered = true
            print("🩸 Blush of Life cleared on wake for:", character.name)

        print("🌙 Wake-up effects applied to", character.name)
        print("  - Blood: ", old_bp, " → ", character.blood_pool)
        print("  - Willpower: ", old_wp, " → ", character.willpower_current)
    else:
        print("🌙 No wake-up effects: already logged in tonight:", character.name)


    var current_half_stamp: String = current_date + "|" + ("2" if is_second_half else "1")
    if character.last_ap_reset_stamp != current_half_stamp:
        var old_ap: int = character.action_points_current
        character.action_points_current = character.action_points_max
        character.last_ap_reset_stamp = current_half_stamp
        ap_reset_triggered = true

        print("🌀 Action Points reset for", character.name)
        print("  - Action Points: ", old_ap, " → ", character.action_points_current)
    else:
        print("🌀 No AP reset: already logged in this half:", character.name)


    var ap: = character.action_points_current
    var message: String = ""

    if wakeup_triggered and ap_reset_triggered:
        message = "You wake up, gaining 1 Willpower and spending 1 Blood Point. You are ready to act with %d Action Points." % ap
    elif ap_reset_triggered:
        message = "You carry on with the evening. You are ready to act with %d Action Points." % ap
    else:
        message = "You carry on with the evening."


    MessagesManager.send_wakeup_message(peer_id, message)


    if blush_reset_triggered:
        MessagesManager.send_wakeup_message(peer_id, "Your body returns to its corpselike form.")
