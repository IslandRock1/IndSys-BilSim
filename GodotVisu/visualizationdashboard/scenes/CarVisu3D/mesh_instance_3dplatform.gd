extends MeshInstance3D

var t = 0.0
var prevPitch = 0.0
var prevRoll = 0.0

func ready() -> void:
	prevPitch = Global.udpPitch
	prevRoll = Global.udpRoll
	
	rotate_object_local(Vector3.RIGHT, -PI / 2)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	t += delta
	rotate_object_local(Vector3.BACK, Global.udpPitch - prevPitch)
	rotate_object_local(Vector3.RIGHT, Global.udpRoll - prevRoll)
	prevPitch = Global.udpPitch
	prevRoll = Global.udpRoll
