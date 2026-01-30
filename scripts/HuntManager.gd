extends Node


var rand: = RandomNumberGenerator.new()

func roll_hunt_step(character: CharacterData, roll_data: Dictionary, use_specialization: bool = false, use_willpower: bool = false) -> Dictionary:
    var attr_name: String = roll_data.get("roll", [])[0]
    var ability_name: String = roll_data.get("roll", [])[1]
    var difficulty: int = int(roll_data.get("difficulty", 6))

    var attr_val: int = _resolve_stat_value(character, attr_name)
    var ability_val: int = _resolve_stat_value(character, ability_name)
    var total_dice: int = attr_val + ability_val


    var penalty: int = _calculate_wound_penalty(character)
    total_dice = max(0, total_dice - penalty)

    var spec_active: bool = use_specialization and ability_val >= 4
    var bonus_successes: int = 0

    if use_willpower and character.willpower_current > 0:
        character.willpower_current -= 1
        bonus_successes = 1
        GameManager.emit_signal("character_updated", character.name)

    var rolls: Array[int] = []
    var successes: int = 0
    var ones: int = 0
    rand.randomize()

    for i in total_dice:
        var roll: = rand.randi_range(1, 10)
        rolls.append(roll)

        if roll == 1:
            ones += 1
        if roll >= difficulty:
            successes += 1
            if spec_active:
                if roll == 10:
                    successes += 1
                elif ability_val >= 5 and roll == 9 and difficulty <= 9:
                    successes += 1

    successes += bonus_successes

    var effective_ones: = ones
    if spec_active and ones > 0:
        effective_ones -= 1

    var net_successes: = successes - effective_ones
    var is_botch: = successes == 0 and ones > 0

    var result_type: = ""
    if is_botch:
        result_type = "Botch"
    elif net_successes <= 0:
        result_type = "Failure"
    elif net_successes == 1:
        result_type = "Marginal Success"
    elif net_successes == 2:
        result_type = "Moderate Success"
    elif net_successes == 3:
        result_type = "Complete Success"
    elif net_successes == 4:
        result_type = "Exceptional Success"
    else:
        result_type = "Phenomenal Success"

    return {
        "character_name": character.name, 
        "attribute": attr_name, 
        "attribute_value": attr_val, 
        "ability": ability_name, 
        "ability_value": ability_val, 
        "rolls": rolls, 
        "total_dice": total_dice, 
        "successes": successes, 
        "ones": ones, 
        "effective_ones": effective_ones, 
        "net_successes": net_successes, 
        "is_botch": is_botch, 
        "result_type": result_type, 
        "used_specialization": spec_active, 
        "used_willpower": use_willpower, 
        "bonus_successes": bonus_successes, 
        "difficulty": difficulty
    }

func _resolve_stat_value(character: CharacterData, stat_name: String) -> int:
    if stat_name == "" or not character.has_method("get"):
        return 0
    var normalized: = stat_name.to_lower().replace(" ", "_")
    return clamp(character.get(normalized), 0, 10)


func _calculate_wound_penalty(character: CharacterData) -> int:
    match character.health_index:
        0, 1:
            return 0
        2, 3:
            return 1
        4, 5:
            return 2
        6:
            return 5
        7:
            return 999
        _:
            return 0


func _normalize_hunt_type(h: String) -> String:
    var low: = h.to_lower()
    if low == "social":
        return "Social"
    if low == "prowling" or low == "prowl":
        return "Prowl"
    return h



func build_contact_phase_payload(hunt_type: String, scenario_id: String, character: CharacterData = null) -> Dictionary:
    var normalized: = _normalize_hunt_type(hunt_type)
    var scenario: Dictionary = HuntScenarioManager.get_scenario(normalized, scenario_id)
    if scenario.is_empty():
        return {"scenario_name": String(scenario_id), "description": "", "options": []}

    var cp_any: Variant = scenario.get("contact_phase", [])
    var contact_phase: Array = []
    if cp_any is Array:
        contact_phase = cp_any as Array

    var options: Array[Dictionary] = []
    for i in contact_phase.size():
        var step_any: Variant = contact_phase[i]
        if step_any is Dictionary:
            var step: Dictionary = step_any

            var roll_any: Variant = step.get("roll", [])
            var roll_arr: Array = []
            if roll_any is Array:
                roll_arr = roll_any as Array

            var base_diff: int = int(step.get("difficulty", 6))
            var adj: Dictionary = _adjust_contact_difficulty(character, base_diff, hunt_type)
            var shown_diff: int = int(adj.get("difficulty", base_diff))
            var delta: int = int(adj.get("delta", 0))
            var color_hex: String = String(adj.get("color_hex", ""))


            if color_hex == "" and delta != 0:
                color_hex = "#00ff00" if delta < 0 else "#ff0000"


            var diff_bbcode: = str(shown_diff)
            if color_hex != "":
                diff_bbcode = "[color=%s]%s[/color]" % [color_hex, str(shown_diff)]

            options.append({
                "index": i, 
                "title": String(step.get("title", "")), 
                "description": String(step.get("description", "")), 
                "roll": roll_arr, 
                "difficulty": shown_diff, 
                "difficulty_base": base_diff, 
                "difficulty_delta": delta, 
                "difficulty_color_hex": color_hex, 
                "difficulty_bbcode": diff_bbcode
            })

    return {
        "scenario_name": String(scenario.get("scenario_name", scenario_id)), 
        "description": String(scenario.get("description", "")), 
        "options": options
    }



