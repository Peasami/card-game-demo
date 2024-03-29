# Holds information about position of cards during gameplay.
# In hand positions
# Deck position TO ADD
# GY Position TO ADD
# etc..

class_name CardPositionData

#             ¤
#             | <-y
#  ¤----------¤----------¤
#    (500,500)|    ^x
#             ¤

const xSemiAxel = 450.0    # Defines the width of the ellipse
const ySemiAxel = 120.0    # and height

const xCenterOffset = 1920/2   # Center of ellipse x coordinate
const yCenterOffset = 1100   # Center of ellipse y coordinate

const distanceBetweenCards = 120

# y value above which a card becomes enlarged while in hand
const hand_targeting_height := 900
const zoom_height := 950

const graveyard_position := Vector2(1800, 900)

# Returns the y coordinate of the ellipse at the given x coordinate.
static func calculate_ellipse_y(xA):
	return (-ySemiAxel*(sqrt((pow(xSemiAxel,2.0))-(pow(xA,2.0)))))/xSemiAxel + yCenterOffset

# Returns the anchor position for a card based on its index in hand.
# The anchor position is the default position of the card.
static func get_card_position_in_hand(cardIndex: int, handSize: int) -> Vector2:
	var xPos = (cardIndex*2+1-handSize)*50
	var yPos = calculate_ellipse_y(xPos)
	return Vector2(xPos + xCenterOffset, yPos)

# Returns the anchor rotation of the card at the given x coordinate.
static func get_card_hand_rotation(xCoordinate: float):
	return (xCoordinate - xCenterOffset) / 1500
