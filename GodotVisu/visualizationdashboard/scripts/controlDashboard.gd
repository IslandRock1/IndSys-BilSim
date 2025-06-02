extends Control

# The controlDashboard.gd file is attatched to the Control node
# This file is mainly placing the subscenes on the screen, making it easy
# to move and scale these elements.

# The first iteration it will configure some screen size variables,
# then place all children on the screen. For every later iteration,
# it will check if the window size has changed, and if so, it will
# place children again.

# The 'places' lookup table makes configuring easy, by using a grid
# placement method. This can also scale sub-elements to whatever size
# one wants.

var cell_size = 20.0
var columns = 1920.0 / cell_size
var rows = 1080.0 / cell_size
var top_left = Vector2(columns, rows) * cell_size * (-0.5)

#name: [Vector(width (rows), height (cols)), posX (rows), posY (cols), 
#              currentHeight (pixels), currentWidth, (pixels)]
var places = {
	"Speedometer": [Vector2(32, 18), Vector2(64, 4), Vector2(4800, 2700)],
	"LapDisplay": [Vector2(32, 27), Vector2(32, 10), Vector2(3200, 2700)],
	"ThrottleDisplay": [Vector2(32, 27), Vector2(32, 36), Vector2(3200, 2700)],
	"CarVisu3d": [Vector2(32, 18), Vector2(-16, -5), Vector2(4800, 2700)],
	"SteeringAngle": [Vector2(32, 27), Vector2(32, 10), Vector2(3200, 2700)],
	"FPSLabel": [Vector2(8, 8), Vector2(10, 0), Vector2(1000, 1000)]
}

func _draw() -> void:
	draw_circle(Vector2.ZERO, 100000, Global.colorBackgroundBoxes)

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

func update_size() -> void:
	var new_size = get_viewport_rect().size
	columns = new_size.x / cell_size
	rows = new_size.y / cell_size

	for child in get_children():
		place(child)


func _process(_delta: float) -> void:
	if size != get_viewport_rect().size:
		size = get_viewport_rect().size
		update_size()
