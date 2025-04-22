extends Camera3D

@export var rotation_speed : float = 0.0001  # Controls the speed of rotation
@export var min_pitch : float = -PI / 2.5  # Min pitch angle in degrees
@export var max_pitch : float = PI / 2.5   # Max pitch angle in degrees

var current_rotation = Vector2.ZERO  # Stores the current mouse position
var visuSize = 10.0
var visuSizeSpeed = 0.2


func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_WHEEL_UP:
			visuSize -= visuSizeSpeed
			update()
		elif event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
			visuSize += visuSizeSpeed
			update()

func update():
	var mouse_delta = Input.get_last_mouse_velocity()

	# Update the camera rotation based on mouse movement
	current_rotation.x = fmod(current_rotation.x - mouse_delta.x * rotation_speed, TAU)
	current_rotation.y = clamp(current_rotation.y + mouse_delta.y * rotation_speed, min_pitch, max_pitch)

	position.y = sin(current_rotation.y) * visuSize
	position.x = sin(current_rotation.x) * visuSize
	position.z = cos(current_rotation.x) * visuSize
	look_at(Vector3.ZERO, Vector3.UP)

func _ready():
	# Hide the mouse cursor while controlling the camera
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	update()
	
	var environment := Environment.new()

	# Set background mode to COLOR
	environment.background_mode = Environment.BG_COLOR

	# Set the clear color
	environment.background_color = Global.colorBackgroundBoxes
	# Assign it to your camera
	self.environment = environment

func _process(delta):
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		update()
