extends CanvasLayer

var is_dialog_up := false
@onready var dialog_scene := preload("res://ui/unit_spawn_dialog.tscn")
signal spawn_unit


func _on_factory_show_spawn_dialog(pos:Vector2):
	if is_dialog_up: return
	is_dialog_up = true
	var dialog = dialog_scene.instantiate()
	dialog.spawn_pos = pos
	dialog.spawn_unit.connect(func(pos):spawn_unit.emit(pos))
	dialog.close_dialog.connect(func():is_dialog_up = false)
	add_child( dialog )

func _ready():
	$info.update()
	Game.update_ui.connect($info.update)


func _on_units_unit_spawned(pos, id):
	
	$minimap.add_marker('unit', pos, id)
