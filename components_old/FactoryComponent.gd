extends Node2D
class_name FactoryComponent

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


#@onready var spawn_dialog := preload("res://ui/unit_spawn_dialog.tscn")
#var is_hovered := false
#signal selected


#func _ready():
#	selected.connect( get_parent()._on_selected )


#func _input( event:InputEvent ):
#	if not event.is_action_released("left_click"): return
#	if is_hovered:
#		$selectbox.visible = true
#		selected.emit(position, spawn_dialog)
#	else:
#		$selectbox.visible = false



#this node deals with finding spawn points and signaling minimap about units
#extends Node2D
#
#@export var unit_scene = preload("res://scenes/units/tank.tscn")
#signal unit_spawned
#signal unit_moved
#
#
#func _on_ui_ordered_unit_spawn(pos:Vector2):
#	var unit = unit_scene.instantiate()
#	add_child( unit )
#	unit.position = Utils.find_free_spot_at( pos )
#	unit.rotation = randf()*TAU-PI
#	unit.add_to_group( 'units', true )
#	unit_spawned.emit( unit.minimap_id, unit.position )
