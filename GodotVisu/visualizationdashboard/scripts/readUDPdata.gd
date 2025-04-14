extends Control

var simulatedTime = 0.0
var udp = PacketPeerUDP.new()
var port = 20777

@onready var previous_window = DisplayServer.window_get_mode()
@onready var current_window = DisplayServer.window_get_mode()

func _input(event):
	if Input.is_action_just_pressed("toggle_fullscreen"):
		current_window = DisplayServer.window_get_mode()
		if current_window != 4:
			previous_window = current_window
			DisplayServer.window_set_mode(4)
		else:
			if previous_window == 4:
				previous_window = 2
			DisplayServer.window_set_mode(previous_window)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	udp.bind(port, "0.0.0.0")

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

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	simulatedTime += delta
	
	var num = udp.get_available_packet_count()
	for i in range(num - 1):
		udp.get_packet()
	
	var data = udp.get_packet()
	var floats = decode_data(data)
	storeDataGlobally(floats)
	
	var roll = str(Global.udpRoll)
	var pitch = str(Global.udpPitch)
	
	print("Roll: ", roll, " | Pitch: ", pitch, ".")
	
	#Global.udpEngineRPM = round(sin(simulatedTime) * 10)
	#Global.udpEngineRPM = 3.5
	#Global.udpCurrentLapDist = fmod(simulatedTime, 10.0)
	#Global.udpCurrentLapDist = 3.0
	#Global.udpTrackDistance = 10 * 5
	#Global.udpCurrentLaptime = 703
	#
	#Global.udpCurrentLapNumber = 1
	#Global.udpNumberOfLaps = 5
	#Global.udpGear = 2
	#
	#Global.udpVelocity = roundi(sin(simulatedTime) * 300)
	#Global.udpThrottle = sin(simulatedTime)
