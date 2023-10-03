extends Node2D
class_name AttackComponent

@export var DAMAGE : int = 5
@export var COOLDOWN : float = 2
var target : Node2D

signal attacked


func attack():
	print("attacking this ", target)
	attacked.emit(DAMAGE)
	get_tree().create_timer(COOLDOWN).timeout.connect(attack)


func _on_ordered_to_attack( unit ):
	print("ordered to attack this ", unit)
	if unit==target: return
	target = unit
	attacked.connect(target.get_node("HealthComponent").take_damage)
	attack()
