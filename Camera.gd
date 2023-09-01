extends Camera2D

@export var zoom_min = 0.5
@export var zoom_max = 3
@export var zoom_speed := 8.0
@export var easing := 0.4 #how many secons it takes for camera to zoom and pan
@export var pan_speed := 80.0 #pixels(?) per second

var is_panning := false
var is_zooming := false
var pan_target :Vector2
var zoom_factor := 1.0


func _process(delta):
	var pan_input := Vector2( 
		Input.get_axis("ui_left","ui_right"),
		Input.get_axis("ui_up","ui_down"))
	if pan_input.x or pan_input.y:
		is_panning = true
		pan_target = position + pan_input * pan_speed
		print(pan_target)
	if is_panning:
		position = position.lerp( pan_target, delta / easing )
		if position.distance_to(pan_target) < 2 : is_panning = false
		
	if not is_zooming: return
	var zoom_before = zoom.x #save it for position calculation later
	zoom = zoom.lerp( zoom_factor * Vector2.ONE, delta / easing ) #never ends
	if abs(zoom.x-zoom_factor) < 0.001: #so, force it to end
		zoom = Vector2.ONE * zoom_factor #snap to the precise zoom value
		is_zooming = false #this section is kinda lame idk
	#nudge camera back to cursor by the amount it slid away while zooming
	position = position.lerp(get_global_mouse_position(),zoom.x/zoom_before-1)


func _input(event:InputEvent):
	var zoom_direction := Input.get_axis('wheel_up', 'wheel_down')
	if not zoom_direction: return
	zoom_factor += zoom_factor ** 1.5 * zoom_direction * zoom_speed * 0.01
	zoom_factor = clamp(zoom_factor, zoom_min, zoom_max)
	if abs(zoom.x-zoom_factor) < 0.01: return
	is_zooming = true
