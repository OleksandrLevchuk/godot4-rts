extends Node2D
#@onready var center = get_viewport().get_visible_rect().size/2
#var target = Vector2.ZERO
#var color = Color(1,1,0)
#
#func _draw():
#	target = get_local_mouse_position()
#	draw_line(center,center.lerp(target,2),color)
#
#func _process(_delta):
#	queue_redraw()
