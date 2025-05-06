extends Node2D

func drawOuterBox(sizeX, sizeY, radius) -> void:
	var rect = Rect2(-sizeX / 2, -sizeY / 2, sizeX, sizeY)
	var styleBox = StyleBoxFlat.new()
	styleBox.set_corner_radius_all(radius)
	styleBox.bg_color = Global.colorBackgroundBoxes
	draw_style_box(styleBox, rect)

func _draw() -> void:
	var radius = 2700.0 / 2.1
	var borderSize = 20.0
	
	# drawOuterBox(4800, 2700, 60)
	
	draw_circle(Vector2.ZERO, radius + borderSize, Color.BLACK)
	draw_circle(Vector2.ZERO, radius, Global.colorWhite)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