func build_hunt_phase_payload(hunt_type: String, scenario_id: String, character: CharacterData = null) -> Dictionary:
    var normalized: = _normalize_hunt_type(hunt_type)
    var scenario: Dictionary = HuntScenarioManager.get_scenario(normalized, scenario_id)
    if scenario.is_empty():
        var empty: Array[Dictionary] = []
        return {
            "scenario_name": String(scenario_id), 
            "description": "", 
            "options": empty
        }

    var hp_any: Variant = scenario.get("hunt_phase", [])
    var hunt_phase: Array = []
    if hp_any is Array:
        hunt_phase = hp_any as Array

    var options: Array[Dictionary] = []
    for i in hunt_phase.size():
        var step_any: Variant = hunt_phase[i]
        if step_any is Dictionary:
            var step: Dictionary = step_any

            var roll_any: Variant = step.get("roll", [])
            var roll_arr: Array = []
            if roll_any is Array:
                roll_arr = roll_any as Array

            var base_diff: int = int(step.get("difficulty", 6))


            var adj: Dictionary = _adjust_social_hunt_difficulty(character, base_diff, hunt_type)
            var shown_diff: int = int(adj.get("difficulty", base_diff))
            var delta: int = int(adj.get("delta", 0))
            var color_name: String = String(adj.get("color", ""))
            var color_hex: String = String(adj.get("color_hex", ""))

            if color_hex == "" and delta != 0:
                color_hex = "#00ff00" if delta < 0 else "#ff0000"

            var diff_bbcode: = str(shown_diff)
            if color_hex != "":
                diff_bbcode = "[color=%s]%s[/color]" % [color_hex, str(shown_diff)]

            var option: Dictionary = {
                "index": i, 
                "title": String(step.get("title", "")), 
                "description": String(step.get("description", "")), 
                "roll": roll_arr, 
                "difficulty": shown_diff, 
                "difficulty_base": base_diff, 
                "difficulty_delta": delta, 
                "difficulty_color": color_name, 
                "difficulty_color_hex": color_hex, 
                "difficulty_bbcode": diff_bbcode
            }
            options.append(option)

    return {
        "scenario_name": String(scenario.get("scenario_name", scenario_id)), 
        "description": String(scenario.get("description", "")), 
        "options": options
    }






func process_contact_choice(
        character_name: String, 
        hunt_type: String, 
        scenario_id: String, 
        option_index: int, 
        use_specialization: bool = false, 
        _use_willpower: bool = false
    ) -> Dictionary:

    var result_payload: Dictionary = {
        "phase": "contact", 
        "scenario_name": scenario_id, 
        "description": "", 
        "selected_index": option_index, 
        "selected_title": "", 
        "roll_result": {}, 
        "outcome": "failure", 
        "narrative": "", 
        "next": {}
    }

    if not GameManager.character_data_by_name.has(character_name):
        result_payload["narrative"] = "Character not found."
        return result_payload

    var character: CharacterData = GameManager.character_data_by_name[character_name]

    var normalized: = _normalize_hunt_type(hunt_type)
    var scenario: Dictionary = HuntScenarioManager.get_scenario(normalized, scenario_id)
    result_payload["scenario_name"] = String(scenario.get("scenario_name", scenario_id))
    result_payload["description"] = String(scenario.get("description", ""))

    var cp_any: Variant = scenario.get("contact_phase", [])
    var contact_phase: Array = []
    if cp_any is Array:
        contact_phase = cp_any as Array

    if option_index < 0 or option_index >= contact_phase.size():
        result_payload["narrative"] = "Invalid contact option."
        return result_payload

    var step_any: Variant = contact_phase[option_index]
    if not (step_any is Dictionary):
        result_payload["narrative"] = "Malformed contact option."
        return result_payload

    var step: Dictionary = step_any
    result_payload["selected_title"] = String(step.get("title", ""))

    var roll_any: Variant = step.get("roll", [])
    var roll_arr: Array = []
    if roll_any is Array:
        roll_arr = roll_any as Array


    var base_diff: int = int(step.get("difficulty", 6))
    var adj: Dictionary = _adjust_contact_difficulty(character, base_diff, hunt_type)
    var final_diff: int = int(adj.get("difficulty", base_diff))

    var roll_data: Dictionary = {
        "roll": roll_arr, 
        "difficulty": final_diff
    }


    var armed_wp: = _consume_wp_token(character_name)


    var roll_outcome: Dictionary = roll_hunt_step(character, roll_data, use_specialization, false)


    if armed_wp:
        roll_outcome["used_willpower"] = true
        roll_outcome["bonus_successes"] = int(roll_outcome.get("bonus_successes", 0)) + 1
        roll_outcome["successes"] = int(roll_outcome.get("successes", 0)) + 1
        roll_outcome["net_successes"] = int(roll_outcome.get("net_successes", 0)) + 1


        if bool(roll_outcome.get("is_botch", false)) and int(roll_outcome.get("successes", 0)) > 0:
            roll_outcome["is_botch"] = false


        var net: = int(roll_outcome.get("net_successes", 0))
        var rtype: = ""
        if bool(roll_outcome.get("is_botch", false)):
            rtype = "Botch"
        elif net <= 0:
            rtype = "Failure"
        elif net == 1:
            rtype = "Marginal Success"
        elif net == 2:
            rtype = "Moderate Success"
        elif net == 3:
            rtype = "Complete Success"
        elif net == 4:
            rtype = "Exceptional Success"
        else:
            rtype = "Phenomenal Success"
        roll_outcome["result_type"] = rtype

    result_payload["roll_result"] = roll_outcome

    var net_successes: int = int(roll_outcome.get("net_successes", 0))
    var outcome: String = "success" if net_successes > 0 else "failure"
    result_payload["outcome"] = outcome

    if outcome == "success":
        result_payload["narrative"] = String(step.get("success_text", ""))
        var next_payload: Dictionary = build_hunt_phase_payload(hunt_type, scenario_id, character)
        result_payload["next"] = {
            "phase": "hunt", 
            "options": next_payload.get("options", [])
        }
    else:
        result_payload["narrative"] = String(step.get("failure_text", ""))

    return result_payload







