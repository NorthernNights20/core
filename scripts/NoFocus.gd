
extends Node

var _empty_focus: = StyleBoxEmpty.new()

func _ready() -> void :
    _apply_recursive(get_tree().root)
    get_tree().node_added.connect(_on_node_added)

func _on_node_added(n: Node) -> void :
    _apply_recursive(n)

func _apply_recursive(n: Node) -> void :
    if n is Control:

        n.add_theme_stylebox_override("focus", _empty_focus)
        n.add_theme_stylebox_override("focus_hover", _empty_focus)


        if not n.is_in_group("allow_focus"):

            if n is LineEdit or n is TextEdit or n is CodeEdit:
                n.focus_mode = Control.FOCUS_CLICK

            elif n is RichTextLabel:
                var rtl: = n as RichTextLabel
                if rtl.selection_enabled:
                    n.focus_mode = Control.FOCUS_CLICK

                    rtl.context_menu_enabled = true
                else:
                    n.focus_mode = Control.FOCUS_NONE
            else:

                n.focus_mode = Control.FOCUS_NONE

    for c in n.get_children():
        _apply_recursive(c)
