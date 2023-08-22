extends CharacterBody2D

@export var selected = false
@onready var box = get_node('selectbox')

func set_selected(value):
	box.visible = value

var follow_cursor = false
var speed = 50
var target

func _input(event):
	if event.is_action_pressed('right_click'):
		follow_cursor = true
	if event.is_action_released('right_click'):
		follow_cursor = false
		
func _physics_process(_delta):
	if follow_cursor == true:
		if selected:
			target = get_global_mouse_position()
	velocity = position.direction_to(target) * speed
	if position.distance_to(target) > 15:
		move_and_slide()
	else:
		pass
