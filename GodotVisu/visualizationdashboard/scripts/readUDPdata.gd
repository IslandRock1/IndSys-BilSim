extends Node2D

var udp = PacketPeerUDP.new()
var port = 20777

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	udp.set_dest_address("0.0.0.0", port)
	udp.bind(port)

func decode_data(byte_data: PackedByteArray) -> Array:
	var floats = []
	var buffer = StreamPeerBuffer.new()
	buffer.data_array = byte_data
	
	for i in range(0, byte_data.size(), 4):
		buffer.seek(i)
		var float_value = buffer.get_float()
		floats.append(float_value)
	
	return floats

func storeDataGlobally(decodedFloats: Array) -> void:
	Global.udpCurrentLaptime = decodedFloats[1]
	Global.udpCurrentLapDist = decodedFloats[2]
	Global.udpTotalDist = decodedFloats[3]
	Global.udpVelocity = decodedFloats[7]
	Global.udpRoll = decodedFloats[11]
	Global.udpPitch = decodedFloats[14]
	Global.udpThrottle = decodedFloats[29]
	Global.udpSteeringAngle = decodedFloats[30]
	Global.udpBrakeEngagement = decodedFloats[31]
	Global.udpClutchEngaement = decodedFloats[32]
	
	Global.udpGear = decodedFloats[33]
	# [0 = Neutral, 1 = 1, 2 = 2, ..., 10 = Reverse]
	# Enda usikker på float til int conversion...
	
	Global.udpCurrentLapNumber = decodedFloats[36]
	Global.udpEngineRPM = decodedFloats[37]
	Global.udpNumberOfLaps = decodedFloats[60]
	Global.udpTotalDist = decodedFloats[61]

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	Global.udpVelocity += 0.5
	if Global.udpVelocity > 300:
		Global.udpVelocity = 0.0
	
	Global.udpNumberOfLaps = 3.0
	Global.udpTrackDistance = 10000.0
	Global.udpTotalDist += 10.0
	Global.udpCurrentLapDist += 10.0
	
	if (Global.udpCurrentLapDist > Global.udpTrackDistance / Global.udpNumberOfLaps):
		Global.udpCurrentLapDist -= Global.udpTrackDistance / Global.udpNumberOfLaps
	
