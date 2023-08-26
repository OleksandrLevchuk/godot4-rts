extends StaticBody2D

var total_time = 5
var current_time
@export var units = 0
@onready var bar = $ProgressBar
@onready var timer = $Timer

func _ready():
	current_time = total_time
	bar.max_value = total_time

func _process(_delta):
	if current_time <= 0:
		end_gathering()

func _on_hitbox_body_entered(body):
	if 'tank' in body.name:
		if units == 0: start_gathering()
		units += 1
		Game.Units_gathering += 1

func _on_hitbox_body_exited(body):
	if 'tank' in body.name:
		units -= 1
		Game.Units_gathering -= 1
		if units == 0: timer.stop()
		
func start_gathering():
	timer.start()
	
func _on_timer_timeout():
	current_time -= units
	var tween = get_tree().create_tween()
	tween.tween_property( bar, 'value', current_time, 0.5 ).set_trans(Tween.TRANS_CIRC)

func end_gathering():
	Game.Crystals += 1
	queue_free()
