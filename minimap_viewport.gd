extends SubViewport

const UPDATE_RATE := 0.5
const MARKER_TYPES := {
	'unit' = preload("res://tank_sprite.tscn"),
	'object' = preload("res://crystal_sprite.tscn"),
	'building' = preload("res://factory_sprite.tscn"),
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

func move_camera(zoom, pos):
	
#func update_minimap():
#	for marker in markers:
#	for unit in $units.get_children():
#		var unit_sprite := tank.instantiate()
#		$units.add_child(unit_sprite)
#		unit_sprite.position = unit.position

#func _ready():
#	update_minimap()

#func _process(delta):
#	if elapsed < UPDATE_RATE: 
#		elapsed += delta
#	else:
#		update_minimap()
#		elapsed = 0.0 

#	var cameraWorld = get_tree().get_root().get_node('world/camera')
	$camera.zoom = zoom
	$camera.position = pos
