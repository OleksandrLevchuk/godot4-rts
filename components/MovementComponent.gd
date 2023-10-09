extends Timer
class_name MovementComponent

var velo := preload("res://components/VelocityCalc.gd").new()

@onready var parent = get_owner()

signal arrived
signal map_moved

func _ready():
	velo.arrived.connect(_on_arrived)


func _process(delta):
	parent.velocity = velo.calc(delta)
	parent.move_and_slide()


func _on_ordered_to_move( dest ):
	velo.init( parent.position, parent.rotation, dest )
	set_process(true) # enable the process method


func _on_arrived():
	arrived.emit()
	map_moved.emit()
	set_process(false) # disable the process method
