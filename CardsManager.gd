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
	var cardRotInHand:float = handEllipseData.get_card_hand_rotation(cardPosInHand.x)
	print("cardRotInHand: ", cardRotInHand)
	var tween = create_tween().set_parallel(true)
	tween.tween_property(card, 'position', cardPosInHand, .2)
	tween.tween_property(card, 'rotation', cardRotInHand, .2)
	card.z_index = cardsInHand.size()


func animate_card(card, finalPosition, speed = 0.2):
	var cardRotInHand:float = handEllipseData.get_card_hand_rotation(finalPosition.x)
	var tween = create_tween().set_parallel(true)
	tween.tween_property(card, 'position', finalPosition, speed)
	tween.tween_property(card, 'rotation', cardRotInHand, speed)


func reorganize_hand():
	for i in cardsInHand:
		var x = i.finalPosition.x - handEllipseData.distanceBetweenCards
		var y = get_card_y_position_in_hand(x)
		i.finalPosition = Vector2(x,y)
		animate_card(i, Vector2(x,y))
		
		print(i, " x:", x, " y:", y)


func hovering_in_hand(targetCard):
	var targetCardX = targetCard.position.x
	var amountToMove = 75
	for i in cardsInHand:
		if i == targetCard:
			continue
		if i.position.x < targetCardX:
			var x = i.finalPosition.x - amountToMove
			var y = get_card_y_position_in_hand(x)
			animate_card(i, Vector2(x, y), 0.05)
		else:
			var x = i.finalPosition.x + amountToMove
			var y = get_card_y_position_in_hand(x)
			animate_card(i, Vector2(x, y), 0.05)
	print("hovering in hand: ", targetCard)

func not_hovering_in_hand(targetCard):
	for i in cardsInHand:
		if i == targetCard:
			continue
		animate_card(i, i.finalPosition, 0.05)

func get_card_y_position_in_hand(xPos):
	var yPos = handEllipseData.calculate_ellipse_y(xPos - handEllipseData.xCenterOffset)
	return yPos
