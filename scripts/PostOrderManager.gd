extends Node





signal order_updated(zone_name: String, order: Array[String])
signal order_cleared(zone_name: String)




const DEBUG: = true


var active_orders_by_zone: Dictionary = {}


var order_id_by_character: Dictionary = {}

var _next_order_id: int = 1






func create_from_roster(zone_name: String, dm_name: String) -> Array[String]:

    if not _is_server():
        if DEBUG: print("⛔ PostOrderManager.create_from_roster called on non-server")
        return []

    if not ZoneManager.zones.has(zone_name):
        if DEBUG: print("❌ create_from_roster: unknown zone:", zone_name)
        return []


    destroy(zone_name)

    var roster: Array[String] = _get_zone_roster_names(zone_name)
    if roster.is_empty():
        if DEBUG: print("ℹ️ create_from_roster: empty roster for zone:", zone_name)

        var oid: = _next_id()
        active_orders_by_zone[zone_name] = {
            "id": oid, 
            "order": [], 
            "updated_by": dm_name, 
            "updated_at": Time.get_unix_time_from_system()
        }
        _after_change(zone_name, [])
        return []


    for char_name in roster:
        _remove_char_from_any_order(char_name)


    var new_id: = _next_id()
    active_orders_by_zone[zone_name] = {
        "id": new_id, 
        "order": roster.duplicate(), 
        "updated_by": dm_name, 
        "updated_at": Time.get_unix_time_from_system()
    }


    for char_name in roster:
        order_id_by_character[char_name] = new_id

    if DEBUG:
        print("🔄 PostOrder created for", zone_name, "id=", new_id, "order=", roster)

    _after_change(zone_name, roster)
    return roster


func replace(zone_name: String, submitted_names: Array[String], dm_name: String) -> Dictionary:


    var result: = {
        "order": [] as Array[String], 
        "invalid_names": [] as Array[String]
    }

    if not _is_server():
        if DEBUG: print("⛔ PostOrderManager.replace called on non-server")
        return result

    if not ZoneManager.zones.has(zone_name):
        if DEBUG: print("❌ replace: unknown zone:", zone_name)
        return result


    if not active_orders_by_zone.has(zone_name):
        active_orders_by_zone[zone_name] = {
            "id": _next_id(), 
            "order": [] as Array[String], 
            "updated_by": "", 
            "updated_at": 0
        }

    var order_obj: Dictionary = active_orders_by_zone[zone_name]
    var this_order_id: int = int(order_obj.get("id", 0))


    var roster: Array[String] = _get_zone_roster_names(zone_name)
    var in_roster: = {}
    for char_name in roster:
        in_roster[char_name] = true


    var seen: = {}
    var invalid: Array[String] = []
    var final_order: Array[String] = []
    for raw in submitted_names:
        var nm: = str(raw)
        if nm in seen:
            continue
        seen[nm] = true
        if in_roster.has(nm):
            final_order.append(nm)
        else:
            invalid.append(nm)


    for char_name in final_order:
        var oid_existing: = int(order_id_by_character.get(char_name, 0))
        if oid_existing != 0 and oid_existing != this_order_id:
            _remove_char_from_any_order(char_name)


    order_obj["order"] = final_order
    order_obj["updated_by"] = dm_name
    order_obj["updated_at"] = Time.get_unix_time_from_system()
    active_orders_by_zone[zone_name] = order_obj


    _clear_index_for_order_id(this_order_id)
    for char_name in final_order:
        order_id_by_character[char_name] = this_order_id

    if DEBUG:
        print("✏️ PostOrder replaced for", zone_name, "id=", this_order_id, "order=", final_order, "invalid:", invalid)

    _after_change(zone_name, final_order)

    result.order = final_order
    result.invalid_names = invalid
    return result


