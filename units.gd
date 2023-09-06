extends Node2D

@onready var unit_scene = preload("res://tank.tscn")
signal unit_spawned # to notify the minimap

func area_is_free(origin, radius):
	var area = Rect2(origin,Vector2.ZERO).grow(radius)
	for unit in get_tree().get_nodes_in_group('units'):
		if area.has_point(unit.position): return false
	return true
	
func find_free_spot_at(area_center):
	const area_size = 50
	for offset in INF: # to infinity and beyond!
		var point = area_center + offset * Vector2(randf()*2-1,randf()*2-1)
		if area_is_free(point, area_size): return point

func _on_ui_spawn_unit(pos:Vector2):
	var unit = unit_scene.instantiate()
	add_child(unit)
	unit.position = find_free_spot_at(pos)
	unit.rotation = randf()*TAU-PI
	unit.add_to_group('units', true)
	unit_spawned.emit(unit.position)
