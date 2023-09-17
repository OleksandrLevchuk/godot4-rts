extends Panel

var is_dragging := false
var drag_start :Vector2

func _process(_delta):
	if Input.is_action_just_pressed("left_click"):
		is_dragging = true
		drag_start = get_global_mouse_position()
	elif is_dragging:
		var rect := Rect2(drag_start, get_global_mouse_position()-drag_start).abs()
		position = rect.position
		size = rect.size
		if Input.is_action_just_released("left_click"):
			is_dragging = false
			position = Vector2.ZERO
			size = Vector2.ZERO
