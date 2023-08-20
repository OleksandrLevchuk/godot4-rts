extends CharacterBody2D

@export var selected = false
@onready var box = get_node('selectbox')

func set_selected(value):
	if value: print('selected!')
	box.visible = value