func build_defeat_phase_payload(hunt_type: String, scenario_id: String) -> Dictionary:
    var normalized: String = _normalize_hunt_type(hunt_type)
    var scenario: Dictionary = HuntScenarioManager.get_scenario(normalized, scenario_id)
    if scenario.is_empty():
        var empty_opts: Array[Dictionary] = []
        return {
            "scenario_name": String(scenario_id), 
            "description": "", 
            "options": empty_opts
        }

    var dp_any: Variant = scenario.get("defeat_phase", [])
    var defeat_phase: Array = []
    if dp_any is Array:
        defeat_phase = dp_any as Array

    var options: Array[Dictionary] = []
    for i in defeat_phase.size():
        var step_any: Variant = defeat_phase[i]
        if step_any is Dictionary:
            var step: Dictionary = step_any

            var roll_any: Variant = step.get("roll", [])
            var roll_arr: Array = []
            if roll_any is Array:
                roll_arr = roll_any as Array

            var option: Dictionary = {
                "index": i, 
                "title": String(step.get("title", "")), 
                "description": String(step.get("description", "")), 
                "roll": roll_arr, 
                "difficulty": int(step.get("difficulty", 6))
            }
            options.append(option)

    return {
        "scenario_name": String(scenario.get("scenario_name", scenario_id)), 
        "description": String(scenario.get("description", "")), 
        "options": options
    }





func process_hunt_choice(
        character_name: String, 
        hunt_type: String, 
        scenario_id: String, 
        option_index: int, 
        use_specialization: bool = false, 
        _use_willpower: bool = false
    ) -> Dictionary:

    var result_payload: Dictionary = {
        "phase": "hunt", 
        "scenario_name": scenario_id, 
        "description": "", 
        "selected_index": option_index, 
        "selected_title": "", 
        "roll_result": {}, 
        "outcome": "failure", 
        "narrative": "", 
        "next": {}
    }

    if not GameManager.character_data_by_name.has(character_name):
        result_payload["narrative"] = "Character not found."
        return result_payload
    var character: CharacterData = GameManager.character_data_by_name[character_name]

    var normalized: String = _normalize_hunt_type(hunt_type)
    var scenario: Dictionary = HuntScenarioManager.get_scenario(normalized, scenario_id)
    result_payload["scenario_name"] = String(scenario.get("scenario_name", scenario_id))
    result_payload["description"] = String(scenario.get("description", ""))

    var hp_any: Variant = scenario.get("hunt_phase", [])
    var hunt_phase: Array = []
    if hp_any is Array:
        hunt_phase = hp_any as Array

    if option_index < 0 or option_index >= hunt_phase.size():
        result_payload["narrative"] = "Invalid hunt option."
        return result_payload

    var step_any: Variant = hunt_phase[option_index]
    if not (step_any is Dictionary):
        result_payload["narrative"] = "Malformed hunt option."
        return result_payload

    var step: Dictionary = step_any
    result_payload["selected_title"] = String(step.get("title", ""))

    var roll_any: Variant = step.get("roll", [])
    var roll_arr: Array = []
    if roll_any is Array:
        roll_arr = roll_any as Array

    var base_diff: int = int(step.get("difficulty", 6))


    var adj: Dictionary = _adjust_social_hunt_difficulty(character, base_diff, hunt_type)
    var final_diff: int = int(adj.get("difficulty", base_diff))

    var roll_data: Dictionary = {
        "roll": roll_arr, 
        "difficulty": final_diff
    }


    var armed_wp: = _consume_wp_token(character_name)


    var roll_outcome: Dictionary = roll_hunt_step(character, roll_data, use_specialization, false)


    if armed_wp:
        roll_outcome["used_willpower"] = true
        roll_outcome["bonus_successes"] = int(roll_outcome.get("bonus_successes", 0)) + 1
        roll_outcome["successes"] = int(roll_outcome.get("successes", 0)) + 1
        roll_outcome["net_successes"] = int(roll_outcome.get("net_successes", 0)) + 1

        if bool(roll_outcome.get("is_botch", false)) and int(roll_outcome.get("successes", 0)) > 0:
            roll_outcome["is_botch"] = false

        var net: = int(roll_outcome.get("net_successes", 0))
        var rtype: = ""
        if bool(roll_outcome.get("is_botch", false)):
            rtype = "Botch"
        elif net <= 0:
            rtype = "Failure"
        elif net == 1:
            rtype = "Marginal Success"
        elif net == 2:
            rtype = "Moderate Success"
        elif net == 3:
            rtype = "Complete Success"
        elif net == 4:
            rtype = "Exceptional Success"
        else:
            rtype = "Phenomenal Success"
        roll_outcome["result_type"] = rtype

    result_payload["roll_result"] = roll_outcome

    var is_botch: bool = bool(roll_outcome.get("is_botch", false))
    var net_successes: int = int(roll_outcome.get("net_successes", 0))
    var is_success: bool = (net_successes > 0) and ( not is_botch)

    result_payload["outcome"] = "success" if is_success else "failure"

    var success_text: String = String(step.get("success_text", "You press the advantage."))
    var failure_text: String = String(step.get("failure_text", "The moment slips away."))
    result_payload["narrative"] = success_text if is_success else failure_text

    if is_success:
        var next_payload: Dictionary = build_defeat_phase_payload(hunt_type, scenario_id)
        result_payload["next"] = {
            "phase": "defeat", 
            "options": next_payload.get("options", [])
        }

    return result_payload




