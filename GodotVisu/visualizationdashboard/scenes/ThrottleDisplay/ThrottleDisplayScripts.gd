extends Node2D

func drawRect(size0, size1, radius):
	var rect = Rect2(-size0 / 2, -size1 / 2, size0, size1)
	var styleBox = StyleBoxFlat.new()
	styleBox.set_corner_radius_all(radius)
	styleBox.bg_color = Color(0.4, 0.4, 0.4)
	draw_style_box(styleBox, rect)

func drawIndicator(x, y, value):
	
	var outerSize = 300
	var innerSize = outerSize - 15
	
	draw_circle(Vector2(x, y), outerSize, Color.BLACK)
	draw_circle(Vector2(x, y), innerSize, Color.DARK_RED)
	
	draw_circle(Vector2(x, y), innerSize * value, Color.RED)

func _draw() -> void:
	# drawRect(3200.0, 2700.0, 60)
	
	var dist = 1000
	drawIndicator(0, 0, Global.udpThrottle)
	
	drawIndicator(-dist, 0, Global.udpClutchEngaement)
	drawIndicator(dist, 0, Global.udpBrakeEngagement)

func _process(_delta: float) -> void:
	queue_redraw()
