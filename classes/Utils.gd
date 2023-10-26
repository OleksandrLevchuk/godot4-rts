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


static func curve( percent:float, points:Array ):
#	if points is Array and points.size()==2:
		return cubic_bezier(percent, points[0], points[1]).y
#	elif points is Vector2:
#		return quadratic_bezier(percent, Vector2.ZERO, points, Vector2.ONE)

# Vector2.ONE * x is the same as Vector2(x,x)
# Rect2(start,end-start).abs() creates a proper rect, regardless where the points are
# randf()*TAU-PI gives a random angle
# velocity = Vector2( cos(rotation), sin(rotation) ) * MAX_SPEED


static func area_is_free(origin, radius, unit_array):
	var area = Rect2(origin,Vector2.ZERO).grow(radius)
	for unit in unit_array:
		if area.has_point(unit.position): return false
	return true


const AREA_SIZE = 50
static func find_free_spot_at(area_center):
	# prefetch these - we'll need to reuse them a lot in a loop
	var unit_array = Game.get_tree().get_nodes_in_group('units')
	for offset in INF: # to infinity and beyond!
		var point = area_center + offset * Vector2.ONE * (randf()*2-1)
		if area_is_free(point, AREA_SIZE, unit_array): return point
