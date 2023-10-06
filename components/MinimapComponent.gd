extends Node
class_name MinimapComponent

@export_enum("Object", "Unit", "Building") var minimap_marker_type : String


func _ready():
	Game.minimap.add_marker(self)
