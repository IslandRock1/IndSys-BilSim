extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	z_index = 15

func circle(size, col):
	draw_circle(Vector2.ZERO, size, col)

func drawArm(angle):
	"""
	Angle, straight down is 0, going clockwise
	"""
	
	var color = Color(1.0, 0.361, 0.882)
	var size = 1500.0
	var width = 200.0
	
	var topRight = Vector2(width / 2.0, 0)
	var bottomRight = Vector2(width / 2.0, size)
	var bottomLeft = Vector2(-width / 2.0, size)
	var topLeft = Vector2(-width / 2.0, 0)
	var points = [topRight, bottomRight, bottomLeft, topLeft]
	
	for i in range(4):
		var p: Vector2 = points[i]
		points[i] = p.rotated(angle)
	
	draw_colored_polygon(points, color)
	draw_line(points[3], points[2], Color.BLACK, 20)
	draw_line(points[0], points[1], Color.BLACK, 20)

func drawSteeringWheel(angle):
	circle(1720, Color.BLACK)
	circle(1700, Color(1.0, 0.361, 0.882))
	circle(1500, Color.BLACK)
	circle(1480, Global.colorBackgroundBoxes)
	
	drawArm(angle)
	drawArm(angle + 2 * PI / 3)
	drawArm(angle - 2 * PI / 3)
	
func _draw() -> void:

	# Steering is in range (-1, 1), -1 is left, 1 is right, 0 is straight. Duh!
	var steering = Global.udpSteeringAngle
	var angle = steering * (2 * PI / 0.8) # 80% range ig
	drawSteeringWheel(angle)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	queue_redraw()