func process_feed_choice(character_name: String, hunt_type: String, scenario_id: String, mode: String) -> Dictionary:
    var payload: Dictionary = {
        "hunt_type": hunt_type, 
        "scenario_id": scenario_id, 
        "scenario_name": scenario_id, 
        "description": "", 
        "mode": mode, 
        "blood_gain_intended": 0, 
        "blood_gained": 0, 
        "blood_before": 0, 
        "blood_after": 0, 
        "blood_max": 0, 
        "victim_died": false, 
        "message": ""
    }

    if not GameManager.character_data_by_name.has(character_name):
        payload["message"] = "Character not found."
        return payload

    var character: CharacterData = GameManager.character_data_by_name[character_name]

    var normalized: String = _normalize_hunt_type(hunt_type)
    var scenario: Dictionary = HuntScenarioManager.get_scenario(normalized, scenario_id)
    if not scenario.is_empty():
        payload["scenario_name"] = String(scenario.get("scenario_name", scenario_id))
        payload["description"] = String(scenario.get("description", ""))

    var mode_l: String = mode.to_lower()
    var intended_gain: int = 0
    var victim_died: bool = false

    if mode_l == "safe":
        intended_gain = 3
    elif mode_l == "risk":
        rand.randomize()
        var gpick: int = rand.randi_range(0, 1)
        if gpick == 0:
            intended_gain = 5
        else:
            intended_gain = 6
        var droll: int = rand.randi_range(0, 1)
        victim_died = (droll == 0)
    else:
        intended_gain = 10
        victim_died = true

    var before: int = character.blood_pool
    var bmax: int = character.blood_pool_max
    var after: int = before + intended_gain
    if after > bmax:
        after = bmax
    var gained_actual: int = after - before

    character.blood_pool = after
    GameManager.emit_signal("character_updated", character.name)

    payload["mode"] = mode_l
    payload["blood_gain_intended"] = intended_gain
    payload["blood_gained"] = gained_actual
    payload["blood_before"] = before
    payload["blood_after"] = after
    payload["blood_max"] = bmax
    payload["victim_died"] = victim_died

    var summary: String = "Feeding: %s • Gained %d blood (Pool %d → %d / %d)." % [mode_l.to_upper(), gained_actual, before, after, bmax]
    if victim_died:
        summary += " Victim dies."
    else:
        summary += " Victim survives."
    payload["message"] = summary

    return payload





func _build_feed_prompt_payload(hunt_type: String, scenario_id: String) -> Dictionary:
    var normalized: = _normalize_hunt_type(hunt_type)
    var scenario: Dictionary = HuntScenarioManager.get_scenario(normalized, scenario_id)

    return {
        "phase": "feed_prompt", 
        "scenario_id": scenario_id, 
        "scenario_name": String(scenario.get("scenario_name", scenario_id)), 
        "description": String(scenario.get("description", "")), 
        "choices": [
            {"key": "safe", "label": "SAFE", "desc": "Take 3 blood safely."}, 
            {"key": "risk", "label": "RISK", "desc": "Take 5–6 blood; 50% chance the victim dies."}, 
            {"key": "gorge", "label": "GORGE", "desc": "Take up to 10 blood; the victim dies."}
        ]
    }




