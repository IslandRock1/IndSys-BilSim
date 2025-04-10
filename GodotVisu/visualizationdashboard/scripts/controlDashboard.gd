extends Control

var cell_size = 20
var columns = 1920 / cell_size
var rows = 1080 / cell_size
var top_left = Vector2(columns, rows) * cell_size * (-0.5)
#name: [Vector(width (rows), height (cols)), posX (rows), posY (cols), 
#              currentHeight (pixels), currentWidth, (pixels)]

# name : [Width/Height vector, pos vector, currentInfo vector (height, width
var places = {
	"Speedometer": [Vector2(32, 18), Vector2(64, 4), Vector2(4800, 2700)],
	"LapDisplay": [Vector2(32, 27), Vector2(32, 10), Vector2(3200, 2700)],
	"ThrottleDisplay": [Vector2(32, 27), Vector2(32, 32), Vector2(3200, 2700)],
	"CarVisu3d": [Vector2(32, 18), Vector2(-16, -3), Vector2(4800, 2700)],
	"SteeringAngle": [Vector2(32, 27), Vector2(3200, 0), Vector2(3200, 2700)]
}

func _draw() -> void:
	#for x in range(-columns, columns):
		#var top = Vector2(x * cell_size, -540)
		#var bot = Vector2(x * cell_size, 540)
		#
		#draw_line(top, bot, Color(1, 1, 1, 0.2))
	#
	#for y in range(-100, 100):
		#var top = Vector2(-1000, y * cell_size)
		#var bot = Vector2(1000, y * cell_size)
		#draw_line(top, bot, Color(1, 1, 1, 0.2))
	
	pass

func place(child: Node):
	var info = places[child.name]
	child.scale = info[0] * cell_size / info[2]
	
	var center_top_left = top_left + info[0] * cell_size / 2.0
	child.position = center_top_left + info[1] * cell_size

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	update_size();
	
	for child in get_children():
		place(child)

#var columns = 1920 / cell_size
#var rows = 1080 / cell_size
#var top_left = Vector2(columns, rows) * cell_size * (-0.5)

func update_size() -> void:
	var new_size = get_viewport_rect().size
	columns = new_size.x / cell_size
	rows = new_size.y / cell_size
	
	print("Updated size")
	print("Columns: ", columns, " | Rows: ", rows, ".")
	
	for child in get_children():
		place(child)
	

func _process(delta: float) -> void:
	if size != get_viewport_rect().size:
		size = get_viewport_rect().size
		update_size()
