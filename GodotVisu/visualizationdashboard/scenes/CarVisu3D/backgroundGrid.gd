extends Node3D

@export var grid_size := 10      # Number of cells
@export var cell_size := 1.0     # Size of each cell
@export var grid_color := Color(0.8, 0.5, 0.5, 0.0)
@export var line_width := 0.2   # Thickness of grid lines
@export var height := -3.0       # Y position of the grid

func _ready():
	var half_size = (grid_size * cell_size) / 2.0

	var material = StandardMaterial3D.new()
	material.shading_mode = BaseMaterial3D.SHADING_MODE_UNSHADED
	material.albedo_color = grid_color
	material.transparency = BaseMaterial3D.TRANSPARENCY_ALPHA
	material.flags_transparent = true

	# Create lines along X and Z directions
	for i in range(grid_size + 1):
		var offset = -half_size + i * cell_size

		# Vertical lines (along Z axis)
		var start_x = Vector3(offset, height, -half_size)
		var end_x = Vector3(offset, height, half_size)
		_create_thick_line(start_x, end_x, material)

		# Horizontal lines (along X axis)
		var start_z = Vector3(-half_size, height, offset)
		var end_z = Vector3(half_size, height, offset)
		_create_thick_line(start_z, end_z, material)

func _create_thick_line(start: Vector3, end: Vector3, material: StandardMaterial3D):
	var direction = end - start
	var length = direction.length()
	var center = (start + end) / 2.0

	var box_mesh = BoxMesh.new()

	var size_x: float = line_width if direction.x == 0.0 else length
	var size_z: float = line_width if direction.z == 0.0 else length

	box_mesh.size = Vector3(size_x, 0.01, size_z)

	var mesh_instance = MeshInstance3D.new()
	mesh_instance.mesh = box_mesh
	mesh_instance.material_override = material
	mesh_instance.cast_shadow = GeometryInstance3D.SHADOW_CASTING_SETTING_OFF
	mesh_instance.global_transform.origin = center

	add_child(mesh_instance)


##########


#extends Node3D
#
#@export var grid_size := 10  # Number of cells
#@export var cell_size := 1.0  # Size of each cell
#@export var grid_color := Color(0.0, 0.0, 0.8, 0.5)
#@export var line_width := 1.0
#@export var height = -3.0
#
#func _ready():
	#var mesh_instance = MeshInstance3D.new()
	#var immediate_mesh = ImmediateMesh.new()
	#var material = StandardMaterial3D.new()
	#
	#material.shading_mode = BaseMaterial3D.SHADING_MODE_UNSHADED
	#material.albedo_color = grid_color
	#material.transparency = BaseMaterial3D.TRANSPARENCY_ALPHA
	#
	#mesh_instance.material_override = material
	#mesh_instance.mesh = immediate_mesh
	#mesh_instance.cast_shadow = GeometryInstance3D.SHADOW_CASTING_SETTING_OFF
	#add_child(mesh_instance)
	#
	#immediate_mesh.surface_begin(Mesh.PRIMITIVE_LINES)
	#
	#var half_size = (grid_size * cell_size) / 2.0
	#
	## Draw grid lines
	#for i in range(grid_size + 1):
		#var offset = -half_size + i * cell_size
		#
		## X-axis lines (vertical in 3D space)
		#immediate_mesh.surface_add_vertex(Vector3(offset, height, -half_size))
		#immediate_mesh.surface_add_vertex(Vector3(offset, height, half_size))
		#
		## Z-axis lines (horizontal in 3D space)
		#immediate_mesh.surface_add_vertex(Vector3(-half_size, height, offset))
		#immediate_mesh.surface_add_vertex(Vector3(half_size, height, offset))
	#
	#immediate_mesh.surface_end()