func process_defeat_choice(
        character_name: String, 
        hunt_type: String, 
        scenario_id: String, 
        option_index: int, 
        use_specialization: bool = false, 
        _use_willpower: bool = false
    ) -> Dictionary:

    var result_payload: Dictionary = {
        "phase": "defeat", 
        "hunt_type": hunt_type, 
        "scenario_id": scenario_id, 
        "scenario_name": scenario_id, 
        "description": "", 
        "selected_index": option_index, 
        "selected_title": "", 
        "roll_result": {}, 
        "outcome": "failure", 
        "narrative": ""
    }

    if not GameManager.character_data_by_name.has(character_name):
        result_payload["narrative"] = "Character not found."
        return result_payload
    var character: CharacterData = GameManager.character_data_by_name[character_name]

    var normalized: = _normalize_hunt_type(hunt_type)
    var scenario: Dictionary = HuntScenarioManager.get_scenario(normalized, scenario_id)
    result_payload["scenario_name"] = String(scenario.get("scenario_name", scenario_id))
    result_payload["description"] = String(scenario.get("description", ""))

    var dp_any: Variant = scenario.get("defeat_phase", [])
    var defeat_phase: Array = []
    if dp_any is Array:
        defeat_phase = dp_any as Array

    if option_index < 0 or option_index >= defeat_phase.size():
        result_payload["narrative"] = "Invalid defeat option."
        return result_payload

    var step_any: Variant = defeat_phase[option_index]
    if not (step_any is Dictionary):
        result_payload["narrative"] = "Malformed defeat option."
        return result_payload

    var step: Dictionary = step_any
    result_payload["selected_title"] = String(step.get("title", ""))

    var roll_any: Variant = step.get("roll", [])
    var roll_arr: Array = []
    if roll_any is Array:
        roll_arr = roll_any as Array

    var roll_data: Dictionary = {
        "roll": roll_arr, 
        "difficulty": int(step.get("difficulty", 6))
    }


    var armed_wp: = _consume_wp_token(character_name)


    var roll_outcome: Dictionary = roll_hunt_step(character, roll_data, use_specialization, false)


    if armed_wp:
        roll_outcome["used_willpower"] = true
        roll_outcome["bonus_successes"] = int(roll_outcome.get("bonus_successes", 0)) + 1
        roll_outcome["successes"] = int(roll_outcome.get("successes", 0)) + 1
        roll_outcome["net_successes"] = int(roll_outcome.get("net_successes", 0)) + 1

        if bool(roll_outcome.get("is_botch", false)) and int(roll_outcome.get("successes", 0)) > 0:
            roll_outcome["is_botch"] = false

        var net: = int(roll_outcome.get("net_successes", 0))
        var rtype: = ""
        if bool(roll_outcome.get("is_botch", false)):
            rtype = "Botch"
        elif net <= 0:
            rtype = "Failure"
        elif net == 1:
            rtype = "Marginal Success"
        elif net == 2:
            rtype = "Moderate Success"
        elif net == 3:
            rtype = "Complete Success"
        elif net == 4:
            rtype = "Exceptional Success"
        else:
            rtype = "Phenomenal Success"
        roll_outcome["result_type"] = rtype

    result_payload["roll_result"] = roll_outcome

    var is_botch: bool = bool(roll_outcome.get("is_botch", false))
    var net_successes: int = int(roll_outcome.get("net_successes", 0))
    var is_success: bool = (net_successes > 0) and ( not is_botch)

    if is_success:
        result_payload["outcome"] = "success"
        result_payload["narrative"] = String(step.get("success_text", "You succeed."))
    else:
        result_payload["outcome"] = "failure"
        result_payload["narrative"] = String(step.get("failure_text", "You fail."))

    return result_payload




func process_feed_resolution(
        character_name: String, 
        hunt_type: String, 
        scenario_id: String, 
        choice_key: String
    ) -> Dictionary:

    if not GameManager.character_data_by_name.has(character_name):
        print("🐛[HuntManager] FeedResolution ✖ no character:", character_name)
        return {
            "phase": "feed_result", 
            "scenario_id": scenario_id, 
            "scenario_name": scenario_id, 
            "description": "", 
            "message": "Character not found.", 
            "blood_before": 0, 
            "blood_gained": 0, 
            "blood_after": 0, 
            "blood_max": 0, 
            "victim_died": false
        }

    var character: CharacterData = GameManager.character_data_by_name[character_name]
    var key: String = choice_key.to_lower()

    var normalized: String = _normalize_hunt_type(hunt_type)
    var scenario: Dictionary = HuntScenarioManager.get_scenario(normalized, scenario_id)
    var scen_name: String = String(scenario.get("scenario_name", scenario_id))
    var desc: String = String(scenario.get("description", ""))


    var before: int = 0
    var bmax: int = 0
    var after: int = 0


    var path_before: int = -1
    var path_after: int = -1
    var path_lost: int = 0

    var before0: int = int(character.blood_pool)
    var bmax0: int = int(character.blood_pool_max)
    print("🐛[HuntManager] FeedResolution ▶ char=%s choice=%s hunt=%s scen=%s | pool=%d/%d path_name=%s path=%d"
        %[character_name, choice_key, normalized, scen_name, before0, bmax0, String(character.path_name), int(character.path)])




    if _hungry_for_frenzy(character):
        var ctrl_first: Dictionary = _roll_virtue_capped_by_path(character, 6)
        if not bool(ctrl_first.get("passed", false)):
            before = int(character.blood_pool)
            bmax = int(character.blood_pool_max)
            var victim_bp: int = VICTIM_BLOOD_POOL_BP
            var drained: int = 0
            var victim_died: bool = false
            var regained: bool = false
            var last_check: Dictionary = ctrl_first


            var stop_on_regain: bool = (key != "gorge")

            print("🐛[HuntManager] FORCED FRENZY START → blood=%d/%d victim_bp=%d" % [before, bmax, victim_bp])

            while (character.blood_pool < bmax)\
