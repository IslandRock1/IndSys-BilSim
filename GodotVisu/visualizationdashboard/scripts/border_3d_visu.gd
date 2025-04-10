extends Node2D

func drawOuterRect(squareWidth):
	var topLeft = Vector2(0, 0)
	var topRight = Vector2(4800, 0)
	var botLeft = Vector2(0, 2700)
	var botRight = Vector2(4800, 2700)
	
	var inTopLeft = Vector2(squareWidth, squareWidth)
	var inTopRight = Vector2(4800 - squareWidth, squareWidth)
	var inBotLeft = Vector2(squareWidth, 2700 - squareWidth)
	var inBotRight = Vector2(4800 - squareWidth, 2700 -squareWidth)
	
	var points = [
		topLeft, topRight, botRight, botLeft, topLeft,
		inTopLeft, inBotLeft, inBotRight, inTopRight, inTopLeft
	]
	var color = RenderingServer.get_default_clear_color()
	draw_colored_polygon(points, color)

func _draw() -> void:
	# drawOuterRect(50)
	var col = RenderingServer.get_default_clear_color()
	
	var innerArc = 1200
	var innerWidth = 20
	
	var outerWidth = 3000
	var outerArc = innerArc + innerWidth / 2 + outerWidth / 2
	
	draw_arc(Vector2(4800 / 2, 2700 / 2), innerArc, 0, 2 * PI, 1000, Color.BLACK, innerWidth)
	draw_arc(Vector2(4800 / 2, 2700 / 2), outerArc, 0, 2 * PI, 1000, col, outerWidth)
	
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
	var botRight = Vector2(4800, 2700) - radiusVec
	var botLeft = Vector2(radius, 2700 - radius)
	
	var topLeft = Vector2(radius, radius)
	var topRight = Vector2(4800 - radius, radius)

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
	
	var sizeVec = Vector2(4800 / 2, 2700 / 2)
	points.reverse()
	for p in points:
		var newP = (p - sizeVec) * 0.99 + sizeVec
		newPoints.append(newP)
	
	points.reverse()
	for p in newPoints:
		points.append(p)
	
	
	# draw_colored_polygon(points, Color.BLUE)


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	show_behind_parent = true
	z_index = 10


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
