extends Control

var udp = PacketPeerUDP.new()
var port = 20777

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var err = udp.bind(port, "0.0.0.0")
	print(err)
	print(error_string(err))
	if err != OK:
		print("Not working at least")
	else:
		print("Err is OK")

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
	if len(decodedFloats) < 60: return
	
	Global.udpCurrentLaptime = decodedFloats[1]
	Global.udpCurrentLapDist = decodedFloats[2]
	Global.udpDistanceDrivenOverall = decodedFloats[3]
	Global.udpVelocity = decodedFloats[7] * 3.6
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
	Global.udpTrackDistance = decodedFloats[61]

func printInfo() -> void:
	print("LapTime:", Global.udpCurrentLaptime, "| Gear:", Global.udpGear)

var t = 0.0
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	var num = udp.get_available_packet_count()
	for i in range(num - 1):
		udp.get_packet()
	
	var data = udp.get_packet()
	
	var floats = decode_data(data)
	storeDataGlobally(floats)
	# printInfo()
	
	#t += _delta
	#Global.udpThrottle = sin(t)
