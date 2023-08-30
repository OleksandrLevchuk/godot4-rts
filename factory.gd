extends StaticBody2D

#     var mouse_entered = false
@onready var selectbox = $selectbox

func _input(event):
	print('input')

func _on_mouse_exited():
	print('exited!')
	
func _on_mouse_entered():
	print('entered!')
	UnitSpawnDialog.new(self.position)
