

extends Control

var red_theme: Theme = preload("res://Image/UI/BloodButtonCompleted.tres")


const UI_WIDTH: = 722
const ROW_SEP: = 6
const NAME_COL_W: = 200
const STATUS_COL_W: = 240
const BUTTON_W: = 74



@onready var list_box: VBoxContainer = get_node_or_null("Panel/VBoxContainer/ScrollContainer/VBoxContainer") as VBoxContainer
@onready var notes_panel: Control = get_node_or_null("Panel2") as Control
@onready var notes_scroller: ScrollContainer = get_node_or_null("Panel2/ScrollContainer") as ScrollContainer
@onready var notes_box: VBoxContainer = get_node_or_null("Panel2/ScrollContainer/VBoxContainer") as VBoxContainer

func _ready() -> void :
    print("[HerdUI] ready at", get_path())
    _assert_nodes()


    var done_btn: Button = get_node_or_null("Panel/VBoxContainer/Done") as Button
    if done_btn:
        done_btn.pressed.connect(_on_done_pressed)


    if NetworkManager.has_signal("herd_state_received"):
        NetworkManager.herd_state_received.connect(_on_state, CONNECT_DEFERRED)
    if NetworkManager.has_signal("herd_feed_result"):
        NetworkManager.herd_feed_result.connect(_on_feed_result, CONNECT_DEFERRED)


    if CalendarManager and CalendarManager.has_signal("day_changed"):
        CalendarManager.day_changed.connect(_on_day_changed, CONNECT_DEFERRED)

    _ensure_notes_visible()
    _refresh_ap_lockout_ui()

func open() -> void :
    visible = true
    _ensure_notes_visible()
    _refresh_ap_lockout_ui()
    print("[HerdUI] open() → requesting state …")
    _request_state()

func _ensure_notes_visible() -> void :
    if notes_panel:
        notes_panel.visible = true
        if notes_panel.has_method("move_to_front"):
            notes_panel.call("move_to_front")
    if notes_scroller:
        notes_scroller.size_flags_horizontal = Control.SIZE_EXPAND_FILL
        notes_scroller.size_flags_vertical = Control.SIZE_EXPAND_FILL
    if notes_box:
        notes_box.size_flags_horizontal = Control.SIZE_EXPAND_FILL
        notes_box.size_flags_vertical = Control.SIZE_EXPAND_FILL

func _request_state() -> void :
    if GameManager.character_data:
        NetworkManager.rpc("request_herd_state", GameManager.character_data.name)

func _on_day_changed(_date_str: String) -> void :
    if visible:
        _request_state()

func _on_done_pressed() -> void :
    visible = false



