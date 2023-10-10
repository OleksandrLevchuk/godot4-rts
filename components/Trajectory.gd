var VelocityCalc = preload("res://components/VelocityCalc.gd")
var velo: RefCounted
var line: Line2D
var dots: Node2D


func _init( unit ):
	print( unit, ' has been sent to the trajectory script')
	velo = VelocityCalc.new( unit )
	line = Line2D.new()
	line.top_level = true
	line.width = 1
	unit.add_child(line)
	dots = Node2D.new()
	line.add_child(dots)
	


func draw( unit, dest ):
	var point = unit.parent.position
	line.clear_points()
	for dot in line.get_children():
		dot.queue_free()
	line.add_point( point )
	velo.start( unit, dest )
	var delta: float = 0.1
	var velocity: Vector2 = velo.calc(delta)
	while velocity != Vector2.ZERO:
		velocity = velo.calc(delta)
		point += velocity * delta
		line.add_child( Dot.make( point ) )
		line.add_point( point )
	print("drawign ended")
