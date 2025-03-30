extends MeshInstance3D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var mesh = ArrayMesh.new()
	var surface_tool = SurfaceTool.new()
	
	surface_tool.begin(Mesh.PRIMITIVE_TRIANGLES)
	
	var vertices = [
		Vector3(-0.5, -0.5, -0.5), Vector3( 0.5, -0.5, -0.5), Vector3( 0.5,  0.5, -0.5),
		Vector3(-0.5,  0.5, -0.5), Vector3(-0.5, -0.5,  0.5), Vector3( 0.5, -0.5,  0.5),
		Vector3( 0.5,  0.5,  0.5), Vector3(-0.5,  0.5,  0.5)
	]
	
   	# Define faces using vertex indices
	var indices = [
		# Front face
		0, 2, 1, 0, 3, 2,
		# Back face
		4, 5, 6, 4, 6, 7,
		# Left face
		0, 1, 5, 0, 5, 4,
		# Right face
		1, 2, 6, 1, 6, 5,
		# Top face
		2, 3, 7, 2, 7, 6,
		# Bottom face
		0, 4, 7, 0, 7, 3
	]
	
	# Add vertices to the surface
	for vertex in vertices:
		surface_tool.add_vertex(vertex)
	
	# Add faces (triangles) based on indices
	for i in range(0, indices.size(), 3):
		surface_tool.add_index(indices[i])
		surface_tool.add_index(indices[i + 1])
		surface_tool.add_index(indices[i + 2])

	# Commit to the mesh
	surface_tool.commit(mesh)
	self.mesh = mesh


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
