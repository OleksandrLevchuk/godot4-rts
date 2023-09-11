extends SubViewport

const UPDATE_RATE := 0.5
const MARKER_TYPES := {
	'unit' = preload("res://minimap_markers/unit_marker.tscn"),
	'object' = preload("res://minimap_markers/object_marker.tscn"),
	'building' = preload("res://minimap_markers/building_marker.tscn"),
}

var elapsed := 0.0
var markers :Array

func add_marker(type, id, pos):
	var sprite :Node = MARKER_TYPES[type].instantiate()
	get_node(type + 's').add_child(sprite)
	sprite.position = pos
	markers.append( sprite )

func move_marker(id, pos):
	markers[id].position = pos

func update_camera(zoom, pos):
	$camera.zoom = zoom
	$camera.position = pos
#	var cameraWorld = get_tree().get_root().get_node('world/camera')

