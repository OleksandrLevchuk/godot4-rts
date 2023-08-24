extends Panel

var is_dragging = false
var drag_start = Vector2.ZERO # global coordinates are used for ui elements
var select_shape = RectangleShape2D.new()
signal area_selected # we will signal the world script to select units

func vmin(v1, v2): return Vector2( min(v1.x, v2.x), min(v1.y, v2.y) ) # effectively converts coords into rect position
#func vmax(v1, v2): return Vector2( max(v1.x, v2.x), max(v1.y, v2.y) ) # unused, but pretty <3
func vabs(v): return Vector2( abs(v.x), abs(v.y) ) # effectively converts a vector difference into rect size
#func coords2rect(v1,v2): return Rect2( vmin(v1,v2), vabs(v1-v2) ) # rect is convenient for stuffs
	
func _process(_delta):
	if Input.is_action_just_pressed("left_click"):
		is_dragging = true
		drag_start = get_global_mouse_position()
	elif is_dragging:
		var mouse = get_global_mouse_position()
		position = vmin( drag_start, mouse )
		size = vabs( drag_start - mouse )
		if Input.is_action_just_released("left_click"):
			emit_signal("area_selected", position, size )
			is_dragging = false
			position = Vector2.ZERO
			size = Vector2.ZERO
