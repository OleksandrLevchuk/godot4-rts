extends CharacterBody2D

@onready var box = get_node('selectbox')
@onready var animation = get_node('AnimationPlayer')
@onready var destination = position
@export var is_selected = false
var is_moving = false
var max_speed = 200
var rotation_speed = PI / 1 # how many seconds it takes to do a 180 degrees turn

func _ready():
	animation.speed_scale = 2.0
	set_selected(is_selected)

func set_selected(value):
	is_selected = value
	box.visible = value

func _input(event):
	if is_selected and event.is_action_pressed('right_click'):
		destination = get_global_mouse_position()
		is_moving = true
		animation.play('drive')

func _physics_process(delta):
	if not is_moving: return # no orders has been given yet
	var desired_rotation = position.angle_to_point(destination)
#	var difference = wrap( desired_rotation - rotation, -PI, PI ) # wrap allows subtracting angles without bugs
	var difference = asin( sin( desired_rotation - rotation ) ) # this also works... less readable but probably faster
	if abs( difference ) > deg_to_rad( 1 ): # if the difference is too big, turn the unit!
		rotation = wrap( rotation + rotation_speed * delta * sign(difference), -PI, PI ) # rotates in the direction of the difference
	velocity = Vector2( cos(rotation), sin(rotation) ) * max_speed
	move_and_slide()
	if position.distance_to(destination) < 15: # we've arrived, let's stop
		is_moving = false
		animation.stop()
