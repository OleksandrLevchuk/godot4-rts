extends CharacterBody2D

const MAX_SPEED := 200
const ACCELERATION_TIME := 3 # seconds to reach max speed
const TURN_RATE = PI / 1 # how many seconds it takes to do a 180 degrees turn
const REFRESH_RATE := 1
const SPEED_CURVE := [ Vector2(0.0, 1.2), Vector2(0.2, 0.5) ]

var is_moving := false
var is_turning := false
var is_accelerating := false
var is_decelerating := false
var accel_mult := 0.0
var accel_mult_eased := 0.0
var destination : Vector2
var breaking_distance : float
var elapsed := 0.0

@onready var animation := $AnimationPlayer

signal moved

@onready var minimap_id : int = Game.get_new_minimap_id()

func _ready():
	animation.speed_scale = 2.0
	add_to_group('units', true)


func _input(event):
	if event.is_action_released('right_click') and $SelectionComponent.is_selected :
		destination = get_global_mouse_position()
		is_moving = true
		is_turning = true
		is_accelerating = accel_mult < 1
		animation.play('drive')


func _physics_process(delta):
#	print(position)
	if not is_moving: 
		return

	if is_accelerating:
		accel_mult += delta/ACCELERATION_TIME
		if accel_mult > 1:
			accel_mult = 1
			is_accelerating = false
		accel_mult_eased = Utils.curve( accel_mult, SPEED_CURVE )
	elif is_decelerating:
		accel_mult -= delta/ACCELERATION_TIME * 2 # break twice as fast

	# currently, the tank will only turn once per order, 
	# and will not recalculate it's agle if it's shifted by something
	if is_turning:
		var desired_angle = position.angle_to_point(destination)
		var difference = asin( sin( desired_angle - rotation ) ) # this also works... less readable but probably faster
		var angle_increase = TURN_RATE * delta * sign(difference) * accel_mult_eased**2
		if abs(difference) > angle_increase: # turn gradually if we're facing off
			rotation = wrap(rotation+angle_increase,-PI,PI) # rotates in the direction of the difference
		else: # snap to the exact angle needed if we're near it, and stop turning
			rotation = desired_angle
			is_turning = false

	velocity = Vector2.RIGHT.rotated(rotation) * MAX_SPEED * accel_mult_eased
	move_and_slide()
	if elapsed < REFRESH_RATE:
		elapsed += delta
	else:
		moved.emit( minimap_id, position )
		elapsed = 0.0

#	if position.distance_to( destination ) < 100:

	if position.distance_to( destination ) < 15: # we've arrived, let's stop
		is_moving = false
		accel_mult = 0.0
		animation.stop()
