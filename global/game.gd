extends Node

signal update_ui

var Crystals := 0: 
	set(x): 
		Crystals=x
		update_ui.emit()

var Energy := 0:
	set(x):
		Energy = x
		update_ui.emit()

var new_minimap_id := -1
func get_new_minimap_id() -> int:
	new_minimap_id += 1
	return new_minimap_id