and (drained < victim_bp)\
and ( not regained or not stop_on_regain):
                character.blood_pool += 1
                drained += 1
                last_check = _roll_virtue_capped_by_path(character, 6)
                regained = bool(last_check.get("passed", false))
                print("🐛[HuntManager]   step=%d blood=%d/%d | drained=%d/%d | regained=%s"
                    %[drained, int(character.blood_pool), bmax, drained, victim_bp, str(regained)])


            if drained > 6:
                victim_died = true
            elif drained >= 5:
                rand.randomize()
                victim_died = (rand.randi() % 2) == 1



            if key == "gorge":
                victim_died = true

            after = int(character.blood_pool)
            if GameManager.has_signal(&"character_updated"):
                GameManager.emit_signal("character_updated", character.name)

            var reason: String = "regained control"
            if after >= bmax:
                reason = "fully sated"
            if victim_died:
                reason = "victim died"

            print("🐛[HuntManager] FORCED FRENZY END → reason=%s blood_before=%d blood_after=%d gained=%d victim_died=%s"
                %[reason, before, after, after - before, str(victim_died)])


            var frenzy_msg: String = ""
            if victim_died:
                frenzy_msg = "Hunger frenzy erupts. You gorge until the vessel dies."
            elif after >= bmax:
                frenzy_msg = "Hunger frenzy erupts. You gorge until fully sated."
            else:
                frenzy_msg = "Hunger frenzy erupts. You regain control before killing the vessel."


            var cons_trigger: String = ""
            var cons_block: Dictionary = {}


            if victim_died:
                if String(character.path_name) == "Humanity" and int(character.path) >= 6:
                    cons_trigger = "frenzy_death"
                elif String(character.path_name) == "Path of the Beast" and int(character.path) >= 4:
                    cons_trigger = "beast_death"
                elif String(character.path_name) == "Path of Cathari" and int(character.path) >= 5:
                    cons_trigger = "cathari_death"
                elif String(character.path_name) == "Path of Feral Heart" and int(character.path) >= 4:
                    cons_trigger = "feral_heart_death"
                elif String(character.path_name) == "Path of Honorable Accord" and int(character.path) >= 2:
                    cons_trigger = "honorable_accord_death"
                elif String(character.path_name) == "Path of Lilith" and int(character.path) >= 4:
                    cons_trigger = "lilith_death"
                elif String(character.path_name) == "Path of Night" and int(character.path) >= 4:
                    cons_trigger = "night_death"
                elif String(character.path_name) == "Path of the Scorched Heart" and int(character.path) == 5:
                    cons_trigger = "scorched_heart_death"
                elif String(character.path_name) == "Path of Redemption" and int(character.path) >= 2:
                    cons_trigger = "redemption_death"


            if cons_trigger == "" and String(character.path_name) == "Path of Caine" and int(character.path) >= 6:
                cons_trigger = "cainite_frenzy"

            if cons_trigger != "":

                cons_block = _roll_conscience_capped_by_path(character, 8)
                print("🐛[HuntManager] Degeneration TRIGGER (%s) → %s" % [cons_trigger, str(cons_block)])


                if not bool(cons_block.get("passed", false)):
                    path_before = int(character.path)
                    path_after = max(0, path_before - 1)
                    path_lost = path_before - path_after
                    character.path = path_after
                    if GameManager.has_signal(&"character_updated"):
                        GameManager.emit_signal("character_updated", character.name)
                    print("🐛[HuntManager] Degeneration FAIL → Path drop %d→%d (lost %d)" % [path_before, path_after, path_lost])

            var ret: Dictionary = {
                "phase": "feed_result", 
                "scenario_id": scenario_id, 
                "scenario_name": scen_name, 
                "description": desc, 
                "choice": "frenzy", 
                "forced_frenzy": true, 
                "frenzy_roll": last_check, 
                "message": frenzy_msg, 
                "blood_before": before, 
                "blood_gained": after - before, 
                "blood_after": after, 
                "blood_max": bmax, 
                "victim_died": victim_died
            }
            if cons_trigger != "":
                ret["conscience_trigger"] = cons_trigger
                ret["conscience_check"] = cons_block
            if path_lost > 0:
                ret["path_before"] = path_before
                ret["path_after"] = path_after
                ret["path_lost"] = path_lost
            return ret




    var requested_gain: int = 0
    if key == "safe":
        requested_gain = 3
    elif key == "risk":
        rand.randomize()
        requested_gain = rand.randi_range(5, 6)
    elif key == "gorge":
        requested_gain = 10
    else:
        requested_gain = 3

    before = int(character.blood_pool)
    bmax = int(character.blood_pool_max)
    var capacity: int = max(0, bmax - before)
    var actual_gain: int = min(requested_gain, capacity)
    after = before + actual_gain
    character.blood_pool = after


    var victim_died2: bool = (key == "gorge")
    if not victim_died2:
        if actual_gain > 6:
            victim_died2 = true
        elif actual_gain >= 5:
            rand.randomize()
            victim_died2 = (rand.randi() % 2) == 1

    if GameManager.has_signal(&"character_updated"):
        GameManager.emit_signal("character_updated", character.name)

    print("🐛[HuntManager] NORMAL FEED → key=%s want=%d got=%d | pool %d→%d/%d | death_by_amount=%s"
        %[key, requested_gain, actual_gain, before, after, bmax, str(victim_died2)])


    var cons_trigger2: String = ""
    var cons_block2: Dictionary = {}
    var path_name: = String(character.path_name)
    var hum: = int(character.path)

    if path_name == "Humanity":

        if hum == 3:
            if key == "gorge":
                cons_trigger2 = "gorge"
        elif hum == 4 or hum == 5:
            if key == "gorge":
                cons_trigger2 = "gorge"
            elif key == "risk" and victim_died2:
                cons_trigger2 = "risk_death"
        elif hum >= 6:
            if key == "gorge":
                cons_trigger2 = "gorge"
            elif key == "risk" and victim_died2:
                cons_trigger2 = "risk_death"


    elif path_name == "Path of the Beast":
        if victim_died2 and hum >= 4:
            cons_trigger2 = "beast_death"

    elif path_name == "Path of Cathari":
        if victim_died2 and hum >= 5:
            cons_trigger2 = "cathari_death"

    elif path_name == "Path of Feral Heart":
        if victim_died2 and hum >= 4:
            cons_trigger2 = "feral_heart_death"

    elif path_name == "Path of Honorable Accord":
        if victim_died2 and hum >= 2:
            cons_trigger2 = "honorable_accord_death"

    elif path_name == "Path of Lilith":
        if victim_died2 and hum >= 4:
            cons_trigger2 = "lilith_death"

    elif path_name == "Path of Night":
        if victim_died2 and hum >= 4:
            cons_trigger2 = "night_death"

    elif path_name == "Path of the Scorched Heart":
        if victim_died2 and hum == 5:
            cons_trigger2 = "scorched_heart_death"

    elif path_name == "Path of Redemption":
        if victim_died2 and hum >= 2:
            cons_trigger2 = "redemption_death"

    if cons_trigger2 != "":

        cons_block2 = _roll_conscience_capped_by_path(character, 8)
        print("🐛[HuntManager] Degeneration TRIGGER (%s) → %s" % [cons_trigger2, str(cons_block2)])


        if not bool(cons_block2.get("passed", false)):
            path_before = int(character.path)
            path_after = max(0, path_before - 1)
            path_lost = path_before - path_after
            character.path = path_after
            if GameManager.has_signal(&"character_updated"):
                GameManager.emit_signal("character_updated", character.name)
            print("🐛[HuntManager] Degeneration FAIL → Path drop %d→%d (lost %d)" % [path_before, path_after, path_lost])


    var msg: String = ""
    if key == "safe":
        msg = "You feed cautiously and sate your hunger a little."
    elif key == "risk":
        msg = "You push your luck and take more than you should."
    elif key == "gorge":
        msg = "You drink deep until nothing remains to give."
    else:
        msg = "You feed cautiously."

    var ret2: Dictionary = {
        "phase": "feed_result", 
        "scenario_id": scenario_id, 
        "scenario_name": scen_name, 
        "description": desc, 
        "choice": key, 
        "message": msg, 
        "blood_before": before, 
        "blood_gained": actual_gain, 
        "blood_after": after, 
        "blood_max": bmax, 
        "victim_died": victim_died2
    }
    if cons_trigger2 != "":
        ret2["conscience_trigger"] = cons_trigger2
        ret2["conscience_check"] = cons_block2
    if path_lost > 0:
        ret2["path_before"] = path_before
        ret2["path_after"] = path_after
        ret2["path_lost"] = path_lost

    return ret2


