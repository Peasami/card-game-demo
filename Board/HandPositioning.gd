extends Node

#             ¤
#             | <-y
#  ¤----------¤----------¤
#    (500,500)|    ^x
#             ¤

@export var xSemiAxel = 450.0    # Defines the width of half of the ellipse
@export var ySemiAxel = 120.0    # and height


@export var xCenterOffset = 500.0   # Center of ellipse x coordinate
@export var yCenterOffset = 650.0   # Center of ellipse y coordinate

@export var distanceBetweenCards = 60

#--------------------------------------------#
# Draws lines through the ellipse upper part #
# + ellipse center
#--------------------------------------------#
func _ready():
	var xDivider = xSemiAxel*2.0
	var divisions = 20.0
	var divisionLength:float = xDivider/divisions
	var xSpot:float = 0.0
	for i in range(divisions+1):
		xSpot = divisionLength*i - xSemiAxel
		$DebugDraw.points.append(Vector2(xSpot + xCenterOffset, calculate_ellipse_y(xSpot)))
	
	$DebugDraw.xEllipseCenter = xCenterOffset
	$DebugDraw.yEllipseCenter = yCenterOffset


func calculate_ellipse_y(xA):
	return (-ySemiAxel*(sqrt((pow(xSemiAxel,2.0))-(pow(xA,2.0)))))/xSemiAxel + yCenterOffset

#------------------------------------------------------------------#
# Takes in cards in hand count                                     #
# Returns array containing correspoding card position and rotation #
#------------------------------------------------------------------#
func get_card_hand_position(inHandCount) -> Vector2:
	var xAxis = inHandCount*distanceBetweenCards
	var yAxis = calculate_ellipse_y(xAxis)
	print("xAxis: ", xAxis, ", yAxis: ", yAxis)
	return Vector2(xAxis + xCenterOffset, yAxis)

func get_card_hand_rotation(xCoordinate: float):
	return (xCoordinate - xCenterOffset) / 1500
