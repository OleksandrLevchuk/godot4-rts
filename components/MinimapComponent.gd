extends Node2D
class_name MinimapComponent

@export_enum("Object", "Unit", "Building") var minimap_marker_type : String
@export var is_moving : bool
@export var minimap_update_rate : float = 1.0

@onready var parent = get_parent()
@onready var minimap_id : int = Game.connect_to_minimap(self)

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
