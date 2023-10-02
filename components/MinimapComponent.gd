extends Node2D
class_name MinimapComponent

@export_enum("Object", "Unit", "Building") var minimap_marker_type : String
@export var is_moving : bool
@export var minimap_update_rate : float = 1.0

@onready var parent = get_parent()

var update_counter : float = 0.0

signal moved
signal died


func _ready():
	Game.minimap.add_marker(self)
	if not is_moving: # if the unit is immovable
		set_process(false) # don't ever update its minimap position


func _process(delta):
	update_counter += delta
	if update_counter > minimap_update_rate:
		update_counter = 0.0
		moved.emit(parent.position)


func _on_health_component_died():
	died.emit()
