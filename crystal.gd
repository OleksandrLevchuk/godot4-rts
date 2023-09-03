extends StaticBody2D

var total_time = 5
var current_time
var units := 0

func _ready():
	current_time = total_time
	$bar.max_value = total_time

func _on_hitbox_body_entered( body:CharacterBody2D ):
	if body.is_in_group('units'):
		if units == 0:
			$timer.start()
		units += 1
		Game.Units_gathering += 1

func _on_hitbox_body_exited( body:CharacterBody2D ):
	if body.is_in_group('units'):
		units -= 1
		Game.Units_gathering -= 1
		if units == 0:
			$timer.stop()
		
func _on_timer_timeout():
	current_time -= units
	create_tween().tween_property( $bar, 'value', current_time, 0.5 )
	if current_time == 0:
		Game.Crystals += 1
		queue_free()