func _adjust_social_hunt_difficulty(character: CharacterData, base_diff: int, hunt_type: String) -> Dictionary:
    var normalized: = _normalize_hunt_type(hunt_type)
    if normalized != "Social" or character == null:
        return {"difficulty": base_diff, "delta": 0, "color": "", "color_hex": ""}

    var delta: = 0

    if character.blush_of_life:
        delta -= 1
    if character.path_name != "" and character.path_name != "Humanity":
        delta += 1


    delta -= int(character.fame)

    var color: = ""
    var color_hex: = ""
    if delta < 0:
        color = "green";color_hex = "#00ff00"
    elif delta > 0:
        color = "red";color_hex = "#ff0000"

    return {
        "difficulty": base_diff + delta, 
        "delta": delta, 
        "color": color, 
        "color_hex": color_hex
    }




const VICTIM_BLOOD_POOL_BP: = 10

func _control_virtue_name(character: CharacterData) -> String:

    return "self_control" if int(character.self_control) >= int(character.instinct) else "instinct"

func _control_virtue_value(character: CharacterData) -> int:
    return int(character.get(_control_virtue_name(character)))

func _hungry_for_frenzy(character: CharacterData) -> bool:
    var ctrl: int = clamp(_control_virtue_value(character), 0, 10)
    var threshold: int = 7 - ctrl
    return int(character.blood_pool) < threshold


