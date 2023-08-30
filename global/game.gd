extends Node

var Crystals = 0
var Units_gathering = 0

@onready var spawn = preload("res://ui/spawn_unit.tscn")
func spawn_unit():
	var path = get_tree().get_root().get_node('world/ui')
	var spawn_unit = spawn.instantiate()
	path.add_child(spawn_unit)
