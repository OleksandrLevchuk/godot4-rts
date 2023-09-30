extends Node2D
class_name MinimapComponent

@export_enum("Resource", "Unit", "Building") var minimap_marker_type : String
@export var is_moving : bool 
## only for moving units
@export var minimap_update_rate : float = 1.0
## ui node with a minimap to send signals to
@export var ui_node : Node

@onready var parent = get_parent()
@onready var minimap_id : int = Game.get_new_minimap_id(moved, died)

var update_counter : float = 0.0

signal moved
signal died


# figure out how to disable this for immovable units
func _process(delta):
	update_counter += delta
	if update_counter > minimap_update_rate:
		update_counter = 0.0
		moved.emit(minimap_id, parent.position)


func _on_health_component_died():
	died.emit(minimap_id)