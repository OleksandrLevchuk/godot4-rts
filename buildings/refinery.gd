extends StaticBody2D

const max_time :int = 50
var time :int = 0

func _ready():
	time = max_time
	$bar.max_value = max_time
	$timer.start()

func _on_timer_timeout():
	time -= 1
	get_tree().create_tween().tween_property($bar,'value',time,0.1)
	if time==0: 
		Game.Energy += 1
		_ready()
