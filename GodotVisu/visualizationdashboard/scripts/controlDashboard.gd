extends Control

var cell_size = 20
var columns = 1920 / cell_size
var rows = 1080 / cell_size
var top_left = Vector2(columns, rows) * cell_size * (-0.5)
#name: [Vector(width (rows), height (cols)), posX (rows), posY (cols), 
#              currentHeight (pixels), currentWidth, (pixels)]

# name : [Width/Height vector, pos vector, currentInfo vector (height, width
var places = {
	"Speedometer": [Vector2(15, 15), Vector2(5, 5), Vector2(1000, 1000)],
	"LapDisplay": [Vector2(15, 15), Vector2(30, 5), Vector2(1000, 1000)],
	"ThrottleDisplay": [Vector2(15, 15), Vector2(60, 5), Vector2(1000, 1000)]
}

func _draw() -> void:
	for x in range(-columns / 2, columns):
		var top = Vector2(x * cell_size, -540)
		var bot = Vector2(x * cell_size, 540)
		
		draw_line(top, bot, Color(1, 1, 1, 0.2))

func place(child: Node):
	var info = places[child.name]
	child.scale = info[0] * cell_size / info[2]
	
	var center_top_left = top_left + info[0] * cell_size / 2.0
	child.position = center_top_left + info[1] * cell_size

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
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
	
	for child in get_children():
		place(child)
	

func _process(delta: float) -> void:
	if size != get_viewport_rect().size:
		size = get_viewport_rect().size
		update_size()
