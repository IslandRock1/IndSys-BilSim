extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func mapSpeed() -> float:
	var minAngle = 90 + (360 - Global.speedometerAngleSize) / 2
	var maxAngle = minAngle + Global.speedometerAngleSize
	
	var minSpeed = Global.minCarSpeed
	var maxSpeed = Global.maxCarSpeed

	var angle = remap(Global.udpVelocity, minSpeed, maxSpeed, minAngle, maxAngle)
	return angle

func _draw() -> void:
	var angle = mapSpeed()
	var length = 1200.0
	var endWidth = 13.0
	var baseWidth = 50.0
	
	var endVector = Vector2(cos(deg_to_rad(angle)), sin(deg_to_rad(angle)))
	var sideVector = Vector2(cos(deg_to_rad(angle + 90)), sin(deg_to_rad(angle + 90)))
	
	var p0 = endVector * length + sideVector * endWidth
	var p1 = sideVector * baseWidth
	var p2 = -p1
	var p3 = endVector * length - sideVector * endWidth
	
	var points = [p0, p1, p2, p3]
	draw_colored_polygon(points, Color.RED)
	# draw_line(center, endPoint, Color.RED, 5, true)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	queue_redraw()
