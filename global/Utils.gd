class_name Utils

# to find angle and distance between two points, just do: point B - point A

static func project( v1: Vector2, v2: Vector2, mult: float) -> Vector2:
	# vector addition is projection: 
	return v1 + v2 * mult
	# return v1.lerp(v1+v2, mult)


static func quadratic_bezier(percent:float, point1:Vector2, point2:Vector2, point3:Vector2):
	var middle1 = point1.lerp(point2, percent) # lerping two points means finding a point in between
	var middle2 = point2.lerp(point3, percent) # lerping twice gives two points, which is a line
	return middle1.lerp(middle2, percent) # which we use to find a point in the middle again!


static func cubic_bezier( percent:float, ctrl1 : Vector2, ctrl2 : Vector2 ):
	var middle1 = Vector2.ZERO.lerp(ctrl1, percent) # this time we reduce 4 points to 3
	var middle2 = ctrl1.lerp(ctrl2, percent) # we find 3 points in between the given 4
	var middle3 = ctrl2.lerp(Vector2.ONE, percent) # and apply the quadratic to them
	return quadratic_bezier(percent, middle1, middle2, middle3) # kinda magical, no?


@warning_ignore("shadowed_global_identifier")
static func ease( percent:float, points:Array ):
#	if points is Array and points.size()==2:
		return cubic_bezier(percent, points[0], points[1]).y
#	elif points is Vector2:
#		return quadratic_bezier(percent, Vector2.ZERO, points, Vector2.ONE)

# Vector2.ONE * x is the same as Vector2(x,x)
# Rect2(start,end-start).abs() creates a proper rect, regardless where the points are
# randf()*TAU-PI gives a random angle
# velocity = Vector2( cos(rotation), sin(rotation) ) * MAX_SPEED
