extends Timer
class_name AttackComponent

@export var DAMAGE : int = 2
var target : Node2D

signal attacked


func _ready():
	timeout.connect(attack)


func attack():
	print("attacking this ", target)
	attacked.emit(DAMAGE)


func _on_ordered_to_attack( unit ):
	print("ordered to attack this ", unit)
	if unit==target: return # prevents attack cd abuse, but only on single unit
	if target:
		attacked.disconnect(target.get_node("HealthComponent").take_damage)
		target.get_node('HealthComponent').died.disconnect(_on_target_died)
	target = unit
	attacked.connect(target.get_node("HealthComponent").take_damage)
	target.get_node('HealthComponent').died.connect(_on_target_died)
	attack()
	start()


func _on_target_died():
	target.get_node('HealthComponent').died.disconnect(_on_target_died)
	attacked.disconnect(target.get_node("HealthComponent").take_damage)
	target = null
	stop()
