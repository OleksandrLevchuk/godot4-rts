extends Node

signal update_ui

@onready var minimap := get_tree().get_root().get_node("/root/World/UI").get_node("Minimap/Viewport")


var Crystals := 0: 
	set(x): 
		Crystals=x
		update_ui.emit()

var Energy := 0:
	set(x):
		Energy = x
		update_ui.emit()


func connect_to_minimap( unit ) -> int:
	return minimap.add_marker( unit )
