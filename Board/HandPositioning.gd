extends Node

#             ¤
#             | <-y
#  ¤----------¤----------¤
#    (500,500)|    ^x
#             ¤

@export var xSemiAxel = 450.0    # Defines the width of the ellipse
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

# Returns the y coordinate of the ellipse at the given x coordinate.
func calculate_ellipse_y(xA):
	return (-ySemiAxel*(sqrt((pow(xSemiAxel,2.0))-(pow(xA,2.0)))))/xSemiAxel + yCenterOffset

# Returns the anchor position for a card based on its index in hand.
# The anchor position is the default position of the card.
func get_card_position_in_hand(cardIndex: int, handSize: int) -> Vector2:
	var xPos = (cardIndex*2+1-handSize)*50
	var yPos = calculate_ellipse_y(xPos)
	return Vector2(xPos + xCenterOffset, yPos)

# Returns the anchor rotation of the card at the given x coordinate.
func get_card_hand_rotation(xCoordinate: float):
	return (xCoordinate - xCenterOffset) / 1500
