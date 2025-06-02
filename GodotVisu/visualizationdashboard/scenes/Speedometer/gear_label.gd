extends Label


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	position = Vector2(250, 150)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	var value = roundi(Global.udpGear)
	if value == 0:
		text = "N"
	elif value == 10:
		text = "R"
	else:
		text = str(value)

	add_theme_color_override("font_color", Global.textColor)
