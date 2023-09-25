extends Node2D
class_name HealthComponent

@export var health_bar : ProgressBar
@export var MAX_HEALTH : int
var health : int


func _ready():
#	health_bar.max_value = MAX_HEALTH
#	health_bar.value = MAX_HEALTH
	health = MAX_HEALTH

func damage( dmg ):
	health -= dmg
	create_tween().tween_property( health_bar, 'value', health, 0.5 )
	if health <= 0:
		Game.Crystals += 1
		get_parent().queue_free()
