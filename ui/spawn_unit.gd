extends Node2D
var spawn_pos :Vector2 = Vector2.ZERO
@onready var unit_scene = preload("res://tank.tscn")

#func _ready():
#	print(position)
	
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

func _on_yes_pressed():
	var unit = unit_scene.instantiate()
	get_tree().get_root().get_node('world/units').add_child(unit)
	unit.position = find_free_spot_at(spawn_pos)
	unit.rotation = randf()*2*PI-PI
	unit.add_to_group('units', true)

func _on_no_pressed():
	Game.is_dialog_up = false
	queue_free()
