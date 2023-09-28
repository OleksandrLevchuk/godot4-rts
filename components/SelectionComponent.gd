extends Node2D
class_name SelectionComponent

@export var main_sprite : Sprite2D
@export var collider : CollisionShape2D
@export var health_component : HealthComponent
## just adds corners to the selection triangle visual
@export var is_movable : bool

@onready var select_sprite := $TransformParent/SelectionSprite
@onready var hover_sprite := $TransformParent/HoverSprite
@onready var movable_sprite := $TransformParent/MovableSprite

var is_selected := false

signal selected
signal deselected


func _ready():
	var size = main_sprite.texture.get_size()
	var new_scale = 0.2 + ( size.x + size.y ) / 4000
	for sprite in [select_sprite, hover_sprite, movable_sprite]:
		sprite.visible = false
		sprite.scale = Vector2( new_scale, new_scale)
		
	get_parent().mouse_entered.connect(hover)
	get_parent().mouse_exited.connect(unhover)

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
	if is_movable:
		movable_sprite.visible = value
