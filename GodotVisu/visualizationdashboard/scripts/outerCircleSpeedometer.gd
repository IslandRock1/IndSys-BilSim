extends Node2D

func _draw() -> void:
	var radius = 470.0
	var borderSize = 10.0
	
	var squareSideRadius = (radius + borderSize + 20.0)
	
	var rect = Rect2(-squareSideRadius, -squareSideRadius, squareSideRadius * 2, squareSideRadius * 2)
	var styleBox = StyleBoxFlat.new()
	styleBox.set_corner_radius_all(60.0)
	styleBox.bg_color = Color(0.4, 0.4, 0.4)
	draw_style_box(styleBox, rect)
	
	draw_circle(Vector2.ZERO, radius + borderSize, Global.speedometerBorderColor)
	draw_circle(Vector2.ZERO, radius, Global.speedometerBGColor)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
