extends CharacterBody2D

@onready var box = get_node('selectbox')
@onready var animation = get_node('AnimationPlayer')
@onready var destination = position
@export var is_selected = false
var is_moving = false
var is_rotating = false
var max_speed = 200
var rotation_speed = PI / 3 # how many seconds it takes to do a 180 degrees turn

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
		
func _physics_process(_delta):
	if not is_moving: # waiting for orders
		return # so do nothing
	if position.distance_to(destination) < 15: # we've arrived, let's stop
		is_moving = false
		animation.stop()
		return # otherwise, keep moving
	if is_rotating:
		var angle_to_destination = position.angle_to_point(destination)
		rotation = rotation + deg_to_rad( randi()%3 - 1 )
		if abs( rotation - angle_to_destination ) < deg_to_rad( 5 ):
			is_rotating = false
	velocity = position.direction_to(destination) * max_speed
	move_and_slide()
