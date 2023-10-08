extends ProgressBar
class_name ResourceComponent

@export_enum("Energy") var type : String
@export var RESOURCE_MAX := 10

var resource_left := RESOURCE_MAX

signal depleted


func _on_gather( amount: int, callback: Callable):
	if resource_left>amount:
		resource_left -= amount
	else:
		amount = resource_left
		resource_left = 0
		depleted.emit()
	callback.call(amount)
	create_tween().tween_property(self,'value',resource_left,0.5)
