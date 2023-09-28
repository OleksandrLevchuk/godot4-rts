extends Node2D
class_name MovementComponent

## driving units can't strife sideways
@export var is_driving : bool
## pixels per frame i guess :D
@export var MAX_SPEED : float
## seconds to reach max speed
@export var ACCELERATION_TIME : float
## seconds to turn around at full speed
@export var TURN_RATE := 1.0
## how often to update the minimap marker
@export var REFRESH_RATE := 1.0
## these are bezier curve points
@export var SPEED_CURVE := [ Vector2(0.0, 1.2), Vector2(0.2, 0.5) ]
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

signal moved


func _ready():
	TURN_RATE *= PI # because.


func _input(event):
	if event.is_action_released('right_click') and $SelectionComponent.is_selected :
		destination = get_global_mouse_position()
		is_moving = true
		is_turning = true
		is_accelerating = accel_percent < 1
		animation.play('drive')


func _physics_process(delta):
	print(position,parent.position)
	if not is_moving: 
		return

	if is_accelerating:
		accel_percent += delta/ACCELERATION_TIME
		if accel_percent > 1:
			accel_percent = 1
			is_accelerating = false
		acceleration = Utils.curve( accel_percent, SPEED_CURVE )
	elif is_decelerating:
		accel_percent -= delta/ACCELERATION_TIME * 2 # break twice as fast

	# currently, the tank will only turn once per order, 
	# and will not recalculate it's agle if it's shifted by something
	if is_turning:
		var desired_angle = position.angle_to_point(destination)
		var difference = asin( sin( desired_angle - rotation ) ) # this also works... less readable but probably faster
		var angle_increase = TURN_RATE * delta * sign(difference) * acceleration**2
		if abs(difference) > angle_increase: # turn gradually if we're facing off
			rotation = wrap(rotation+angle_increase,-PI,PI) # rotates in the direction of the difference
		else: # snap to the exact angle needed if we're near it, and stop turning
			rotation = desired_angle
			is_turning = false

	if elapsed < REFRESH_RATE:
		elapsed += delta
	else:
#		moved.emit( minimap_id, position )
		elapsed = 0.0

	if position.distance_to( destination ) < 15: # we've arrived, let's stop
		is_moving = false
		accel_percent = 0.0
		animation.stop()

	parent.velocity = Vector2.RIGHT.rotated(rotation) * MAX_SPEED * acceleration
	parent.move_and_slide()
