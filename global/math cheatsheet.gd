# to find angle and distance between two points, just do: point B - point A
# vector addition is projection: v1 + v2 * x is the same as v1.lerp(v1+v2,x)
# Vector2.ONE * x is the same as Vector2(x,x)
# Rect2(start,end-start).abs() creates a proper rect, regardless where the points are
# randf()*TAU-PI gives a random angle
# velocity = Vector2( cos(rotation), sin(rotation) ) * MAX_SPEED
