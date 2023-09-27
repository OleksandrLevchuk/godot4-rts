extends Node2D
class_name SelectionComponent

@export var main_sprite : Sprite2D
@export var collider : CollisionShape2D
@export var health_component : HealthComponent
#@export var selectbox : Node

@onready var selectbox := $Sprite2D

var is_selected := false

signal selected
signal deselected


func _init():
	if main_sprite:
		print('texture size ', main_sprite.texture.get_size())
	if health_component:
		selected.connect(health_component._on_selected)
		deselected.connect(health_component._on_deselected)


func select():
	set_selected(true)
	selected.emit()


func deselect():
	set_selected(false)
	deselected.emit()


func set_selected(value:bool):
	is_selected = value
	selectbox.visible = value
