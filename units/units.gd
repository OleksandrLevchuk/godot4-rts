#this node deals with finding spawn points and signaling minimap about units
extends Node2D

@export var unit_scene = preload("res://units/tank/tank.tscn")
signal unit_spawned
signal unit_moved


func _ready():
	for unit in get_children():
		if unit.has_node("MinimapComponent"):
			unit_spawned.emit(unit.position)
			if unit.has_node("MovementComponent"):
				unit.get_node("MinimapComponent").moved.connect( _on_unit_moved )


func _on_ui_ordered_unit_spawn(pos:Vector2):
	var unit = unit_scene.instantiate()
	add_child( unit )
	unit.position = Utils.find_free_spot_at( pos )
	unit.rotation = randf()*TAU-PI
	unit.add_to_group( 'units', true )
	unit_spawned.emit( unit.minimap_id, unit.position )


func _on_unit_moved(id, pos):
	unit_moved.emit(id, pos)
