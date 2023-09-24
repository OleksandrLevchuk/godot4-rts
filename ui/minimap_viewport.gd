extends SubViewport

const UPDATE_RATE := 0.5
const ZOOM_MULTIPLIER := 0.1
const MARKER_TYPES := {
	unit = preload("res://ui/minimap_markers/unit_marker.tscn"),
	object = preload("res://ui/minimap_markers/object_marker.tscn"),
	building = preload("res://ui/minimap_markers/building_marker.tscn"),
}

var elapsed := 0.0
var markers=[]


func add_marker(type, pos):
	var sprite = MARKER_TYPES[type].instantiate()
	get_node(type + 's').add_child(sprite)
	sprite.position = pos
	markers.append(sprite)


func move_marker(id, pos):
	markers[id].position = pos


func move_camera(pos):
	$camera.position = pos


func zoom_camera(zoom):
	$camera.zoom = zoom * ZOOM_MULTIPLIER
