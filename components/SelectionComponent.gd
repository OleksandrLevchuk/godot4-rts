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


func _ready():
	get_parent().mouse_entered.connect(select)
	get_parent().mouse_exited.connect(deselect)
	var size = main_sprite.texture.get_size()
	var new_scale = 0.1 + ( size.x + size.y ) / 5000
	selectbox.scale.x = new_scale
	selectbox.scale.y = new_scale

	if health_component:
		selected.connect(health_component._on_selected)
		deselected.connect(health_component._on_deselected)

#func _process(_delta):

func select():
	set_selected(true)
	selected.emit()


func deselect():
	set_selected(false)
	deselected.emit()


func set_selected(value:bool):
	is_selected = value
	selectbox.visible = value
