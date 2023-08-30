extends CharacterBody2D
class_name Tank

@onready var box =$selectbox
@onready var animation = $AnimationPlayer
@onready var destination = position
@export var is_selected = false
var is_moving = false
var is_turning = false
var max_speed = 200
var rotation_speed = PI / 1 # how many seconds it takes to do a 180 degrees turn

func _init( point:Vector2=Vector2.ZERO ):
	position = point
	
func _ready():
	animation.speed_scale = 2.0
	set_selected(is_selected)
	add_to_group('units', true)

func set_selected(value):
	is_selected = value
	box.visible = value

func _input(event):
	if is_selected and event.is_action_pressed('right_click'):
		destination = get_global_mouse_position()
		is_moving = true
		is_turning = true
		animation.play('drive')

func _physics_process(delta):
	if not is_moving: return # no orders has been given yet
	if is_turning: # currently, the tank will only turn once per order, and will not recalculate it's agle if it's shifted by something
		var desired_angle = position.angle_to_point(destination)
		# var difference = wrap( desired_angle - rotation, -PI, PI ) # wrap allows subtracting angles without bugs
		var difference = asin( sin( desired_angle - rotation ) ) # this also works... less readable but probably faster
		var angle_increase = rotation_speed * delta * sign(difference) # this is how much the tank has to turn to keep a consistent turn radius
		if abs(difference) > angle_increase: # turn gradually if we're facing off
			rotation = wrap(rotation+angle_increase,-PI,PI) # rotates in the direction of the difference
			velocity = Vector2( cos(rotation), sin(rotation) ) * max_speed
		else: # snap to the exact angle needed if we're near it, and stop turning
			rotation = desired_angle
			velocity = (destination-position).normalized() * max_speed # to find angle to destination, just subtract O_O
			is_turning = false
	move_and_slide()
	if position.distance_to(destination) < 15: # we've arrived, let's stop
		is_moving = false
		animation.stop()
