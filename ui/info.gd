extends Label

@onready var panel = get_node('../selectbox')
#@onready var unit = get_node("../../Units/unit")
@onready var camera = get_node('../../Camera')
@onready var cursor_offset = get_viewport().get_visible_rect().size/2
	
func _process(_delta):
	var dict = { 
		'crystals': Game.Crystals,
		'energy': Game.Energy,
		'units gathering': Game.Units_gathering,
#		'viewport rect size': get_viewport().get_visible_rect().size,
#		'mouse coords': get_global_mouse_position(),
#		'selection position': panel.position,
#		'selection size': panel.size,
		'camera coords': camera.position,
		'camera zoom': camera.zoom,
#		'unit coords': unit.position,
#		'destination coords': unit.destination,
#		'unit velocity': unit.velocity,
#		'unit angle': rad_to_deg(unit.rotation),
#		'desired angle': rad_to_deg(unit.position.angle_to_point(unit.destination)),
#		'cursor angle': rad_to_deg(unit.position.angle_to_point(get_global_mouse_position()-cursor_offset))
	}
	var tempstr = ''
	for key in dict:
		tempstr += key + ': ' + str(dict[key]) + ',\n'
	text = tempstr.left(-2) # remove the trailing comma
