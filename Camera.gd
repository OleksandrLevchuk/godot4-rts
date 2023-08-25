extends Camera2D

@export var speed = 20
@export var zoom_speed = 20
@export var zoom_margin = 0.1
@export var zoom_min = 0.5
@export var zoom_max = 3

func _process(delta):
	var input = Vector2( Input.get_axis("ui_left", "ui_right"), Input.get_axis("ui_up","ui_down") )
	position = position.lerp( position + input * speed, speed * delta ) # maybe there's a better way of doing this with velocity and move_and_slide
