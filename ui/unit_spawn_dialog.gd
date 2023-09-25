extends Node2D
var spawn_pos : Vector2

signal unit_spawn_ordered
signal dialog_closed


func _ready():
	position = get_viewport_rect().get_center()
#	spawn_unit.connect( get_parent()._on_dialog_spawn_unit )


func _on_yes_pressed():
	unit_spawn_ordered.emit(spawn_pos)


func _on_no_pressed():
	dialog_closed.emit()
	queue_free()
