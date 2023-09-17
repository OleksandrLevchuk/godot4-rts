extends StaticBody2D

var units_gathering := 0


func _on_hitbox_body_entered( body:PhysicsBody2D ):
	if body.is_in_group('units'):
		if units_gathering == 0:
			create_tween().tween_property( $bar, 'value', $bar.value-1, $timer.wait_time )
			$timer.start()
		units_gathering += 1

func _on_hitbox_body_exited( body:PhysicsBody2D ):
	if body.is_in_group('units'):
		units_gathering -= 1
		if units_gathering == 0:
			$timer.stop()

func _on_timer_timeout():
	print($bar.value)
	create_tween().tween_property( $bar, 'value', $bar.value - units_gathering, $timer.wait_time )
	if $bar.value < 1:
		Game.Crystals += 1
		queue_free()
