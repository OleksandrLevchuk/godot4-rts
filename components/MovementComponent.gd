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

var is_turning := false
var is_accelerating := false
var is_braking := false
var velocity : Vector2
var destination : Vector2
var speed_mult := 0.0
var braking_distance : float = 0.0
var elapsed := 0.0

@onready var parent := get_owner()
@onready var prev_pos : Vector2 = parent.position

signal started_moving
signal map_moved
signal stopped_moving


func _ready():
	timeout.connect(func():map_moved.emit(parent.position))
	if has_node("%AnimationPlayer"):
		started_moving.connect(func():%AnimationPlayer.play('drive'))
		stopped_moving.connect(%AnimationPlayer.stop)
	velocity = Vector2.ONE.rotated(parent.rotation)


func _process(delta):
	if is_accelerating:
		elapsed += delta
		if elapsed > ACCEL_TIME:
			is_accelerating = false
		braking_distance += parent.position.distance_to(prev_pos)
		print(braking_distance)
		prev_pos = parent.position
		speed_mult = SPEED_CURVE.sample_baked(elapsed/ACCEL_TIME)
		velocity = velocity.normalized() * MAX_SPEED * speed_mult
		parent.velocity = velocity

	elif is_braking:
		elapsed -= delta
		if elapsed < 0:
			is_braking = false
			set_process(false)
			stopped_moving.emit()
			map_moved.emit(parent.position)
			stop()
		speed_mult = SPEED_CURVE.sample_baked(elapsed/ACCEL_TIME)
		velocity = velocity.normalized() * MAX_SPEED * speed_mult
		parent.velocity = velocity

	if is_turning:
		if velocity == Vector2.ZERO:
			velocity = Vector2.RIGHT.rotated(parent.rotation) / 999
		var facing: Vector2 = velocity.normalized()
		var facing_wanted: Vector2 = (destination-parent.position).normalized()
		var which_side: float = sign(facing.cross( facing_wanted ))
		velocity = velocity.rotated(delta/TURN_RATE * PI * which_side)
		if facing.dot(facing_wanted) > facing.dot(velocity.normalized()):
			is_turning = false
			velocity = facing_wanted * velocity.length()
		parent.rotation = velocity.angle()
		parent.velocity = velocity
		
	if not is_braking and parent.position.distance_to(destination)<braking_distance:
		braking_distance = 0.0
		is_accelerating = false
		is_braking = true
		
	parent.move_and_slide()


func _on_ordered_to_move(dest):
	start()
	set_process(true)
	destination = dest
	is_braking = false
	is_accelerating = true
	is_turning = true
	started_moving.emit()
