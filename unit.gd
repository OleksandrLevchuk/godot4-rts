extends CharacterBody2D

@onready var box = get_node('selectbox')
@onready var animation = get_node('AnimationPlayer')
@onready var destination = position
@export var is_selected = false
var is_moving = false
var is_rotating = false
var max_speed = 200
var rotation_speed = PI / 1 # how many seconds it takes to do a 180 degrees turn
var desired_rotation = 0
var rotation_threshold = deg_to_rad( 1 )

func _ready():
	animation.speed_scale = 2.0
	set_selected(is_selected)

func set_selected(value):
	is_selected = value
	box.visible = value

func _input(event):
	if event.is_action_pressed('right_click'):
		destination = get_global_mouse_position()
		is_moving = true
		is_rotating = true
		animation.play('drive')
		
func get_rotation_direction(start_angle: float, target_angle: float) -> int:
	var diff = target_angle - start_angle
	return sign(diff) if abs(diff) < PI else -sign(diff)
	
func _physics_process(delta):
	if not is_moving: # no orders has been given yet
		return # so do nothing
	desired_rotation = position.angle_to_point(destination)
	var difference = wrapf( desired_rotation - rotation, -PI, PI ) # wrapf allows subtracting angles without bugs
#	var difference = asin(sin(rotation-desired_rotation)) # this also should work ???
	if abs( difference ) > deg_to_rad( 1 ): # if the difference is too big
		rotation = wrapf( rotation + rotation_speed * delta * sign(difference), -PI, PI ) # rotates in the direction of the difference
	velocity = Vector2( cos(rotation), sin(rotation) ) * max_speed
	move_and_slide()
	if position.distance_to(destination) < 25: # we've arrived, let's stop
		is_moving = false
		animation.stop()
