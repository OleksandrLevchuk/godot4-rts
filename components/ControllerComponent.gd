extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _input(event):
	if event.is_action_released('right_click') and selection.is_selected :
		destination = get_global_mouse_position()
		print(destination)
		is_braking = false
		is_moving = true
		is_accelerating = true
		is_turning = true
		started_moving.emit()
