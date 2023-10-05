extends Node2D
class_name MinimapComponent

@export_enum("Object", "Unit", "Building") var minimap_marker_type : String
@export var minimap_update_rate : float = 1.0
@onready var can_move : bool = has_node("%MovementComponent")

var update_counter : float = 0.0

signal moved
signal died


func _ready():
	Game.minimap.add_marker(self)
	if not can_move: # if the unit is immovable
		set_process(false) # don't ever update its minimap position


func _process(delta):
	update_counter += delta
	if update_counter > minimap_update_rate:
		update_counter = 0.0
		moved.emit(get_parent().position)


func _on_health_component_died():
	died.emit()
