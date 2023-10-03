extends Node2D
class_name HealthComponent

@export var MAX_HEALTH : float = 5

@onready var bars := $Bars
@onready var bar1 := $Bars/Bar1
@onready var bar2 := $Bars/Bar2
var health : float

signal died


func _ready():
	health = MAX_HEALTH
	bar1.max_value = MAX_HEALTH
	bar2.max_value = MAX_HEALTH
	bar1.value = MAX_HEALTH
	bar2.value = MAX_HEALTH
	bars.visible = false


func take_damage( dmg ):
	bars.visible=true
	get_tree().create_timer(3).timeout.connect(func():bars.visible=false)
	health -= dmg
	bar1.value = health
	create_tween().tween_property( bar2, 'value', health, 0.5 )
	if health <= 0:
		died.emit()
		await get_tree().create_timer(1).timeout
		get_parent().queue_free()


func _on_selected():
	bars.visible = true


func _on_deselected():
	bars.visible = false
