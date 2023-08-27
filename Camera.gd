extends Camera2D

var is_panning = false
var is_zooming = false
@export var easing = 5 # slows down camera zoom making it smoother
@export var pan_speed = 80 # pixels(?) per second
var pan_target
@export var zoom_factor = 1
var zoom_target
@export var zoom_speed = 8
@export var zoom_step = 0.5
@export var zoom_min = 0.5
@export var zoom_max = 3

func _process(delta):
	var pan_input = Vector2( Input.get_axis("ui_left","ui_right"), Input.get_axis("ui_up","ui_down") )
	if not pan_input==Vector2.ZERO:
		is_panning = true
		pan_target = position.lerp(position+pan_input, pan_speed) # lerping a vector to percentages higher than 1 is kinda like projecting
	if is_panning:
		position = position.lerp( pan_target, delta * easing ) # lower value for smoother pan
		if position.distance_to(pan_target) < 2 : 
			is_panning = false
			print('ended panning')
	if is_zooming:
		position = position.lerp( zoom_target, delta * easing ) # lower value for smoother pan
		zoom = zoom.lerp( Vector2.ONE * zoom_factor, delta * easing ) # lower number for smoother zoom
		if abs(zoom.x-zoom_factor) < 0.001:
			is_zooming = false
			print('ended zooming')

func _input(event):
	if not (event.is_action_pressed('wheel_up') or event.is_action_pressed('wheel_down')): return
	is_zooming = true
#	var cursor = get_local_mouse_position()
#	var center = get_viewport().get_visible_rect().size/2
#	var offset_strength = cursor.distance_to(center)
#	print('offset strength is', offset_strength)
#	zoom_target = position.lerp(cursor, offset_strength)
	zoom_target = position
	zoom_factor += Input.get_axis('wheel_up', 'wheel_down') * zoom_speed * 0.01 * zoom_factor ** 1.5
	zoom_factor = clamp(zoom_factor, zoom_min, zoom_max)
