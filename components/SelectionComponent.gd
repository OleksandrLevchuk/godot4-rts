extends Node2D
class_name SelectionComponent

@export var main_sprite : Sprite2D
@export var collider : CollisionShape2D
@export var health_component : HealthComponent

@onready var select_sprite := $TransformParent/SelectionSprite
@onready var hover_sprite := $TransformParent/HoverSprite

var is_selected := false

signal selected
signal deselected


func _ready():
	get_parent().mouse_entered.connect(hover)
	get_parent().mouse_exited.connect(unhover)
	var size = main_sprite.texture.get_size()
	var new_scale = 0.1 + ( size.x + size.y ) / 5000
	select_sprite.scale = Vector2( new_scale, new_scale)
	new_scale -= 0.1
	hover_sprite.scale = Vector2( new_scale, new_scale)

	if health_component:
		selected.connect(health_component._on_selected)
		deselected.connect(health_component._on_deselected)

#func _process(_delta):


func hover():
	hover_sprite.visible = true


func unhover():
	hover_sprite.visible = false


func select():
	set_selected(true)
	selected.emit()


func deselect():
	set_selected(false)
	deselected.emit()


func set_selected(value:bool):
	is_selected = value
	select_sprite.visible = value
