extends Node2D


func _draw() -> void:
	
	var sizeX = 1200
	var sizeY = 1200
	
	var rect = Rect2(-sizeX / 2, -sizeY / 2, sizeX, sizeY)
	var styleBox = StyleBoxFlat.new()
	styleBox.set_corner_radius_all(200.0)
	styleBox.bg_color = Global.colorBackgroundBoxes
	draw_style_box(styleBox, rect)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
