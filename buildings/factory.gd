extends StaticBody2D

var is_hovered := false
signal show_spawn_dialog

func _input(event:InputEvent):
	if not event.is_action_released("left_click"): return
	if is_hovered:
		$selectbox.visible = true
		show_spawn_dialog.emit(position)
	else:
		$selectbox.visible = false
		
func _on_mouse_exited():
	is_hovered = false
	
func _on_mouse_entered():
	is_hovered = true
