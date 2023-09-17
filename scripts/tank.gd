extends CharacterBody2D

const MAX_SPEED := 200
const ACCELERATION_TIME := 3 # seconds to reach max speed
const TURN_RATE = PI / 1 # how many seconds it takes to do a 180 degrees turn

var is_selected := false
var is_moving := false
var is_turning := false
var is_accelerating := false
var is_decelerating := false
var accel_mult := 0.0
var accel_mult_eased := 0.0
var minimap_id :int
var destination :Vector2

signal moved

func _ready():
	$animation.speed_scale = 2.0
	add_to_group('units', true)
	minimap_id = Game.get_new_minimap_id()
	print("my minimap id is ", minimap_id)

func set_selected(value:=true):
	is_selected = value
	$selectbox.visible = value
	

func _input(event):
	if is_selected and event.is_action_released('right_click'):
		destination = get_global_mouse_position()
		is_moving = true
		is_turning = true
		is_accelerating = accel_mult < 1
		$animation.play('drive')

func quadratic_bezier( t:float, p0: Vector2, p1: Vector2, p2: Vector2 ):
	var q0 = p0.lerp(p1, t) # lerping two points means finding a point in between
	var q1 = p1.lerp(p2, t) # lerping twice gives two points, which is a line
	return q0.lerp(q1, t) # which we use to find a point in the middle again!

func cubic_bezier( t:float, ctrl1:=Vector2(0, 1.2), ctrl2:=Vector2(0.2, 0.52) ):
	var middle1 = Vector2.ZERO.lerp(ctrl1, t) # this time we reduce 4 points to 3
	var middle2 = ctrl1.lerp(ctrl2, t) # we find 3 points in between the given 4
	var middle3 = ctrl2.lerp(Vector2.ONE, t) # and apply the quadratic to them
	return quadratic_bezier(t, middle1, middle2, middle3) # kinda magical, no?

func _physics_process(delta):
	if not is_moving: return # no orders has been given yet
	if is_accelerating:
		accel_mult += delta/ACCELERATION_TIME
		if accel_mult > 1:
			accel_mult = 1
			is_accelerating = false
		accel_mult_eased = cubic_bezier( accel_mult ).y
	if is_decelerating:
		accel_mult -= delta/ACCELERATION_TIME * 2 # break twice as fast
	if is_turning: # currently, the tank will only turn once per order, and will not recalculate it's agle if it's shifted by something
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
	moved.emit( minimap_id, position )
	if position.distance_to( destination ) < 15: # we've arrived, let's stop
		is_moving = false
		accel_mult = 0.0
		$animation.stop()
