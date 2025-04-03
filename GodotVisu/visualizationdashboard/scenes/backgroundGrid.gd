extends Node3D

@export var grid_size := 10  # Number of cells
@export var cell_size := 1.0  # Size of each cell
@export var grid_color := Color(0.5, 0.5, 0.5, 0.5)
@export var line_width := 0.1
@export var height = -3.0

func _ready():
	var mesh_instance = MeshInstance3D.new()
	var immediate_mesh = ImmediateMesh.new()
	var material = StandardMaterial3D.new()
	
	material.shading_mode = BaseMaterial3D.SHADING_MODE_UNSHADED
	material.albedo_color = grid_color
	material.transparency = BaseMaterial3D.TRANSPARENCY_ALPHA
	
	mesh_instance.mesh = immediate_mesh
	mesh_instance.cast_shadow = GeometryInstance3D.SHADOW_CASTING_SETTING_OFF
	add_child(mesh_instance)
	
	immediate_mesh.surface_begin(Mesh.PRIMITIVE_LINES)
	
	var half_size = (grid_size * cell_size) / 2.0
	
	# Draw grid lines
	for i in range(grid_size + 1):
		var offset = -half_size + i * cell_size
		
		# X-axis lines (vertical in 3D space)
		immediate_mesh.surface_add_vertex(Vector3(offset, height, -half_size))
		immediate_mesh.surface_add_vertex(Vector3(offset, height, half_size))
		
		# Z-axis lines (horizontal in 3D space)
		immediate_mesh.surface_add_vertex(Vector3(-half_size, height, offset))
		immediate_mesh.surface_add_vertex(Vector3(half_size, height, offset))
	
	immediate_mesh.surface_end()
