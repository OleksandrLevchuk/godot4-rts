extends Label

const LENGTH := 50
const TIME := 2
const SPREAD := 0.2
var destination := Vector2(0,0-LENGTH).rotated(SPREAD*(randf()*TAU-PI))

func _ready():
	var tween = create_tween()
	position = position + destination # by adding this twice we kinda project it
	tween.tween_property(self,'modulate:a', 0, TIME)
	tween.set_parallel(true)
	tween.tween_property(self,'position', position + destination, TIME)
	tween.set_parallel(false)
	tween.tween_callback(queue_free)
	# this section seems overblown but whatever, i guess
