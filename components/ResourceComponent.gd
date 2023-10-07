extends ProgressBar
class_name ResourceComponent

@export_enum("Energy") var type : String
@export var 

@onready var timer := %Timer

signal depleted
signal resource_given


func _on_body_entered(body):
	if not body.has_node('%GathererComponent'): return
	print('entered ', body)
		timer.start()
	units_gathering += 1


func _on_body_exited(body):
	if not body.has_node('%GathererComponent'): return
	units_gathering -= 1
	if units_gathering == 0:
		timer.stop()


func _on_gather(amount, callback):
	resource_left
	pass
