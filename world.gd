extends Node2D

var select_start :Vector2

func _input(event):
	if event is InputEventMouseMotion: return
	if Input.is_action_pressed("quit"): get_tree().quit()
	elif Input.is_action_just_pressed('left_click'):
		select_start = get_global_mouse_position()
	elif Input.is_action_just_released('left_click'):
		var select_rect = Rect2(select_start,Vector2.ZERO).expand(get_global_mouse_position())
		for unit in get_tree().get_nodes_in_group('units'):
			unit.set_selected(select_rect.has_point(unit.position))
