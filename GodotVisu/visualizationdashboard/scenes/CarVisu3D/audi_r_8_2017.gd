extends Node3D

@export var new_color := Color(1.0, 0.5, 0.5, 1.0)  # Any color you want

var prevPitch;
var prevRoll;

func _ready():
	_apply_color_to_all_meshes(self)
	
	rotate_y(3.1415926 / 2.0)
	prevPitch = Global.udpPitch
	prevRoll = Global.udpRoll

func _apply_color_to_all_meshes(node: Node):
	if node is MeshInstance3D:
		var material := StandardMaterial3D.new()
		material.albedo_color = new_color
		material.shading_mode = BaseMaterial3D.SHADING_MODE_MAX
		material.metallic = 0.0
		material.roughness = 1.0
		material.transparency = BaseMaterial3D.TRANSPARENCY_DISABLED
		node.material_override = material

	for child in node.get_children():
		_apply_color_to_all_meshes(child)

func _process(delta: float) -> void:
	# Pitch => X
	# Rolll => Z
	
	rotation = Vector3(Global.udpPitch, 0, Global.udpRoll)
	
	#rotate_x(Global.udpPitch - prevPitch)
	#rotate_z(Global.udpRoll - prevRoll)
	#prevPitch = Global.udpPitch
	#prevRoll = Global.udpRoll
