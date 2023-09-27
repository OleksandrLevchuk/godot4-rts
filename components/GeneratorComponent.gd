extends Node2D

@export var pop : Resource

@onready var bar := $ProgressBar
@onready var timer := $Timer

func _on_timer_timeout():
	if bar.value == bar.max_value:
		Game.Energy += 1
		bar.value = 0
		add_child( pop.instantiate() )
	create_tween().tween_property(bar, 'value', bar.value+1, timer.wait_time)
