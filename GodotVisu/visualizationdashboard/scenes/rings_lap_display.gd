extends Node2D

func drawOuterRect():
	var rect = Rect2(-500, -500, 1000, 1000)
	var styleBox = StyleBoxFlat.new()
	styleBox.set_corner_radius_all(60.0)
	styleBox.bg_color = Color(0.4, 0.4, 0.4)
	draw_style_box(styleBox, rect)

func drawOuterBorder():
	draw_circle(Vector2.ZERO, 480, Global.MainColor)
	draw_circle(Vector2.ZERO, 465, Color.WHITE)

func drawOuterProgressBar():
	var progress = 2 * PI * Global.udpTotalDist / Global.udpTrackDistance + PI / 2
	var width = 40
	draw_arc(Vector2.ZERO, 465 - width / 2, PI / 2, progress, 100, Color(0, 250, 100), width)

func drawMiddleBorder():
	draw_circle(Vector2.ZERO, 425, Global.MainColor)
	draw_circle(Vector2.ZERO, 410, Color.WHITE)

func drawInnerProgressBar():
	var progress = 2 * PI * Global.udpNumberOfLaps * Global.udpCurrentLapDist / Global.udpTrackDistance + PI / 2
	var width = 40
	draw_arc(Vector2.ZERO, 410 - width / 2, PI / 2, progress, 100, Color(0, 250, 100), width)

func _draw() -> void:
	drawOuterRect()
	drawOuterBorder()
	drawOuterProgressBar()
	drawMiddleBorder()
	drawInnerProgressBar()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	queue_redraw()
