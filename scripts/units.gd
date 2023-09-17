#this node deals with finding spawn points and signaling minimap about units
extends Node2D

@export var unit_scene = preload("res://units/tank.tscn")
signal unit_spawned
signal unit_moved

func _ready():
	for unit in get_children():
		unit.moved.connect( _on_unit_moved )
		unit_spawned.emit(unit.minimap_id, unit.position)
	
func area_is_free(origin, radius):
	var area = Rect2(origin,Vector2.ZERO).grow(radius)
	for unit in get_tree().get_nodes_in_group('units'):
		if area.has_point(unit.position): return false
	return true
	
func find_free_spot_at(area_center):
	const area_size = 50
	for offset in INF: # to infinity and beyond!
		var point = area_center + offset * Vector2.ONE * (randf()*2-1)
		if area_is_free(point, area_size): return point

func _on_ordered_unit_spawn(pos:Vector2):
	var unit = unit_scene.instantiate()
	add_child( unit )
	unit.position = find_free_spot_at( pos )
	unit.rotation = randf()*TAU-PI
	unit.add_to_group( 'units', true )
	unit_spawned.emit( unit.minimap_id, unit.position )

func _on_unit_moved(id,pos):
	unit_moved.emit(id,pos)
