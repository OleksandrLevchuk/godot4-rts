extends StaticBody2D

var time := 0

func _on_timer_timeout():
	time += 1
	create_tween().tween_property($bar,'value',time,$timer.wait_time)
	if time==$bar.max_value:
		time = 0
		Game.Energy += 1
