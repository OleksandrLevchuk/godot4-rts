class_name Order

var type: String
var point: Vector2
var unit: Node

func _init( unit_or_point ):
	if unit_or_point is Node:
		type = 'unit'
		unit = unit_or_point
	else:
		type = 'point'
		point = unit_or_point
