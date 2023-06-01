# This node is for handling card animation
# Also keeps track of what fields each card resides in 
# ^(this info available in card statets inside CardBase node)

extends Node

@onready var handEllipseData = $"../HandPositioning" ## Has positional info for cards in hand
@onready var playerStats = $"../PlayerStatsInfo"

var cardsInDeck = []
var cardsInHand = []

func _ready():
	for i in get_children():
		if i.get_state() == "InDeck":
			cardsInDeck.append(i)

#Draw n cards
func _on_DrawCard_draw_cards(amountToDraw: int = 1):
	for i in amountToDraw:	
		if cardsInHand.size() >= playerStats.maxHandSize:
			return
		#Gets random card from hand
		var drawnCard = cardsInDeck[randi() % cardsInDeck.size()]
		
		animate_card_to_hand(drawnCard)
		reorganize_hand()
		
		drawnCard.transition_state_to("InHand")
		cardsInDeck.erase(drawnCard)
		print("cardsInDeck after: ", cardsInDeck.size())
		cardsInHand.append(drawnCard)


#----------------------------------------------------------------------------------#
# Gets card's positioning and rotation, given the number of cards already in hand, #
# and animates it into the position                                                #
#----------------------------------------------------------------------------------#
func animate_card_to_hand(card):
	card.finalPosition = handEllipseData.get_card_hand_position(cardsInHand.size())
	var cardPosInHand:Vector2 = card.finalPosition
	card.finalRotation = handEllipseData.get_card_hand_rotation(cardPosInHand.x)
	var cardRotInHand:float = card.finalRotation
	
	animate_card(card, cardPosInHand, cardRotInHand)
	card.z_index = cardsInHand.size() ## give z_index higher than other cards in hand


func animate_card_within_hand_ellipse(card, finalPosition, speed = 0.2):
	var cardRotInHand:float = handEllipseData.get_card_hand_rotation(finalPosition.x)
	var tween = create_tween().set_parallel(true)
	tween.tween_property(card, 'position', finalPosition, speed)
	tween.tween_property(card, 'rotation', cardRotInHand, speed)

func animate_card(card, finalPosition, finalRotation, speed = 0.2):
	var tween = create_tween().set_parallel(true)
	tween.tween_property(card, 'position', finalPosition, speed)
	tween.tween_property(card, 'rotation', finalRotation, speed)

func reorganize_hand():
	for i in cardsInHand:
		var x = i.finalPosition.x - handEllipseData.distanceBetweenCards
		var y = get_card_y_position_in_hand(x)
		i.finalPosition = Vector2(x,y)
		animate_card_within_hand_ellipse(i, Vector2(x,y))
#		print(i, " x:", x, " y:", y)


func hovering_in_hand(targetCard):
	var targetCardX = targetCard.position.x
	var amountToMove = 75
	for i in cardsInHand:
		if i == targetCard:
			continue
		if i.position.x < targetCardX:
			var x = i.finalPosition.x - amountToMove
			var y = get_card_y_position_in_hand(x)
			animate_card_within_hand_ellipse(i, Vector2(x, y), 0.05)
			i.set_mouse_filter(2)
		else:
			var x = i.finalPosition.x + amountToMove
			var y = get_card_y_position_in_hand(x)
			animate_card_within_hand_ellipse(i, Vector2(x, y), 0.05)
			i.set_mouse_filter(2)
	print("hovering in hand: ", targetCard)

func de_hovering_in_hand(targetCard):
	for i in cardsInHand:
		if i == targetCard:
			continue
		animate_card_within_hand_ellipse(i, i.finalPosition, 0.05)
		i.set_mouse_filter(0)

## Calculates y position of the card on the hand ellipse
func get_card_y_position_in_hand(xPos):
	var yPos = handEllipseData.calculate_ellipse_y(xPos - handEllipseData.xCenterOffset)
	return yPos
