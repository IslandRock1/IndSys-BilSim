extends MeshInstance3D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var mesh = ArrayMesh.new()
	var surface_tool = SurfaceTool.new()
	
	surface_tool.begin(Mesh.PRIMITIVE_TRIANGLES)
	
	var lenght = 5.0
	var width = 1.0
	
	var baseLevel = 0.0
	var topLevel = 0.2
	
	var topLeft = Vector3(-width, baseLevel, lenght)
	var topRight = Vector3(width, baseLevel, lenght)
	var shortLine = Vector3(0, 0, 3 * width / sqrt(3))
	
	var rotAx = Vector3(0, 1, 0)
	
	var points = [
		topLeft, topRight,
		topLeft.rotated(rotAx, 2 * PI / 3), topRight.rotated(rotAx, 2 * PI / 3),
		topLeft.rotated(rotAx, -2 * PI / 3), topRight.rotated(rotAx, -2 * PI / 3),
		shortLine.rotated(rotAx, PI / 3), shortLine.rotated(rotAx, -PI / 3),
		shortLine.rotated(rotAx, PI)
	]
	
	
	
	var botIndices = [
		0, 1, 7,
		1, 6, 7,
		2, 3, 8,
		2, 8, 6,
		4, 5, 8,
		8, 5, 7,
		6, 8, 7,
	]
	
	var indices = []
	for p in botIndices:
		indices.append(p)
	
	botIndices = [
		0, 7, 1,
		1, 7, 6,
		2, 8, 3,
		2, 6, 8,
		4, 8, 5,
		8, 7, 5,
		6, 7, 8,
	]
	
	for p in botIndices:
		indices.append(p + 9)
	
	indices.append_array([
		0, 9, 1,
		1, 9, 10,
		1, 10, 6,
		6, 10, 15,
		6, 11, 2,
		11, 6, 15,
		2, 11, 3,
		3, 11, 12,
		3, 17, 8,
		3, 12, 17,
		8, 17, 4,
		4, 17, 13,
		4, 14, 5,
		4, 13, 14,
		5, 16, 7,
		5, 14, 16,
		7, 9, 0,
		7, 16, 9
	])
	
	var vertices = []
	for p in points:
		vertices.append(p)
	
	for p in points:
		vertices.append(p + Vector3(0, topLevel, 0))
	
	print(vertices)
	
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
