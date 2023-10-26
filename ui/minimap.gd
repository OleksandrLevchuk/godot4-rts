extends SubViewport

@export var minimap_marker : PackedScene

@onready var camera: Camera2D = get_node('Camera')


func add_marker(unit):
	var marker = minimap_marker.instantiate()
	get_node(unit.minimap_marker_type + 's').add_child( marker )
	marker.get_node(unit.minimap_marker_type).visible = true
	if unit.has_node("%MovementComponent"):
		unit.get_node("%MovementComponent").minimap_updated.connect(marker.set_position)
	if unit.has_node("%HealthComponent"):
		unit.get_node("%HealthComponent").died.connect(marker.queue_free)
	marker.position = unit.get_owner().position
