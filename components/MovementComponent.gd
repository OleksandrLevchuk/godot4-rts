extends Node2D
class_name MovementComponent

## driving units can't strife sideways
#@export var is_driving : bool
@export_enum("Wheeled", "Legged") var movement_type : String = "Wheeled"
## pixels per frame i guess :D
@export var MAX_SPEED : float = 200
## seconds to reach max speed
@export var ACCEL_TIME : float = 1
## seconds to turn around at full speed
@export var TURN_RATE : float = 3
## how often to update the minimap marker
@export var REFRESH_RATE : float = 1
## these are bezier curve points
@export var SPEED_CURVE : Curve
#@export var SPEED_CURVE := [ Vector2(0.0, 1.2), Vector2(0.2, 0.5) ]
@export var animation : AnimationPlayer
@export var selection : SelectionComponent

var is_moving := false
var is_turning := false
var is_accelerating := false
var is_braking := false
var velocity : Vector2
var destination : Vector2
var speed_mult := 0.0
var braking_distance : float = 0.0
var elapsed := 0.0

@onready var parent := get_parent()

signal started_moving
signal ended_moving


func _ready():
	velocity = Vector2.ONE.rotated(parent.rotation)
	if animation:
		started_moving.connect(func():animation.play('drive'))
		ended_moving.connect(animation.stop)


func _input(event):
	if event.is_action_released('right_click') and selection.is_selected :
		destination = get_global_mouse_position()
		print(destination)
		is_braking = false
		is_moving = true
		is_accelerating = true
		is_turning = true
		started_moving.emit()

func _process(delta):
	if not is_moving:
		return
		
	if is_accelerating: # braking counts as acceleration too!
		elapsed += delta * ( -1 if is_braking else 1 )
		speed_mult = clamp(0, SPEED_CURVE.sample_baked(elapsed/ACCEL_TIME), 1)
		if speed_mult == 1:
			is_accelerating = false
		elif speed_mult == 0:
			is_braking = false
			is_turning = false
			is_accelerating = false
			is_moving = false
		velocity = velocity.normalized() * MAX_SPEED * speed_mult
		braking_distance = velocity.length() * ACCEL_TIME
		parent.velocity = velocity
		
	if is_turning:
		var facing: Vector2 = velocity.normalized()
		var facing_wanted: Vector2 = (destination-parent.position).normalized()
		var which_side: float = sign(facing.cross( facing_wanted ))
		velocity = velocity.rotated(delta/TURN_RATE * PI * which_side)
		if facing.dot(facing_wanted) > facing.dot(velocity.normalized()):
			is_turning = false
			velocity = facing_wanted * velocity.length()
			print("the needed angle is reached")
		parent.rotation = velocity.angle()
		parent.velocity = velocity
		
	var distance = parent.position.distance_to(destination)
	print(distance)
	if not is_braking and distance<braking_distance:
		print('braking!')
		is_accelerating = true
		is_braking = true
		
	parent.move_and_slide()

'''
	if not is_moving:
		return
	if is_accelerating:
		elapsed += delta
		speed_mult = SPEED_CURVE.sample_baked(elapsed/ACCEL_TIME)
		if elapsed > ACCEL_TIME:
			is_accelerating = false
			print('reached max speed')
		parent.velocity = parent.velocity.normalized() * MAX_SPEED * speed_mult
	elif is_braking:
		elapsed -= delta
		speed_mult = SPEED_CURVE.sample_baked(elapsed/ACCEL_TIME)
		if elapsed < 0:
			is_braking = false
			print('finished moving!')
		parent.velocity = parent.velocity.normalized() * MAX_SPEED * speed_mult
#	parent.velocity = Vector2.RIGHT.rotated(parent.rotation) * MAX_SPEED
	if is_turning:
#		var direction = parent.position.direction_to( destination )
		var which_side = sign(parent.velocity.cross(destination-parent.position))
		var angle = delta # TURN_RATE*PI*delta*which_side
		print('is turning by ', angle)
		parent.velocity.rotated( angle )
#		if direction.dot
	parent.move_and_slide()
'''


'''
func old_physics_process(delta):
	if not is_moving: 
		return
	if is_accelerating:
		elapsed += delta * ( -2 if is_decelerating else 1 )
		print('is accelerating ', elapsed)
		if elapsed > ACCEL_TIME:
			acceleration = 1
			is_accelerating = false
		elif is_decelerating and elapsed < 0:
			is_decelerating = false
			is_moving = false
			acceleration = 0
			ended_moving.emit()
		else:
			acceleration = SPEED_CURVE.sample_baked( elapsed/ACCEL_TIME )
		braking_distance = MAX_SPEED * acceleration * 5
		parent.velocity = parent.velocity.normalized() * MAX_SPEED*acceleration

	if is_turning:
		print('is turning')
		var angle_increase = TURN_RATE * delta * acceleration**2 * PI
		var desired_angle = parent.position.angle_to_point(destination)
		var difference = asin( sin( desired_angle - rotation ) ) 
		var which_side = sign( difference )
		if abs(difference) > angle_increase: 
			parent.rotation = wrap(rotation+angle_increase*which_side,-PI,PI)
			parent.velocity = parent.velocity.rotated(angle_increase*which_side)
		else: # snap to the exact angle needed if we're near it, and stop turnin
			parent.rotation = desired_angle
			parent.velocity = parent.position.direction_to(destination) * parent.velocity.mag
			is_turning = false

	if parent.position.distance_to( destination ) < braking_distance:
		is_accelerating = true
		is_decelerating = true

	parent.move_and_slide()
'''
