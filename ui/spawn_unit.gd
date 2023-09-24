extends Node2D
var spawn_pos :Vector2

signal spawn_unit
signal close_dialog

func _ready():
	spawn_unit.connect(get_parent()._on_dialog_spawn_unit)


func _on_yes_pressed():
	spawn_unit.emit(spawn_pos)

func _on_no_pressed():
	close_dialog.emit()
	queue_free()
