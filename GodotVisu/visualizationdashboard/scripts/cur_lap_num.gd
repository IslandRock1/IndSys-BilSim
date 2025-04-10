extends Label


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	text = str(roundi(Global.udpCurrentLapNumber)) + "/" + str(roundi(Global.udpNumberOfLaps))
	position = Vector2(-size.x / 2, 200)
	
	add_theme_color_override("font_color", Global.textColor)
