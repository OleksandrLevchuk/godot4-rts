extends StaticBody2D
var is_hovered = false
var is_selected = false
@onready var selectbox = $selectbox

func _input(event:InputEvent):
	if not event.is_action_released("left_click"): return
	if is_hovered:
		is_selected = true
		selectbox.visible = true
		Game.create_unit_spawn_dialog(position)
	else:
		is_selected = false
		selectbox.visible = false
		
func _on_mouse_exited():
	is_hovered = false
	
func _on_mouse_entered():
	is_hovered = true
