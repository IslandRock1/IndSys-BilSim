extends Node2D


func _draw() -> void:
	
	var rect = Rect2(-200, -150, 400, 300)
	var styleBox = StyleBoxFlat.new()
	styleBox.set_corner_radius_all(60.0)
	styleBox.bg_color = Color(0.4, 0.4, 0.4)
	draw_style_box(styleBox, rect)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
