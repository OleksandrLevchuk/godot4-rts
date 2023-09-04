extends Node

signal update_ui

var Crystals :int = 0: 
	set(x): 
		Crystals=x
		update_ui.emit()
var Energy :int = 0:
	set(x):
		Energy = x
		update_ui.emit()
var is_dialog_up := false


@onready var dialog_scene = preload("res://ui/unit_spawn_dialog.tscn")


func create_unit_spawn_dialog(pos:Vector2):
	if is_dialog_up: return
	is_dialog_up = true
	var dialog = dialog_scene.instantiate()
	dialog.spawn_pos = pos
	get_tree().get_root().get_node('world/ui').add_child(dialog)
