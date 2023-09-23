extends Node2D

const COLOR1 := Color.MEDIUM_SPRING_GREEN # this color is opaque
const COLOR2 := Color(Color.PURPLE,0) # alpha zero means transparent
const FADE_TIME := 0.5
const CIRCLE_SIZE := 20.0

var target :Vector2
var fade_percent := 0.0
var is_fading := false


func _draw():
	draw_circle( target, CIRCLE_SIZE*fade_percent, COLOR1.lerp(COLOR2, fade_percent) )

func _process(delta):
	if Input.is_action_just_pressed("right_click"):
		target = get_global_mouse_position()
		is_fading = true
		fade_percent = 0
	if is_fading:
		fade_percent = fade_percent + delta / FADE_TIME
		queue_redraw()
		if fade_percent>1: is_fading = false
