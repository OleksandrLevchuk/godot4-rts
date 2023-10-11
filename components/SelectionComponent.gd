extends Node2D
class_name SelectionComponent

@onready var select_sprite : Sprite2D = $Selection
@onready var hover_sprite : Sprite2D = $Hover
@onready var movable_sprite : Sprite2D = $Movable

@onready var parent := get_owner()
@onready var main_sprite : Sprite2D = parent.get_node('Sprite2D')
@onready var collider : CollisionShape2D = parent.get_node('CollisionShape2D')
@onready var can_move := parent.has_node('%MovementComponent')

var is_selected := false

signal selected
signal deselected


func _ready():
#	print(parent)
	# scale the selection sprites according to the main sprite size
#	var size = Vector2( 0.5, 0.5 )
	var size = main_sprite.texture.get_size()
	var new_scale = 0.2 + min( size.x, size.y ) / 4000
	for sprite in [select_sprite, hover_sprite, movable_sprite]:
		sprite.visible = false
		sprite.scale = Vector2( new_scale, new_scale)
	# connect all the signals needed
#	parent.mouse_entered.connect(func():hover_sprite.visible=true)
#	parent.mouse_exited.connect(func():hover_sprite.visible=false)
	if has_node('%ControllerComponent'):
		selected.connect(%ControllerComponent._on_selected)
		deselected.connect(%ControllerComponent._on_deselected)
	if has_node('%HealthComponent'):
		selected.connect(%HealthComponent._on_selected)
		deselected.connect(%HealthComponent._on_deselected)


func select():
	add_to_group('selected')
	set_selected(true)
	selected.emit()


func deselect():
	remove_from_group('selected')
	set_selected(false)
	deselected.emit()


func set_selected(value:bool):
	is_selected = value
	select_sprite.visible = value
	if can_move:
		movable_sprite.visible = value
