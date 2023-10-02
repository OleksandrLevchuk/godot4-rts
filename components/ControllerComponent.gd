extends Node2D
class_name ControllerComponent

@onready var movement := get_parent().get_node('MovementComponent')

signal ordered_to_move
signal ordered_to_attack


func _ready():
	set_process_input(false)	
	if movement:
		ordered_to_move.connect(movement._on_ordered_to_move)


func _input(event):
	if event.is_action_released('right_click'):
		ordered_to_move.emit(get_global_mouse_position())


func _on_selected():
	set_process_input(true)


func _on_deselected():
	set_process_input(false)
