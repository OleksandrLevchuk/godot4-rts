extends StaticBody2D

func _on_timer_timeout():
	print($bar.value)
	if $bar.value == $bar.max_value:
		Game.Energy += 1
		$bar.value = 0
	create_tween().tween_property($bar,'value',$bar.value+1,$timer.wait_time)
