extends Node2D
class_name SelectionComponent

@export var selectbox : Node
@export var collider : CollisionShape2D
@export var healthbar : ProgressBar

var is_selected := false


func select():
	set_selected(true)


func deselect():
	set_selected(false)


func set_selected(value:bool):
	is_selected = value
	selectbox.visible = value
	if healthbar:
		healthbar.visible = value
