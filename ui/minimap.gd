extends SubViewport

const ZOOM_MULTIPLIER := 0.1
@export var MARKER_TYPES := {
	'Unit' = preload("res://ui/minimap_markers/unit_marker.tscn"),
	'Object' = preload("res://ui/minimap_markers/object_marker.tscn"),
	'Building' = preload("res://ui/minimap_markers/building_marker.tscn"),
}

## we will store all minimap markers here
var markers=[]
@onready var camera := $Camera


func add_marker(unit):
	if unit.is_moving:
		unit.moved.connect(move_marker)
	unit.died.connect(remove_marker)
	var type = unit.minimap_marker_type
	var sprite = MARKER_TYPES[type].instantiate()
	get_node(type + 's').add_child(sprite)
	sprite.position = unit.get_parent().position
	markers.append(sprite)
	# return an id to be used in signal emissions
	return markers.size() - 1 


func move_marker(id, pos):
	markers[id].position = pos


func remove_marker(id):
	markers[id].queue_free()
	markers[id] = null


func _on_camera_moved(pos):
	camera.position = pos


func _on_camera_zoomed(zoom):
	camera.zoom = zoom * ZOOM_MULTIPLIER
