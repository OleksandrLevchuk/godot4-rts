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
@onready var line: RefCounted = preload("res://components/Trajectory.gd").new(self)
@onready var velo: RefCounted = preload("res://components/VelocityCalc.gd").new(self)

signal arrived
signal map_updated


func _ready():
	set_process(false)
	velo.arrived.connect(_on_arrived)


func _process(delta):
	parent.velocity = velo.calc(delta)
	if parent.velocity != Vector2.ZERO:
		parent.rotation = parent.velocity.angle()
	parent.move_and_slide()


func _on_arrived():
	print('arrived')
	arrived.emit()
	set_process(false)
	stop() # the minimap update timer


func _on_ordered_to_move( dest ):
	velo.start( self, dest )
	line.draw( self, dest )
	set_process( true )
	start() # the minimap update timer