func _on_state(data: Dictionary) -> void :
    _assert_nodes()
    if list_box == null:
        return

    print("[HerdUI] _on_state() capacity=", data.get("capacity", -1), 
        " herd_count=", data.get("herd_count", -1))

    _clear(list_box)

    var count: int = int(data.get("herd_count", 0))
    var cap: int = int(data.get("capacity", 0))

    var hdr: Label = Label.new()
    hdr.text = "Herd Members: %d / %d" % [count, cap]
    hdr.add_theme_font_size_override("font_size", 14)
    list_box.add_child(hdr)

    var members_any: Variant = data.get("members", [])
    var members: Array = []
    if members_any is Array:
        members = members_any as Array

    var no_ap: = _no_ap()

    for entry_v in members:
        if not (entry_v is Dictionary):
            continue
        var entry: Dictionary = entry_v as Dictionary
        var idx: int = int(entry.get("index", -1))
        var has: bool = bool(entry.get("has_member", false))

        var row: HBoxContainer = HBoxContainer.new()
        row.size_flags_horizontal = Control.SIZE_EXPAND_FILL
        row.custom_minimum_size = Vector2(UI_WIDTH, 0)
        row.add_theme_constant_override("separation", ROW_SEP)

        if has:

            var name_lbl: Label = Label.new()
            name_lbl.text = "Name: " + String(entry.get("name", ""))
            name_lbl.custom_minimum_size = Vector2(NAME_COL_W, 0)
            name_lbl.clip_text = true
            name_lbl.text_overrun_behavior = TextServer.OVERRUN_TRIM_ELLIPSIS
            row.add_child(name_lbl)


            var status_lbl: Label = Label.new()
            var status: String = String(entry.get("status", "Healthy"))
            var unlock_on: String = String(entry.get("unlock_date", ""))
            status_lbl.custom_minimum_size = Vector2(STATUS_COL_W, 0)
            status_lbl.clip_text = true
            status_lbl.text_overrun_behavior = TextServer.OVERRUN_TRIM_ELLIPSIS

            if status == "Recovering":
                status_lbl.add_theme_color_override("font_color", Color(1.0, 0.7, 0.6))
                status_lbl.text = "Status: Recovering"
            elif status == "Dead":
                status_lbl.add_theme_color_override("font_color", Color(1.0, 0.4, 0.4))
                var left: = _days_until_in_game(unlock_on)
                if unlock_on != "":
                    if left > 0:

                        status_lbl.text = "Status: Dead • in %dd (%s)" % [left, unlock_on]
                        status_lbl.tooltip_text = "Replacement available on %s (in-game)." % unlock_on
                    else:
                        status_lbl.text = "Status: Dead • replacement available"
                        status_lbl.tooltip_text = "Replacement available now."
                else:
                    status_lbl.text = "Status: Dead"
            else:
                status_lbl.add_theme_color_override("font_color", Color(0.7, 1.0, 0.7))
                status_lbl.text = "Status: " + status
            row.add_child(status_lbl)


            var disabled_by_status: bool = (status == "Recovering" or status == "Dead")
            var disabled_any: bool = disabled_by_status or no_ap

            for spec in [
                {"label": "Safe", "mode": "safe"}, 
                {"label": "Risk", "mode": "risk"}, 
                {"label": "Gorge", "mode": "gorge"}, 
            ]:
                var b: Button = Button.new()
                b.text = String(spec["label"])
                b.custom_minimum_size = Vector2(BUTTON_W, 28)
                b.theme = red_theme
                b.disabled = disabled_any
                if disabled_by_status:
                    if status == "Dead":
                        var tt: = "Unavailable. Slot is locked."
                        if unlock_on != "":
                            var left: = _days_until_in_game(unlock_on)
                            tt = "Unavailable. Replacement in %d in-game day%s." % [left, ("" if left == 1 else "s")]
                        b.tooltip_text = tt
                    else:
                        b.tooltip_text = "Unavailable while recovering."
                elif no_ap:
                    b.tooltip_text = "Not enough Activity Points."
                else:
                    b.tooltip_text = ""
                b.add_to_group("herd_feed_button")
                b.pressed.connect( func(m: = String(spec["mode"]), i: = idx) -> void :
                    if GameManager.character_data:
                        print("[HerdUI] feed pressed → idx:", i, " mode:", m)
                        NetworkManager.rpc("request_herd_feed", GameManager.character_data.name, i, m)
                )
                row.add_child(b)
        else:

            var name_lbl2: Label = Label.new()
            name_lbl2.text = "Name:"
            row.add_child(name_lbl2)

            var edit: LineEdit = LineEdit.new()
            edit.placeholder_text = "Enter herd member name"
            edit.size_flags_horizontal = Control.SIZE_EXPAND_FILL
            edit.clip_text = true
            row.add_child(edit)

            var create_btn: Button = Button.new()
            create_btn.text = "Create"
            create_btn.theme = red_theme
            create_btn.custom_minimum_size = Vector2(92, 28)
            create_btn.disabled = true
            edit.text_changed.connect( func(t: String) -> void :
                create_btn.disabled = t.strip_edges().is_empty()
            )
            create_btn.pressed.connect( func(i: = idx) -> void :
                var n: String = edit.text.strip_edges()
                if n != "" and GameManager.character_data:
                    print("[HerdUI] create pressed → idx:", i, " name:", n)
                    NetworkManager.rpc("request_herd_create_member", GameManager.character_data.name, i, n)
            )
            row.add_child(create_btn)

        list_box.add_child(row)


    _refresh_ap_lockout_ui()


