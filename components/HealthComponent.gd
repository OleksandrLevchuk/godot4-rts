extends Node2D
class_name HealthComponent

@export var MAX_HEALTH : int = 5

@onready var health_bar := $HPBarParent/HealthBar
var health : int

signal died


func _ready():
	health_bar.max_value = MAX_HEALTH
	health_bar.value = MAX_HEALTH
	health = MAX_HEALTH


func take_damage( dmg ):
	health -= dmg
	create_tween().tween_property( health_bar, 'value', health, 0.5 )
	if health <= 0:
		died.emit()
		await get_tree().create_timer(1).timeout
		get_parent().queue_free()


func _on_selected():
	health_bar.visible = true


func _on_deselected():
	health_bar.visible = false
