extends Camera2D

const ZOOM_MIN := 0.5
const ZOOM_MAX := 3.0
const ZOOM_SPEED := 8.0
const EASING := 0.4 #how many secons it takes for camera to zoom and pan
const PAN_SPEED := 80.0 #pixels(?) per second

var is_panning := false
var is_zooming := false
var pan_target :Vector2
var zoom_factor := 1.0

signal moved
signal zoomed


func _ready():
	moved.emit(position)
	zoomed.emit(zoom)

func _process(delta):
	var pan_input := Vector2( 
		Input.get_axis("camera_pan_left","camera_pan_right"),
		Input.get_axis("camera_pan_up","camera_pan_down"))
	if pan_input.x or pan_input.y:
		is_panning = true
		pan_target = position + pan_input * PAN_SPEED
		print(pan_target)
	if is_panning:
		position = position.lerp( pan_target, delta / EASING )
		moved.emit(position)
		if position.distance_to(pan_target) < 2 : is_panning = false
		
	if not is_zooming: return
	var zoom_before = zoom.x #save it for position calculation later
	zoom = zoom.lerp( zoom_factor * Vector2.ONE, delta / EASING ) #never ends
	if abs(zoom.x-zoom_factor) < 0.001: #hence, force it to end
		zoom = Vector2.ONE * zoom_factor #snap to the precise zoom value
		is_zooming = false #this section is kinda lame idk
	#nudge camera back to cursor by the amount it slid away while zooming
	zoomed.emit(zoom)
	position = position.lerp(get_global_mouse_position(),zoom.x/zoom_before-1)
	


func _input(_event:InputEvent):
	var zoom_direction := Input.get_axis('wheel_up', 'wheel_down')
	if not zoom_direction: return
	zoom_factor += zoom_factor ** 1.5 * zoom_direction * ZOOM_SPEED * 0.01
	zoom_factor = clamp(zoom_factor, ZOOM_MIN, ZOOM_MAX)
	if abs(zoom.x-zoom_factor) < 0.01: return
	is_zooming = true