func _roll_virtue_capped_by_path(character: CharacterData, difficulty: int = 6) -> Dictionary:

    var v_name: String = _control_virtue_name(character)
    var v_val: int = clamp(int(character.get(v_name)), 0, 10)
    var cap: int = clamp(int(character.path), 0, 10)
    var pool: int = min(v_val, cap)

    var rolls: Array[int] = []
    var succ: int = 0
    var ones: int = 0
    rand.randomize()
    for i in pool:
        var r: int = rand.randi_range(1, 10)
        rolls.append(r)
        if r == 1:
            ones += 1
        elif r >= difficulty:
            succ += 1

    var net: int = succ - ones
    return {
        "virtue_name": v_name, 
        "virtue_val": v_val, 
        "path_cap": cap, 
        "pool_used": pool, 
        "difficulty": difficulty, 
        "rolls": rolls, 
        "successes": succ, 
        "ones": ones, 
        "net_successes": net, 
        "passed": net > 0
    }




func _roll_conscience_capped_by_path(character: CharacterData, difficulty: int = 8) -> Dictionary:
    var on_humanity: = String(character.path_name) == "Humanity"
    var use_conviction: = ( not on_humanity) or int(character.conscience) <= 0

    var virtue_key: = "conviction" if use_conviction else "conscience"
    var virtue_label: = "Conviction" if use_conviction else "Conscience"

    var v_val: int = clamp(int(character.get(virtue_key)), 0, 10)
    var cap: int = clamp(int(character.path), 0, 10)
    var pool: int = min(v_val, cap)

    var rolls: Array[int] = []
    var succ: = 0
    var ones: = 0
    rand.randomize()
    for i in pool:
        var r: = rand.randi_range(1, 10)
        rolls.append(r)
        if r == 1:
            ones += 1
        elif r >= difficulty:
            succ += 1

    var net: = succ - ones
    var passed: = net > 0

    print("🐛[HuntManager] Degeneration roll (%s) → pool=%d (virt=%d cap=%d) diff=%d rolls=%s net=%d passed=%s"
        %[virtue_label, pool, v_val, cap, difficulty, str(rolls), net, str(passed)])

    return {
        "virtue": virtue_label, 
        "pool_used": pool, 
        "difficulty": difficulty, 
        "rolls": rolls, 
        "successes": succ, 
        "ones": ones, 
        "net_successes": net, 
        "passed": passed
    }

var _wp_token_for_next_roll: Dictionary = {}

func _consume_wp_token(char_name: String) -> bool:
    if _wp_token_for_next_roll.has(char_name) and bool(_wp_token_for_next_roll[char_name]):
        _wp_token_for_next_roll.erase(char_name)
        return true
    return false

func arm_willpower_for_next_roll(char_name: String) -> Dictionary:
    if not GameManager.character_data_by_name.has(char_name):
        return {"ok": false, "reason": "no_character"}

    var cd: CharacterData = GameManager.character_data_by_name[char_name]
    if cd.willpower_current <= 0:
        return {"ok": false, "reason": "no_wp", "wp_current": cd.willpower_current, "wp_max": cd.willpower_max}


    cd.willpower_current = max(0, cd.willpower_current - 1)
    GameManager.character_data_by_name[char_name] = cd
    _wp_token_for_next_roll[char_name] = true

    if GameManager.has_signal(&"character_updated"):
        GameManager.emit_signal("character_updated", cd.name)

    return {
        "ok": true, 
        "wp_current": cd.willpower_current, 
        "wp_max": cd.willpower_max, 
        "zone": String(cd.current_zone), 
        "ap_current": int(cd.action_points_current), 
        "ap_max": int(cd.action_points_max), 
        "blood_current": int(cd.blood_pool), 
        "blood_max": int(cd.blood_pool_max)
    }


func _adjust_contact_difficulty(character: CharacterData, base_diff: int, _hunt_type: String) -> Dictionary:
    if character == null:
        return {"difficulty": base_diff, "delta": 0, "color": "", "color_hex": ""}

    var delta: int = 0


    var clan_l: String = String(character.clan).to_lower()
    if clan_l == "ventrue" or clan_l == "ventrue antitribu":
        delta += 1


    var final_diff: int = clampi(base_diff + delta, 3, 10)



    var color: String = ""
    var color_hex: String = ""
    if delta < 0:
        color = "green";color_hex = "#00ff00"
    elif delta > 0:
        color = "red";color_hex = "#ff0000"

    var ret: Dictionary = {
        "difficulty": final_diff, 
        "delta": delta, 
        "color": color, 
        "color_hex": color_hex
    }
    return ret
