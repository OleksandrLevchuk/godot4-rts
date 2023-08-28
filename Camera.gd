extends Camera2D

var is_panning = false
@export var easing = 0.4 # how many secons it takes for camera to zoom and pan
@export var pan_speed = 80 # pixels(?) per second
var pan_target

var is_zooming = false
@export var zoom_factor = 1
#var zoom_target
@export var zoom_speed = 8

var zoom_start_distance
var zoom_start_zoom
func _process(delta):
	var pan_input = Vector2( Input.get_axis("ui_left","ui_right"), Input.get_axis("ui_up","ui_down") )
	if not pan_input==Vector2.ZERO:
		is_panning = true
		pan_target = position.lerp(position+pan_input, pan_speed) # lerping a vector to percentages higher than 1 is kinda like projecting
	if is_panning:
		position = position.lerp( pan_target, delta / easing ) # lower value for smoother pan
		if position.distance_to(pan_target) < 2 : 
			is_panning = false
			print('ended panning')
	if is_zooming:
		var zoom_before = zoom.x
		zoom = zoom.lerp( Vector2.ONE * zoom_factor, delta / easing )
		if abs(zoom.x-zoom_factor) < 0.001:
			is_zooming = false
			zoom = Vector2.ONE * zoom_factor # snap to the precise zoom value
		# somehow, this nudges the camera back to the cursor by exactly the amount it slid away while zooming
		# insanely, this line took me hours to figure out
		position = position.lerp( get_global_mouse_position(), zoom.x/zoom_before - 1 )

func to_screen ( pos : Vector2 ) -> Vector2 :
	return get_canvas_transform().affine_inverse().basis_xform( pos )

@export var zoom_min = 0.5
@export var zoom_max = 3
func _input(event):
	if not (event.is_action_pressed('wheel_up') or event.is_action_pressed('wheel_down')): return
	zoom_factor += Input.get_axis('wheel_up', 'wheel_down') * zoom_speed * 0.01 * zoom_factor ** 1.5
	zoom_factor = clamp(zoom_factor, zoom_min, zoom_max)
	if abs(zoom.x-zoom_factor) < 0.01: return
	if not is_zooming:
		zoom_start_distance = position.distance_to(get_global_mouse_position())
		zoom_start_zoom = zoom.x
	is_zooming = true
