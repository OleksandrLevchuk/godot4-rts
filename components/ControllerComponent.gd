extends Node2D
class_name ControllerComponent

@onready var can_attack: bool = has_node('%AttackComponent')
@onready var can_gather: bool = has_node('%GatherComponent')
@onready var can_move: bool = has_node('%MovementComponent')

signal ordered_to_move
signal ordered_to_attack
signal ordered_to_gather


func _ready():
	if can_attack:
		ordered_to_attack.connect(%AttackComponent._on_ordered_to_attack)
	if can_move:
		ordered_to_move.connect(%MovementComponent._on_ordered_to_move)
	if can_gather:
		ordered_to_gather.connect(%GatherComponent._on_ordered_to_gather)
	# at first units are unselected and can't be controlled
	set_process_input(false)


func _input(event):
	if event.is_action_released('right_click'):
		var query := PhysicsPointQueryParameters2D.new()
		query.position = get_global_mouse_position()
		var targets = get_world_2d().direct_space_state.intersect_point(query)
		for unit in targets:
			if unit.collider==get_owner(): continue
			if can_attack and unit.collider.has_node("%HealthComponent"):
				ordered_to_attack.emit(unit.collider)
				return # if a unit is found - attack, if not - move
			if can_gather and unit.collider.has_node('%GatherableComponent'):
				ordered_to_gather.emit(unit.collider)
				return
		if can_move:
			ordered_to_move.emit(get_global_mouse_position())


func _on_selected(): # enable control for selected units
	set_process_input(true) 


func _on_deselected(): # disable control for deselected units
	set_process_input(false)
