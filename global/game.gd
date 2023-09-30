extends Node

signal update_ui

@onready var minimap := get_tree().get_root().get_node("/root/World/UI").get_node("Minimap/Viewport")


func _ready():
	print(minimap)

var Crystals := 0: 
	set(x): 
		Crystals=x
		update_ui.emit()

var Energy := 0:
	set(x):
		Energy = x
		update_ui.emit()

var new_minimap_id := -1


func get_new_minimap_id( moved:Signal, died:Signal ) -> int:
	moved.connect(minimap.move_marker)
	died.connect(minimap.remove_marker)
	new_minimap_id += 1
	return new_minimap_id
