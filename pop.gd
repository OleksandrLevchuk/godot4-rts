extends Label

var travel :Vector2 = Vector2(0,-50)
var duration :int = 1
var spread :float = 0.2

func show_value(value,crit):
	create_tween()
	text = '+ ' + str(value)
	pivot_offset = size / 4
	var movement = travel.rotated( spread * (randf()*TAU-PI)/2 )
