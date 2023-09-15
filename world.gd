extends Node2D

var select_start :Vector2

#func _ready():

func _input(_event):
	if Input.is_action_pressed("quit"): get_tree().quit()
	elif Input.is_action_just_pressed('left_click'):
		select_start = get_global_mouse_position()
	elif Input.is_action_just_released('left_click'):
		var selection = Rect2(select_start,get_global_mouse_position()-select_start).abs()
		for unit in get_tree().get_nodes_in_group('units'):
			unit.set_selected(selection.has_point(unit.position))
