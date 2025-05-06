extends Node

var screen_size = Vector2(1920, 1080)

### UDP Data
var udpCurrentLaptime : float
var udpCurrentLapDist : float
var udpDistanceDrivenOverall : float

var udpCurrentLapNumber : float
var udpNumberOfLaps : float
var udpTrackDistance : float

var udpThrottle : float
var udpSteeringAngle : float
var udpBrakeEngagement : float
var udpClutchEngaement : float

var udpRoll : float
var udpPitch : float

var udpVelocity : float
var udpGear : float
var udpEngineRPM : float

### General Variables ###
var minCarSpeed = 0.0
var maxCarSpeed = 300.0

### Speedometer Variables ###
var speedometerAngleSize = 270.0


### Color variables ###
var colorBackgroundBoxes = Color(0.4, 0.4, 0.4)
var colorWhite = Color.WHITE
var textColor = Color.WHITE
