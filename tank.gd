extends CharacterBody2D

const MAX_SPEED := 200
const ACCELERATION_TIME := 6 # seconds to reach max speed

@onready var destination = position
var is_selected := false
var is_moving := false
var is_turning := false
var accel_mult := 0.0
var rotation_speed = PI / 1 # how many seconds it takes to do a 180 degrees turn
var minimap_id

func _ready():
	$animation.speed_scale = 2.0
	add_to_group('units', true)
	minimap_id = Game.get_new_minimap_id()

func set_selected(value):
	is_selected = value
	$selectbox.visible = value

func _input(event):
	if is_selected and event.is_action_released('right_click'):
		destination = get_global_mouse_position()
		is_moving = true
		is_turning = true
#		create_tween().tween_property(self, 'accel_mult', 1.0, ACCELERATION_TIME)
		$animation.play('drive')

func _physics_process(delta):
	if not is_moving: return # no orders has been given yet
	accel_mult += delta/ACCELERATION_TIME
	accel_mult = min( 1.0, accel_mult )
	# the tank accelerates hard at first, losing the acceleration with time
	var accel_mult_eased = lerp( 0.2, 2-accel_mult, accel_mult ) 
	print( accel_mult_eased )
	if is_turning: # currently, the tank will only turn once per order, and will not recalculate it's agle if it's shifted by something
		var desired_angle = position.angle_to_point(destination)
		var difference = asin( sin( desired_angle - rotation ) ) # this also works... less readable but probably faster
		var angle_increase = rotation_speed * delta * sign(difference) * accel_mult_eased
		if abs(difference) > angle_increase: # turn gradually if we're facing off
			rotation = wrap(rotation+angle_increase,-PI,PI) # rotates in the direction of the difference
		else: # snap to the exact angle needed if we're near it, and stop turning
			rotation = desired_angle
			# to find angle from position to destination, just subtract O_O
#			velocity = (destination-position).normalized() * MAX_SPEED * accel_mult
			is_turning = false
	velocity = Vector2.RIGHT.rotated(rotation) * MAX_SPEED * accel_mult_eased
	move_and_slide()
	if position.distance_to(destination) < 15: # we've arrived, let's stop
		is_moving = false
		accel_mult = 0.0
		print('stopping',accel_mult)
		$animation.stop()
