extends Panel

var is_dragging = false
var drag_start

func _process(_delta):
	if Input.is_action_just_pressed("left_click"):
		is_dragging = true
		drag_start = get_global_mouse_position()
	elif is_dragging:
		var rect = Rect2( drag_start, Vector2.ZERO ).expand( get_global_mouse_position() )
		position = rect.position # instead of complicated math, just use geometry!
		size = rect.size
		if Input.is_action_just_released("left_click"):
			is_dragging = false
			position = Vector2.ZERO
			size = Vector2.ZERO
