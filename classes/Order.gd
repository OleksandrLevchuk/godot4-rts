class_name Order

var type: String
var point: Vector2
var unit: Node

func _init( arg ):
	if arg is Node:
		type = 'unit'
		unit = arg
	elif arg is String and arg == "turret test":
		type = "turret test"
	else:
		type = 'point'
		point = arg
