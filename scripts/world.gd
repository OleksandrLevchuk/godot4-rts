extends Node2D

var select_start :Vector2
var select_rectangle := RectangleShape2D.new()
var selected :Array


func _input(event:InputEvent):
	if event.is_action_pressed("quit"):
		get_tree().quit()
	elif event.is_action_pressed("left_click"):
		select_start = get_global_mouse_position()
	elif event.is_action_released('left_click'):
		var select_end := get_global_mouse_position()
		select_rectangle.extents = (select_end - select_start) / 2
		var query := PhysicsShapeQueryParameters2D.new()
		query.set_shape(select_rectangle)
		query.transform = Transform2D( 0, (select_end+select_start)/2)
		for unit in selected:
			unit.collider.set_selected(false)
		selected = get_world_2d().direct_space_state.intersect_shape(query)
		for unit in selected:
			unit.collider.set_selected()
#		var select_rect := Rect2(select_start, select_end-select_start).abs()
#		for unit in get_tree().get_nodes_in_group('units'):
#			unit.set_selected( select_rect.has_point( unit.position ) )
