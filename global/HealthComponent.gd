extends Node2D
class_name HealthComponent

@export var bar : ProgressBar
@export var MAX_HEALTH := 5
var health : int


func _ready():
	bar.max_value = MAX_HEALTH
	bar.value = MAX_HEALTH
	health = MAX_HEALTH

func damage( dmg ):
	health -= dmg
	create_tween().tween_property( bar, 'value', health, 0.5 )
	if health <= 0:
		Game.Crystals += 1
		get_parent().queue_free()
