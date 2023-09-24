extends StaticBody2D

@onready var spawn_dialog := preload("res://ui/unit_spawn_dialog.tscn")
var is_hovered := false
signal selected

func _ready():
	selected.connect(get_parent()._on_selected)


func _input(event:InputEvent):
	if not event.is_action_released("left_click"): return
	if is_hovered:
		$selectbox.visible = true
		selected.emit(position, spawn_dialog)
	else:
		$selectbox.visible = false
		
func _on_mouse_exited():
	is_hovered = false
	
func _on_mouse_entered():
	is_hovered = true