func destroy(zone_name: String) -> void :

    if not _is_server():
        if DEBUG: print("⛔ PostOrderManager.destroy called on non-server")
        return

    if not active_orders_by_zone.has(zone_name):
        return

    var order_obj: Dictionary = active_orders_by_zone[zone_name]
    var oid: int = int(order_obj.get("id", 0))
    var members: Array[String] = (order_obj.get("order", []) as Array).duplicate()


    for char_name in members:
        if order_id_by_character.get(char_name, 0) == oid:
            order_id_by_character.erase(char_name)

    active_orders_by_zone.erase(zone_name)

    if DEBUG:
        print("🗑️ PostOrder destroyed for", zone_name, "id=", oid)

    _after_cleared(zone_name)


func get_order(zone_name: String) -> Array[String]:
    if not active_orders_by_zone.has(zone_name):
        return [] as Array[String]
    var order_obj: Dictionary = active_orders_by_zone[zone_name]
    var arr: Array = order_obj.get("order", []) as Array
    var out: Array[String] = []
    for nm in arr:
        out.append(str(nm))
    return out






func mark_stale_due_to_join_or_leave(zone_name: String) -> void :
    if DEBUG:
        print("⚠️ PostOrder marked stale due to roster change in", zone_name)






func _is_server() -> bool:
    return multiplayer.is_server()

func _next_id() -> int:
    var v: = _next_order_id
    _next_order_id += 1
    return v

func _get_zone_roster_names(zone_name: String) -> Array[String]:
    var out: Array[String] = []
    var zone: Dictionary = ZoneManager.zones.get(zone_name, null)
    if zone == null:
        return out
    var chars: Array = zone.get("characters", []) as Array
    for c in chars:

        if c and c.has_method("get"):
            out.append(str(c.name))
    return out

func _remove_char_from_any_order(char_name: String) -> void :
    var oid: = int(order_id_by_character.get(char_name, 0))
    if oid == 0:
        return


    var zone_to_fix: = ""
    for z in active_orders_by_zone.keys():
        var obj: Dictionary = active_orders_by_zone[z]
        if int(obj.get("id", 0)) == oid:
            zone_to_fix = str(z)
            break

    if zone_to_fix == "":

        order_id_by_character.erase(char_name)
        return

    var obj2: Dictionary = active_orders_by_zone[zone_to_fix]
    var arr: Array = obj2.get("order", []) as Array
    var arr_typed: Array[String] = []
    for nm in arr:
        arr_typed.append(str(nm))

    if char_name in arr_typed:
        arr_typed.erase(char_name)
        obj2["order"] = arr_typed
        obj2["updated_at"] = Time.get_unix_time_from_system()
        active_orders_by_zone[zone_to_fix] = obj2
        order_id_by_character.erase(char_name)

        if DEBUG:
            print("↔️ Removed", char_name, "from other PostOrder in zone", zone_to_fix, "id=", oid)


        if arr_typed.is_empty():
            active_orders_by_zone.erase(zone_to_fix)
            if DEBUG:
                print("🗑️ Other PostOrder became empty and was destroyed for zone", zone_to_fix)
            _after_cleared(zone_to_fix)
        else:
            _after_change(zone_to_fix, arr_typed)

func _clear_index_for_order_id(order_id: int) -> void :

    var to_erase: Array[String] = []
    for k in order_id_by_character.keys():
        if int(order_id_by_character[k]) == order_id:
            to_erase.append(str(k))
    for ch in to_erase:
        order_id_by_character.erase(ch)




func _after_change(zone_name: String, order: Array[String]) -> void :

    emit_signal("order_updated", zone_name, order)

    if _is_server():
        if "server_broadcast_post_order" in NetworkManager:
            NetworkManager.server_broadcast_post_order(zone_name, order)

func _after_cleared(zone_name: String) -> void :
    emit_signal("order_cleared", zone_name)
    if _is_server():
        if "server_clear_post_order" in NetworkManager:
            NetworkManager.server_clear_post_order(zone_name)
