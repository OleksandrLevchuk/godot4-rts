
func calc(pos, velo, delta):
	if is_accelerating:
		elapsed += delta
		if elapsed > ACCEL_TIME:
			is_accelerating = false
		braking_distance += parent.position.distance_to(prev_pos)
		print(braking_distance)
		prev_pos = parent.position
		speed_mult = SPEED_CURVE.sample_baked(elapsed/ACCEL_TIME)
		velocity = velocity.normalized() * MAX_SPEED * speed_mult
		parent.velocity = velocity

	elif is_braking:
		elapsed -= delta
		if elapsed < 0:
			is_braking = false
			set_process(false)
			stopped_moving.emit()
			map_moved.emit(parent.position)
			stop()
		speed_mult = SPEED_CURVE.sample_baked(elapsed/ACCEL_TIME)
		velocity = velocity.normalized() * MAX_SPEED * speed_mult
		parent.velocity = velocity

	if is_turning:
		if velocity == Vector2.ZERO:
			velocity = Vector2.RIGHT.rotated(parent.rotation) / 999
		var facing: Vector2 = velocity.normalized()
		var facing_wanted: Vector2 = (destination-parent.position).normalized()
		var which_side: float = sign(facing.cross( facing_wanted ))
		velocity = velocity.rotated( delta/TURN_RATE * PI * which_side )
		if facing.dot(facing_wanted) > facing.dot(velocity.normalized()):
			is_turning = false
			velocity = facing_wanted * velocity.length()
		parent.rotation = velocity.angle()
		parent.velocity = velocity

	if not is_braking and parent.position.distance_to(destination)<braking_distance:
		braking_distance = 0.0
		is_accelerating = false
		is_braking = true
