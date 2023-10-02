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
