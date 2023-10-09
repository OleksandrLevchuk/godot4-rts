extends Timer
class_name MovementComponent

## how many pixels it traverses per second at most
@export var MAX_SPEED: float = 200
## how many seconds it takes to reach max speed
@export var ACCEL_TIME: float = 3
## how many degrees it can turn per second
@export var TURN_RATE: float = 90

var is_moving: bool = false

@onready var parent := get_owner()
@onready var line := preload("res://components/Trajectory.gd").new(self)
@onready var velo := preload("res://components/VelocityCalc.gd").new(self)

signal arrived
signal map_updated


func _ready():
	set_process(false)
	velo.arrived.connect(_on_arrived)


func _process(delta):
	parent.velocity = velo.calc(delta)
	parent.move_and_slide()


func _on_arrived():
	arrived.emit()
	set_process(false)
	stop() # the timer


func _on_ordered_to_move( dest ):
	var vel := Vector2.RIGHT.rotated(parent.rotation)
	velo.start( parent.position, vel, dest )
	set_process(true)
	start() # the timer
