extends CharacterBody2D

@export var is_selected = false
@onready var box = get_node('selectbox')
@onready var anim = get_node('AnimationPlayer')
@onready var target = position
var follow_cursor = false
var speed = 100

func _ready():
	anim.speed_scale = 2.0

func set_selected(value):
	is_selected = value
	box.visible = value


func _input(event):
	if event.is_action_pressed('right_click'):
		follow_cursor = true
	if event.is_action_released('right_click'):
		follow_cursor = false
		
func _physics_process(_delta):
	if follow_cursor == true:
		if is_selected:
			target = get_global_mouse_position()
			anim.play('drive')
	velocity = position.direction_to(target) * speed
	if position.distance_to(target) > 15:
		move_and_slide()
	else:
		anim.stop()
