extends Label

@onready var panel = get_node('../selectbox')
@onready var unit = get_node("../../Units/unit")
@onready var camera = get_node('../../Camera')
	
func _process(_delta):
	var dict = { 
		'viewport rect size': get_viewport().get_visible_rect().size,
		'mouse coords': get_global_mouse_position(),
		'selection position': panel.position,
		'selection size': panel.size,
		'camera coords': camera.position,
		'camera zoom': camera.zoom,
		'unit coords': unit.position,
		'unit speed': unit.velocity,
		'unit angle': rad_to_deg(unit.rotation),
	}
	var s = ''
	for key in dict:
		s += key + ': ' + str(dict[key]) + ',\n'
	text = s
