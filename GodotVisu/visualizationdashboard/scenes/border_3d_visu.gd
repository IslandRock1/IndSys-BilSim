extends Node2D

func drawOuterRect(squareWidth):
	var topLeft = Vector2(0, 0)
	var topRight = Vector2(1000, 0)
	var botLeft = Vector2(0, 1000)
	var botRight = Vector2(1000, 1000)
	
	var inTopLeft = Vector2(squareWidth, squareWidth)
	var inTopRight = Vector2(1000 - squareWidth, squareWidth)
	var inBotLeft = Vector2(squareWidth, 1000 - squareWidth)
	var inBotRight = Vector2(1000 - squareWidth, 1000 -squareWidth)
	
	var points = [
		topLeft, topRight, botRight, botLeft, topLeft,
		inTopLeft, inBotLeft, inBotRight, inTopRight, inTopLeft
	]
	var color = RenderingServer.get_default_clear_color()
	draw_colored_polygon(points, color)

func _draw() -> void:
	drawOuterRect(50)
	
	var basePoints = []
	var radius = 100.0
	var scale = 100.0
	for a in range(0, scale * PI / 2):
		
		var angle = float(a) / scale
		var x = sin(angle) * radius
		var y = cos(angle) * radius
		var p = Vector2(x, y)
		
		basePoints.append(p)
	
	var angle = PI / 2
	var x = sin(angle) * radius
	var y = cos(angle) * radius
	basePoints.append(Vector2(x, y))
	
	var points = []
	
	var radiusVec = Vector2(radius, radius)
	var botRight = Vector2(1000, 1000) - radiusVec
	var botLeft = Vector2(radius, 1000 - radius)
	
	var topLeft = Vector2(radius, radius)
	var topRight = Vector2(1000 - radius, radius)

	for p in basePoints:
		points.append(botRight + p)
	
	basePoints.reverse()
	for p in basePoints:
		points.append(topRight + p * Vector2(1, -1))
	
	basePoints.reverse()
	for p in basePoints:
		points.append(topLeft + p * -1)
	
	basePoints.reverse()
	for p in basePoints:
		points.append(botLeft + p * Vector2(-1, 1))
	basePoints.reverse()
	
	points.append(points[0])
	
	var newPoints = []
	
	var sizeVec = Vector2(500, 500)
	points.reverse()
	for p in points:
		var newP = (p - sizeVec) * 0.9 + sizeVec
		newPoints.append(newP)
	
	points.reverse()
	for p in newPoints:
		points.append(p)
	
	
	draw_colored_polygon(points, Color.BLUE)


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	show_behind_parent = true
	z_index = 10


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