func _on_feed_result(res: Dictionary) -> void :
    _assert_nodes()
    _ensure_notes_visible()

    print("[HerdUI] _on_feed_result() msg=", String(res.get("message", "")))

    var r: RichTextLabel = RichTextLabel.new()
    r.bbcode_enabled = true
    r.fit_content = true
    r.scroll_active = false
    r.autowrap_mode = TextServer.AUTOWRAP_WORD
    r.size_flags_horizontal = Control.SIZE_EXPAND_FILL

    r.add_theme_color_override("default_color", Color(0.95, 0.95, 0.95))

    var lines: Array[String] = []
    var choice: String = String(res.get("choice", "")).to_upper()
    var msg: String = String(res.get("message", ""))

    var bp_before: int = int(res.get("blood_before", 0))
    var bp_after: int = int(res.get("blood_after", bp_before))
    var bp_max: int = int(res.get("blood_max", 0))

    var herd_name: String = String(res.get("herd_member_name", ""))
    var hb0: int = int(res.get("herd_blood_before", 0))
    var hb1: int = int(res.get("herd_blood_after", hb0))
    var hstat: String = String(res.get("herd_status_after", ""))


    lines.append("[b]Herd Feed — %s[/b]" % (choice if choice != "" else "RESULT"))
    if msg != "":
        lines.append(msg)
    lines.append("Blood pool: %d → [b]%d[/b] / %d" % [bp_before, bp_after, bp_max])
    if herd_name != "":
        lines.append("Herd %s: %d → [b]%d[/b] / 10 • %s" % [herd_name, hb0, hb1, hstat])


    if bool(res.get("forced_frenzy", false)):
        lines.append("[color=#ff7070]Hunger frenzy[/color] occurred.")
        var fr: Dictionary = res.get("frenzy_roll", {})
        if not fr.is_empty():
            var vname: = String(fr.get("virtue_name", "control"))
            var pool: = int(fr.get("pool_used", fr.get("pool", 0)))
            var diff: = int(fr.get("difficulty", 6))
            var passed: = bool(fr.get("passed", false))
            lines.append("[i]Frenzy control (%s): pool %d @ diff %d → %s[/i]" %
                [vname.capitalize(), pool, diff, ("passed" if passed else "failed")])
            lines.append("Rolls: %s" % str(fr.get("rolls", [])))


    var trigger: String = String(res.get("conscience_trigger", ""))
    if trigger != "":
        var cc: Dictionary = res.get("conscience_check", {})
        var passed: bool = bool(cc.get("passed", false))
        var vlabel: String = String(cc.get("virtue", "Conscience"))
        var pool: int = int(cc.get("pool_used", 0))
        var diff: int = int(cc.get("difficulty", 8))
        lines.append("Degeneration trigger: [i]%s[/i]" % trigger)
        lines.append("Degeneration [%s]: %s (pool %d, diff %d, rolls %s)" %
            [vlabel, ("passed" if passed else "failed"), pool, diff, str(cc.get("rolls", []))])


    var path_lost: int = int(res.get("path_lost", 0))
    if path_lost > 0:
        var path_before: int = int(res.get("path_before", 0))
        var path_after: int = int(res.get("path_after", 0))
        lines.append("[color=#ff9090]Path drops %d → %d[/color]" % [path_before, path_after])


    if bool(res.get("victim_died", false)):
        lines.append("[color=#ff8080]The herd member dies.[/color]")
        var u: = String(res.get("unlock_date", ""))
        if u != "":
            var left: = _days_until_in_game(u)
            if left > 0:
                lines.append("Replacement available in %d day%s (%s)." % [left, ("" if left == 1 else "s"), u])
            else:
                lines.append("Replacement available now.")


    var notes_any: Variant = res.get("notes", [])
    if notes_any is Array:
        for n_v in (notes_any as Array):
            var s: = String(n_v)
            if not s.strip_edges().is_empty():
                lines.append("• " + s)

    lines.append("[color=gray]────────────────────[/color]")


    r.text = "\n".join(lines)

    if notes_box:
        notes_box.add_child(r)

    await get_tree().process_frame
    if notes_scroller:
        notes_scroller.scroll_vertical = 1000000000
        notes_scroller.ensure_control_visible(r)


    _refresh_ap_lockout_ui()


func _no_ap() -> bool:
    var cd: = GameManager.character_data
    return (cd == null) or (int(cd.action_points_current) <= 0)

func _refresh_ap_lockout_ui() -> void :
    _refresh_ap_banner()
    _apply_ap_lockout()

func _refresh_ap_banner() -> void :
    if notes_box == null:
        return

    var old: = notes_box.get_node_or_null("APNote")
    if old:
        old.queue_free()

    if _no_ap():
        var note: = Label.new()
        note.name = "APNote"
        note.text = "You do not have anymore Action Points."
        note.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
        note.add_theme_font_size_override("font_size", 13)
        note.add_theme_color_override("font_color", Color(1.0, 0.6, 0.6))
        notes_box.add_child(note)
        notes_box.move_child(note, 0)

func _apply_ap_lockout() -> void :
    var no_ap: = _no_ap()
    for n in get_tree().get_nodes_in_group("herd_feed_button"):
        if n is Button:
            var b: = n as Button

            if no_ap and not b.disabled:
                b.disabled = true
                b.tooltip_text = "Not enough Activity Points."
            elif ( not no_ap) and b.tooltip_text == "Not enough Activity Points.":

                b.disabled = false
                b.tooltip_text = ""


func _clear(node: Node) -> void :
    for c in node.get_children():
        node.remove_child(c)
        c.queue_free()

func _assert_nodes() -> void :
    if list_box == null:
        push_error("[HerdUI] list_box missing at Panel/VBoxContainer/ScrollContainer/VBoxContainer")
    if notes_panel == null:
        push_error("[HerdUI] notes_panel missing at Panel2")
    if notes_scroller == null:
        push_error("[HerdUI] notes_scroller missing at Panel2/ScrollContainer")
    if notes_box == null:
        push_error("[HerdUI] notes_box missing at Panel2/ScrollContainer/VBoxContainer")


func _date_compare(a: String, b: String) -> int:

    var pa: = a.split("-"); var pb: = b.split("-")
    if pa.size() != 3 or pb.size() != 3:
        return 0
    var ay: = pa[0].to_int(); var am: = pa[1].to_int(); var ad: = pa[2].to_int()
    var by: = pb[0].to_int(); var bm: = pb[1].to_int(); var bd: = pb[2].to_int()
    if ay != by: return 1 if ay > by else -1
    if am != bm: return 1 if am > bm else -1
    if ad != bd: return 1 if ad > bd else -1
    return 0

func _days_until_in_game(target_date: String) -> int:
    if target_date == "" or not CalendarManager:
        return 0
    var today: = CalendarManager.get_current_date_string()
    if _date_compare(today, target_date) >= 0:
        return 0
    var cur: = today
    var count: = 0
    while cur != target_date and count < 5000:
        cur = CalendarManager.date_plus_days(cur, 1)
        count += 1
    return count
