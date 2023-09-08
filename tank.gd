extends CharacterBody2D

const MAX_SPEED := 200
const ACCELERATION_TIME := 1 # seconds to reach max speed

@onready var destination = position
var is_selected := false
var is_moving := false
var is_turning := false
var is_accelerating := false
var is_decelerating := false
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
		is_accelerating = accel_mult < 1
		$animation.play('drive')

func cubic_bezier( t:float, a:=0, b:=1.23, c:=0.2, d=0.52 ):
	var p0 = Vector2.ZERO
	var p1 = Vector2(a,b)
	var p2 = Vector2(c,d)
	var p3 = Vector2.ONE
	
	var q0 = p0.lerp(p1, t)
	var q1 = p1.lerp(p2, t)
	var q2 = p2.lerp(p3, t)

	var r0 = q0.lerp(q1, t)
	var r1 = q1.lerp(q2, t)
	return r0.lerp(r1, t).y


func _physics_process(delta):
	if not is_moving: return # no orders has been given yet
	var accel_mult_eased = 1
	if is_accelerating:
		accel_mult += delta/ACCELERATION_TIME
		if accel_mult > 1:
			accel_mult = 1
			is_accelerating = false
		# the tank accelerates hard at first, losing the acceleration with time
		accel_mult_eased = cubic_bezier( accel_mult )
		print( accel_mult, ' -> ', accel_mult_eased )
#		accel_mult_eased = lerp( 0.2, 2-accel_mult, accel_mult )
	if is_decelerating:
		accel_mult -= delta/ACCELERATION_TIME * 2 # break twice as fast
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
