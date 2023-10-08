extends Timer
class_name MovementComponent

## driving units can't strife sideways
@export_enum("Wheeled", "Legged") var movement_type : String = "Wheeled"
@export var MAX_SPEED : float = 200
## seconds to reach max speed
@export var ACCEL_TIME : float = 1
## seconds to turn around at full speed
@export var TURN_RATE : float = 1
@export var MINIMAP_UPDATE_RATE : float = 1
@export var SPEED_CURVE : Curve
@export var DEBUG: bool = true 

var is_turning := false
var is_accelerating := false
var is_braking := false
var velocity: Vector2
var destination: Vector2
var speed_mult := 0.0
var braking_distance : float = 0.0
var elapsed := 0.0
var velo := preload("res://components/VelocityCalc.gd").new()

@onready var line: Line2D = Line2D.new()
@onready var parent := get_owner()
@onready var prev_pos: Vector2 = parent.position

signal started_moving
signal minimap_updated
signal stopped_moving


func _ready():
	velo.halted.connect(_on_halted)
	timeout.connect(func():minimap_updated.emit(parent.position))
	if has_node("%AnimationPlayer"):
		started_moving.connect(func():%AnimationPlayer.play('drive'))
		stopped_moving.connect(%AnimationPlayer.stop)
	velocity = Vector2.ONE.rotated(parent.rotation)


func _process(delta):
	parent.velocity = velo.calc(parent.position, parent.velocity, delta)
	parent.rotation = parent.velocity.angle()
	parent.move_and_slide()


func _on_ordered_to_move(dest):
	start()
	set_process(true)
	destination = dest
	is_braking = false
	is_accelerating = true
	is_turning = true
	started_moving.emit()


func _on_halted():
	stop() # stop the minimap update timer
	minimap_updated.emit(parent.position) # update the minimap one last time
	set_process(false) # stop the _process method
	stopped_moving.emit() # notify subscribers, e.g. gather or attack components
