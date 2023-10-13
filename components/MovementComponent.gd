extends Timer
class_name MovementComponent

## how many pixels it traverses per second at most
@export var MAX_SPEED: float = 200
## how many seconds it takes to reach max speed
@export var ACCEL_TIME: float = 1.5
## how many degrees it can turn per second
@export var TURN_RATE: float = PI / 3
@export var SPEED_CURVE: Curve

var is_moving: bool = false

@onready var parent := get_owner()
#@onready var line: RefCounted = preload("res://components/movement/Trajectory.gd").new(self)
@onready var velocity_calculator: RefCounted = preload("res://components/movement/VelocityCalculator.gd").new(self)

signal departed
signal arrived
signal map_updated


func _ready():
	set_process(false)
	velocity_calculator.arrived.connect(_on_arrived)


func _process(delta):
	velocity_calculator.calculate(delta)
	parent.velocity = velocity_calculator.velocity
	parent.rotation = velocity_calculator.facing.angle()
	parent.move_and_slide()


func _on_arrived():
	print(self, ' arrived')
	arrived.emit()
	set_process(false)
	stop() # the minimap update timer


func _on_ordered_to_move( dest ):
	print(self, ' departed')
	departed.emit()
	velocity_calculator.start( self, dest )
#	line.draw( self, dest )
	set_process( true )
	start() # the minimap update timer
