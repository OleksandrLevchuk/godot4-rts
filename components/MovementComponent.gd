extends Node2D
class_name MovementComponent

## driving units can't strife sideways
#@export var is_driving : bool
@export_enum("Wheeled", "Legged") var movement_type : String
## pixels per frame i guess :D
@export var MAX_SPEED : float
## seconds to reach max speed
@export var ACCELERATION_TIME : float
## seconds to turn around at full speed
@export var TURN_RATE := 1.0
## how often to update the minimap marker
@export var REFRESH_RATE := 1.0
## these are bezier curve points
@export var SPEED_CURVE : Curve
#@export var SPEED_CURVE := [ Vector2(0.0, 1.2), Vector2(0.2, 0.5) ]
@export var animation : AnimationPlayer
@export var selection : SelectionComponent

var is_moving := false
var is_turning := false
var is_accelerating := false
var is_decelerating := false
var accel_percent := 0.0
var acceleration := 0.0
var destination : Vector2
var breaking_distance : float
var elapsed := 0.0

@onready var parent := get_parent()

signal started_moving
signal ended_moving


func _ready():
	TURN_RATE *= PI # because.


func _input(event):
	if event.is_action_released('right_click') and selection.is_selected :
		destination = get_global_mouse_position()
		is_moving = true
		is_turning = true
		is_accelerating = accel_percent < 1
		animation.play('drive')

func _physics_process(delta):
	if not is_moving: 
		return
	if is_accelerating:
		elapsed += delta
		if elapsed > ACCELERATION_TIME:
			acceleration = 1.0
			is_accelerating = false
		else:
			acceleration = SPEED_CURVE.sample_baked( elapsed/ACCELERATION_TIME * SPEED_CURVE.get_baked_length())
		print(acceleration)

#		acceleration = Utils.curve( accel_percent, SPEED_CURVE )
#		acceleration = Vector2.ZERO.bezier_interpolate( 
#			SPEED_CURVE[0], SPEED_CURVE[1], Vector2.ONE, accel_percent ).y
	elif is_decelerating:
		accel_percent -= delta/ACCELERATION_TIME * 2 # break twice as fast

	# currently, the tank will only turn once per order, 
	# and will not recalculate it's agle if it's shifted by something
	if is_turning:
		var pos = parent.position
		var current_angle = parent.rotation
		var desired_angle = pos.angle_to_point(destination)
		# this also works... less readable but probably faster
		var difference = asin( sin( desired_angle - rotation ) ) 
		var which_side = sign( difference )
		# this is how much the tank can turn
		var angle_increase = TURN_RATE * delta * acceleration**2
		# turn gradually if we're facing off
		parent.rotation = current_angle + angle_increase * which_side
		if abs(difference) > angle_increase: 
			rotation = wrap(rotation+angle_increase,-PI,PI) # rotates in the direction of the difference
		else: # snap to the exact angle needed if we're near it, and stop turning
			rotation = desired_angle
			is_turning = false

	if position.distance_to( destination ) < 15: # we've arrived, let's stop
		is_moving = false
		accel_percent = 0.0
		animation.stop()
		set_process(false) # this code will disable this function!!!

	parent.velocity = Vector2.RIGHT.rotated(rotation) * MAX_SPEED * acceleration
	parent.move_and_slide()
