extends Node

var Crystals :int = 0
var Energy :int = 0
var Units_gathering :int = 0


@onready var dialog_scene = preload("res://ui/unit_spawn_dialog.tscn")

var is_dialog_up = false
func create_unit_spawn_dialog(pos:Vector2):
	if is_dialog_up: return
	is_dialog_up = true
	var dialog = dialog_scene.instantiate()
	dialog.spawn_pos = pos
	get_tree().get_root().get_node('world/ui').add_child(dialog)
