extends CanvasLayer

var is_dialog_up := false
signal ordered_unit_spawn


func _ready():
	$info.update()
	Game.update_ui.connect($info.update)


func _on_unit_spawned( pos:Vector2 ):
	$minimap/viewport.add_marker('unit', pos )


func _on_unit_moved( id, pos ):
	$minimap/viewport.move_marker( id, pos )


func _on_camera_moved(pos):
	$minimap/viewport.move_camera(pos)


func _on_camera_zoomed(zoom):
	$minimap/viewport.zoom_camera(zoom)


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
