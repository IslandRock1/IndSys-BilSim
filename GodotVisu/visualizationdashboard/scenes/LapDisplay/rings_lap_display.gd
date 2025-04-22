extends Node2D

func _ready() -> void:
	z_index = 20
	
	for child in get_parent().get_children():
		if (child.name == "LapDisplayTime"):
			child.z_index = 25
		elif (child.name == "curLapNum"):
			child.z_index = 25

func drawRect(size0, size1, radius):
	var rect = Rect2(-size0 / 2, -size1 / 2, size0, size1)
	var styleBox = StyleBoxFlat.new()
	styleBox.set_corner_radius_all(radius)
	styleBox.bg_color = Global.colorBackgroundBoxes
	draw_style_box(styleBox, rect)

func drawOuterBorder(start, width):
	var innerSize = start - width
	
	draw_circle(Vector2.ZERO, start, Color.BLACK)
	draw_circle(Vector2.ZERO, innerSize, Global.colorBackgroundBoxes)
	return innerSize

func drawOuterProgressBar(start, width):
	var dist = Global.udpCurrentLapDist + Global.udpCurrentLapNumber * Global.udpTrackDistance
	var progress = 2 * PI * dist / Global.udpTrackDistance + PI / 2
	draw_arc(Vector2.ZERO, start - width / 2, PI / 2, progress, 100, Color.MEDIUM_SEA_GREEN, width)

	return start - width

func drawMiddleBorder(start, width):
	var end = start - width
	
	draw_circle(Vector2.ZERO, start, Color.BLACK)
	draw_circle(Vector2.ZERO, end, Global.colorWhite)
	
	return end

func drawInnerProgressBar(start, width):
	var progress = 2 * PI * Global.udpNumberOfLaps * Global.udpCurrentLapDist / Global.udpTrackDistance + PI / 2
	
	draw_arc(Vector2.ZERO, start - width / 2, PI / 2, progress, 100, Color.SEA_GREEN, width)
	return start - width

func editTimeLabel():
	var timeSeconds = fmod(Global.udpCurrentLaptime, 60.0)
	var timeMinutes = floori(Global.udpCurrentLaptime / 60)
	
	var tmpText = ""
	if timeMinutes < 10:
		tmpText = "0"
	
	tmpText += str(timeMinutes)
	tmpText += ":"
	
	if timeSeconds < 10:
		tmpText += "0"
	
	tmpText += str(floori(timeSeconds))
	
	var children = get_parent().get_children()
	var label
	for child in children:
		if child.name == "LapDisplayTime":
			label = child
	
	label.text = tmpText
	# add_theme_color_override("font_color", Global.textColor)

func _draw() -> void:
	# drawRect(3200.0, 2700.0, 60.0)
	
	var start = 2700 / 2.1
	
	start = drawOuterBorder(start, 15)
	start = drawOuterProgressBar(start, 80)
	start = drawOuterBorder(start, 15)
	start = drawInnerProgressBar(start, 80)
	start = drawMiddleBorder(start, 10)
	drawRect(800, 800, 60)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	queue_redraw()
	editTimeLabel()
