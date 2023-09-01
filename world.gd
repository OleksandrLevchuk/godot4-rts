extends Node2D

@export_exp_easing var transition_speed = 0.7
@export var col :Color = Color(1,0,0)

var select_start :Vector2
var test_table :Dictionary = {
	value1 = 'one',
	value2 = 'two'
}


func _ready():
	for k in {key1='one',key2='two'}:
		print(k)
		
func _process(delta):
	transition_speed += delta
		
func _input(event):
	if event is InputEventMouseMotion: return
	if Input.is_action_pressed("quit"): get_tree().quit()
	elif Input.is_action_just_pressed('left_click'):
		select_start = get_global_mouse_position()
	elif Input.is_action_just_released('left_click'):
		var select_rect = Rect2(select_start,Vector2.ZERO).expand(get_global_mouse_position())
		for unit in get_tree().get_nodes_in_group('units'):
			unit.set_selected(select_rect.has_point(unit.position))
