extends SubViewport

const ZOOM_MULTIPLIER := 0.1
@export var minimap_marker : Resource
@onready var camera := $Camera


func add_marker(unit):
	var marker = minimap_marker.instantiate()
	get_node(unit.minimap_marker_type + 's').add_child( marker )
	marker.get_node(unit.minimap_marker_type).visible = true
	if unit.is_moving:
		unit.moved.connect(marker.set_position)
	unit.died.connect(marker.queue_free)
	marker.position = unit.get_parent().position


func _on_camera_moved(pos):
	camera.position = pos


func _on_camera_zoomed(zoom):
	camera.zoom = zoom * ZOOM_MULTIPLIER
