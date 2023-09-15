extends CanvasLayer

var is_dialog_up := false
@onready var dialog_scene := preload("res://ui/unit_spawn_dialog.tscn")
signal spawn_unit


func _on_factory_show_spawn_dialog(pos:Vector2):
	if is_dialog_up: return
	is_dialog_up = true
	var dialog = dialog_scene.instantiate()
	dialog.spawn_pos = pos
#	dialog.spawn_unit.connect(func(pos):spawn_unit.emit(pos))
#	dialog.close_dialog.connect(func():is_dialog_up = false)
	add_child( dialog )

func _ready():
	$info.update()
	Game.update_ui.connect($info.update)

func _on_unit_spawned( id, pos ):
	$minimap/viewport.add_marker('unit', id, pos )

func _on_unit_moved( id, pos ):
	print("ui received unit_moved signal")
	$minimap/viewport.move_marker( id, pos )


func _on_camera_moved(pos):
	$minimap/viewport.move_camera(pos)


func _on_camera_zoomed(zoom):
	$minimap/viewport.zoom_camera(zoom)
