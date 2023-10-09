const ACCEL_TIME: float = 3
const MAX_SPEED: float = 200

var position: Vector2
var velocity_normal: Vector2
var velocity: Vector2
var elapsed: float = 0
var is_accelerating: bool = false
var is_turning: bool = false

signal arrived


func init(pos, angle, dest):
	position = pos
	velocity_normal = Vector2.RIGHT.rotated(angle)
	is_accelerating = true
	is_turning = true


func calc(delta):
	if is_accelerating:
		elapsed += delta
		if elapsed > ACCEL_TIME:
			elapsed = ACCEL_TIME
			is_accelerating = false
		velocity = velocity_normal * elapsed/ACCEL_TIME * MAX_SPEED

#	if is_turning:
		

	return velocity
