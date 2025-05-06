extends Label


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	
	var rpm = round(Global.udpEngineRPM / 10) / 10
	text = str(rpm)
	position = Vector2(-size.x * 1.5, size.y * 0.5)

	add_theme_color_override("font_color", Global.textColor)
