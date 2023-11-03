extends Node

@onready var world: Node2D = get_tree().get_root().get_node('/root/World')
@onready var ui: CanvasLayer = world.get_node('UI')
@onready var minimap: SubViewport = ui.get_node('Container/Minimap')


var Crystals: int = 0: 
	set(x): 
		Crystals=x
		ui_updated.emit()

var Energy: int = 0:
	set(x):
		Energy = x
		ui_updated.emit()


var select_start : Vector2

signal ordered
signal deselected
signal ui_updated
 


func _input(event:InputEvent):
	if event.is_action_pressed("quit"):
		get_tree().quit()
	elif event.is_action_pressed("1"):
		ordered.emit( Order.new('turret test') )
	elif event.is_action_pressed("left_click"):
		select_start = world.get_global_mouse_position()
	elif event.is_action_released('left_click'):
		deselected.emit()
		var select_end := world.get_global_mouse_position()
		var select_rectangle := RectangleShape2D.new()
		select_rectangle.extents = abs(select_end - select_start) / 2
		var query := PhysicsShapeQueryParameters2D.new()
		query.set_shape(select_rectangle)
		query.transform = Transform2D( 0, (select_end + select_start)/2 )
		for unit in world.get_world_2d().direct_space_state.intersect_shape(query):
			unit.collider.select()
	elif event.is_action_released('right_click'):
		var query := PhysicsPointQueryParameters2D.new()
		var point: Vector2 = world.get_global_mouse_position()
		query.position = point
		var units = world.get_world_2d().direct_space_state.intersect_point(query)
		var order = Order.new( units[0].collider if units.size()>0 else point )
		ordered.emit( order )
