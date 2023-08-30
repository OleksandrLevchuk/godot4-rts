extends Node2D

@onready var unit_scene = preload("res://tank.tscn")

func area_is_free(origin, radius):
	var area = Rect2(origin,Vector2.ZERO).grow(radius)
	for unit in get_tree().get_nodes_in_group('units'):
		if area.has_point(unit.position): return false
	return true
	
func find_free_spot_at(area_center):
	const area_size = 40
	for offset in INF: # to infinity and beyond!
		var point = area_center + offset * Vector2(randf()*2-1,randf()*2-1)
		if area_is_free(point, area_size): return point

func _on_yes_pressed():
	var unit_path = get_tree().get_root().get_node('world/units')
	var unit = unit_scene.instantiate()
	unit.position = find_free_spot_at(Vector2(200,200))
	unit_path.add_child(unit)

func _on_no_pressed():
	pass # Replace with function body. 
