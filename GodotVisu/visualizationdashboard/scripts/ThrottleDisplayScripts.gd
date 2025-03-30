extends Node2D

func drawRect(size0, size1, radius):
	var rect = Rect2(-size0 / 2, -size1 / 2, size0, size1)
	var styleBox = StyleBoxFlat.new()
	styleBox.set_corner_radius_all(radius)
	styleBox.bg_color = Color(0.4, 0.4, 0.4)
	draw_style_box(styleBox, rect)

func _draw() -> void:
	drawRect(1000.0, 1000.0, 60)
	draw_circle(Vector2.ZERO, 480, Color.GREEN)
	draw_circle(Vector2.ZERO, 470, Color.WHITE)
	
	draw_circle(Vector2.ZERO, 470 * Global.udpThrottle, Color.CYAN)

func _process(_delta: float) -> void:
	queue_redraw()
