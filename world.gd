extends Node2D

var select_start : Vector2


func _input(event:InputEvent):
	if event.is_action_pressed("quit"):
		get_tree().quit()
	elif event.is_action_pressed("left_click"):
		select_start = get_global_mouse_position()
	elif event.is_action_released('left_click'):
		for unit in get_tree().get_nodes_in_group('selected'):
			unit.deselect()
		var select_end := get_global_mouse_position()
		for unit in Utils.units_in_rect(get_world_2d(),select_start,select_end):
			if unit.collider.has_node("%SelectionComponent"):
				unit.collider.get_node('%SelectionComponent').select()
