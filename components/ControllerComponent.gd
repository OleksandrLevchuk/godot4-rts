extends Node2D
class_name ControllerComponent

@onready var attack_comp : Node

signal ordered_to_move
signal ordered_to_attack


func _ready():
	var parent = get_parent()
	if parent.has_node('AttackComponent'):
		attack_comp = parent.get_node('AttackComponent')
		ordered_to_attack.connect(attack_comp._on_ordered_to_attack)
	var move_cmpnt := parent.get_node('MovementComponent')
	if move_cmpnt:
		ordered_to_move.connect(move_cmpnt._on_ordered_to_move)
	# at first units are unselected and can't be controlled
	set_process_input(false)


func _input(event):
	if event.is_action_released('right_click'):
		if attack_comp:
			var query := PhysicsPointQueryParameters2D.new()
			query.position = get_global_mouse_position()
			var targets = get_world_2d().direct_space_state.intersect_point(query)
			for unit in targets:
				if unit.collider.has_node("HealthComponent"):
					ordered_to_attack.emit(unit.collider)
					return 
		ordered_to_move.emit(get_global_mouse_position())


func _on_selected(): # enable control for selected units
	set_process_input(true) 


func _on_deselected(): # disable control for deselected units
	set_process_input(false)
