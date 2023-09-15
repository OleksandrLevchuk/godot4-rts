extends SubViewport

const UPDATE_RATE := 0.5
const ZOOM_MULTIPLIER := 0.1
const MARKER_TYPES := {
	unit = preload("res://minimap_markers/unit_marker.tscn"),
	object = preload("res://minimap_markers/object_marker.tscn"),
	building = preload("res://minimap_markers/building_marker.tscn"),
}

var elapsed := 0.0
var markers=[]

func add_marker(type, id, pos):
	var sprite = MARKER_TYPES[type].instantiate()
	print('adding ', type, ' ', id, ' ', pos)
#	print(sprite.get_type())
	print(sprite.get_class())
	get_node(type + 's').add_child(sprite)
	sprite.position = pos
	markers.append(sprite)
	print('new markers position is ', sprite.position)
	print('number of markers is ', markers.size())
	
func move_marker(id, pos):
	print('minimap is moving unit ', id, ' to position ', pos)
#	print(markers.size())
	markers[id].position = pos

func move_camera(pos):
	$camera.position = pos
	
func zoom_camera(zoom):
	$camera.zoom = zoom * ZOOM_MULTIPLIER
