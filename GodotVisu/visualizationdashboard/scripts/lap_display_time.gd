extends Label

func _process(_delta: float) -> void:
	
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
	
	text = tmpText
	add_theme_color_override("font_color", Global.textColor)
