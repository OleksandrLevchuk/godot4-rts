extends Node2D
class_name SelectionComponent

@export var main_sprite : Sprite2D
@export var collider : CollisionShape2D

@onready var parent := get_parent()
@onready var is_movable := parent.has_node('MovementComponent')
@onready var select_sprite := $Transform/Selection
@onready var hover_sprite := $Transform/Hover
@onready var movable_sprite := $Transform/Movable # adds corners to selection

var is_selected := false

signal selected
signal deselected


func _ready():
	# scale the selection sprites according to the main sprite size
	var size = main_sprite.texture.get_size()
	var new_scale = 0.2 + min( size.x, size.y ) / 4000
	for sprite in [select_sprite, hover_sprite, movable_sprite]:
		sprite.visible = false
		sprite.scale = Vector2( new_scale, new_scale)
	# connect all the signals needed
	parent.mouse_entered.connect(func():hover_sprite.visible=true)
	parent.mouse_exited.connect(func():hover_sprite.visible=false)
	if parent.has_node('ControllerComponent'):
		selected.connect(parent.get_node('ControllerComponent')._on_selected)
		deselected.connect(parent.get_node('ControllerComponent')._on_deselected)
	if parent.has_node('HealthComponent'):
		selected.connect(parent.get_node('HealthComponent')._on_selected)
		deselected.connect(parent.get_node('HealthComponent')._on_deselected)


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
