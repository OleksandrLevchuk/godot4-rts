var MAX_SPEED: float
var ACCEL_TIME: float
var TURN_RATE: float
var SPEED_CURVE: Curve

var position: Vector2
var destination: Vector2
var facing: Vector2
var velocity: Vector2

var braking_distance: float = 0.0
var elapsed: float = 0.0

var is_moving: bool = false
var is_accelerating: bool = false
var is_braking: bool = false
var is_turning: bool = false

signal arrived


func _init( unit ):
	MAX_SPEED = unit.MAX_SPEED
	ACCEL_TIME = unit.ACCEL_TIME
	TURN_RATE = unit.TURN_RATE
	SPEED_CURVE = unit.SPEED_CURVE


func start( unit, dest ):
	position = unit.parent.position
	destination = dest
	velocity = unit.parent.velocity
	if velocity.is_zero_approx():
		facing = Vector2.RIGHT.rotated(unit.parent.rotation) 
	else:
		facing = velocity.normalized()
	is_accelerating = true
	is_turning = true
	is_moving = true


func calc(delta):
	if is_turning:
		var facing_wanted: Vector2 = (destination-position).normalized()
		# cross product sign is positive for clock-wise angles
		var which_side: float = sign( facing.cross( facing_wanted ) )
		# increment
		var new_facing: Vector2 = facing.rotated( TURN_RATE * delta*which_side )
		# dot product is higher for similar angles
		if facing.dot(facing_wanted) < facing.dot(new_facing):
			facing = new_facing
		else:
			is_turning = false
			facing = facing_wanted

	if is_accelerating:
		elapsed += delta
		velocity = facing * elapsed/ACCEL_TIME * MAX_SPEED
		if elapsed > ACCEL_TIME:
			velocity = facing * MAX_SPEED
			is_accelerating = false
		braking_distance = elapsed/ACCEL_TIME * MAX_SPEED * ACCEL_TIME * 0.5
		print(braking_distance)

	elif is_braking:
		elapsed -= delta
		if elapsed > 0:
			velocity = facing * elapsed/ACCEL_TIME * MAX_SPEED
		else:
			velocity = Vector2.ZERO
			is_braking = false
			arrived.emit()

	position += velocity * delta
	if not is_braking and braking_distance > position.distance_to(destination):
		is_accelerating = false
		is_braking = true

	return velocity
