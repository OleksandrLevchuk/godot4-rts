class_name Dot

static func make( pos ):
	var dot = Polygon2D.new()
	var scale: float = 3
	dot.set_polygon(PackedVector2Array([
		Vector2.RIGHT*scale,
		Vector2.DOWN*scale,
		Vector2.LEFT*scale,
		Vector2.UP*scale,
	]))
	dot.color = Color.AQUA
	dot.offset = pos
	return dot
