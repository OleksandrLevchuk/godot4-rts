extends Node

var Crystals = 0
var Units_gathering = 0
@onready var units_node :Node2D = get_tree().get_root().get_node('world/units')

#func spawn_unit(): # unit, pos ):
#	get_tree().get_root().get_node('world/ui').add_child(spawn.instantiate())
