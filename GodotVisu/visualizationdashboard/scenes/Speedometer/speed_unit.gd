extends Label


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:	
	position = Vector2(-size.x / 2, -size.y * 0.5)

	add_theme_color_override("font_color", Global.textColor)
