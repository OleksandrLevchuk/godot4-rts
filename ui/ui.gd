extends CanvasLayer

var is_dialog_up := false
signal ordered_unit_spawn


func _on_buildings_building_selected(pos:Vector2, dialog_scene:Resource):
	if is_dialog_up: return
	is_dialog_up = true
	var dialog = dialog_scene.instantiate()
	dialog.spawn_pos = pos
	add_child( dialog )
#	dialog.spawn_unit.connect(func(pos):spawn_unit.emit(pos))
#	dialog.close_dialog.connect(func():is_dialog_up = false)


func _on_dialog_spawn_unit( pos ):
	ordered_unit_spawn.emit(pos)
