#this node deals with finding spawn points and signaling minimap about units
extends Node2D

@export var unit_scene = preload("res://units/tank/tank.tscn")
signal unit_spawned
signal unit_moved


func _on_ui_ordered_unit_spawn(pos:Vector2):
	var unit = unit_scene.instantiate()
	add_child( unit )
	unit.position = Utils.find_free_spot_at( pos )
	unit.rotation = randf()*TAU-PI
	unit.add_to_group( 'units', true )
	unit_spawned.emit( unit.minimap_id, unit.position )
