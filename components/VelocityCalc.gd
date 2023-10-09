var MAX_SPEED: float
var ACCEL_TIME: float
var TURN_RATE: float

var unit: Node
var position: Vector2
var destination: Vector2
var facing: Vector2
var velocity: Vector2
var elapsed: float = 0

var is_moving: bool = false
var is_accelerating: bool = false
var is_braking: bool = false
var is_turning: bool = false

signal arrived


func _init( unit ):
	MAX_SPEED = unit.MAX_SPEED
	ACCEL_TIME = unit.ACCEL_TIME
	TURN_RATE = unit.TURN_RATE


func start(pos: Vector2, vel: Vector2, dest: Vector2):
	position = pos
	destination = dest
	facing = vel.normalized()
	velocity = vel
	is_accelerating = true
	is_turning = true
	is_moving = true


func calc(delta):
	if is_turning:
		var facing_wanted: Vector2 = (destination-position).normalized()
		# cross product sign is positive for clock-wise angles
		var which_side: float = sign( facing.cross( facing_wanted ) )
		# increment
		var new_facing: Vector2 = facing.rotated( delta/TURN_RATE * PI * which_side )
		# dot product is higher for similar angles
		if facing.dot(facing_wanted) < facing.dot(new_facing):
			facing = new_facing
		else:
			is_turning = false
			facing = facing_wanted

	if is_accelerating:
		elapsed += delta
		if elapsed > ACCEL_TIME:
			elapsed = ACCEL_TIME
			is_accelerating = false
		velocity = facing * elapsed/ACCEL_TIME * MAX_SPEED

	return velocity
