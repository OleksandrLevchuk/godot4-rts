extends Node2D
@onready var center = get_viewport().get_visible_rect().size/2
var target = Vector2.ZERO
const color1 = Color.MEDIUM_SPRING_GREEN
const color2 = Color(Color.PURPLE,0)
const fade_time = 0.5
var fade_percent = 0
var is_fading = false

func _draw():
	draw_circle(target, 20*fade_percent, color1.lerp(color2,fade_percent))

func _process(delta):
	if Input.is_action_just_pressed("right_click"):
		target = get_global_mouse_position()
		print('circle position is ', target)
		is_fading = true
		fade_percent = 0
	if is_fading:
		fade_percent = fade_percent + delta / fade_time
		queue_redraw()
		if fade_percent>1: is_fading = false
