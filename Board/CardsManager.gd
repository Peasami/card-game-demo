# (This node is for handling card animation) //Going to be outdated, since card movement is in CardBase
# This node sees all cards and assigns them into proper states
# Also keeps track of what fields each card resides in 
# ^(this info available in card statets inside CardBase node)

extends Node

@onready var handEllipseData = $"../HandPositioning" ## Has positional info for cards in hand
@onready var playerStats = $"../PlayerStatsInfo"

## Arrays for each field for cards
var cardsInDeck = []
var cardsInHand = []
var cardsInGraveyard = []


func _ready():
	for i in get_children():
		if i.get_state() == "InDeck":
			cardsInDeck.append(i)


func _on_DrawCard_draw_cards(amountToDraw: int = 1):
	draw_cards(amountToDraw)

# Draw n cards to hand
func draw_cards(amountToDraw: int = 1):
	for i in amountToDraw:	
		if cardsInHand.size() >= playerStats.maxHandSize:
			return
		
		var drawnCard = cardsInDeck[randi() % cardsInDeck.size()] # Gets random card from hand
		
		set_card_anchor_position(drawnCard)
		reorganize_hand()
		
		drawnCard.transition_state_to("InHand")
		cardsInDeck.erase(drawnCard)
		cardsInHand.append(drawnCard)


#----------------------------------------------------------------------------------#
# Gets card's positioning and rotation, given the number of cards already in hand  #                                              #
#----------------------------------------------------------------------------------#
func set_card_anchor_position(card):
	card.anchorPosition = handEllipseData.get_card_hand_position(cardsInHand.size())
	var cardPosInHand:Vector2 = card.anchorPosition
	card.anchorRotation = handEllipseData.get_card_hand_rotation(cardPosInHand.x)

	card.z_index = cardsInHand.size() ## give z_index higher than other cards in hand


func animate_card_within_hand_ellipse(card, finalPosition, speed = 0.2):
	card.anchorRotation = handEllipseData.get_card_hand_rotation(finalPosition.x)
	var cardRotInHand:float = card.anchorRotation
	var tween = create_tween().set_parallel(true)
	tween.tween_property(card, 'position', finalPosition, speed)
	tween.tween_property(card, 'rotation', cardRotInHand, speed)

# Determine new position for each card in hand after drawing a card
func reorganize_hand():
	for i in cardsInHand:
		var x = i.anchorPosition.x - handEllipseData.distanceBetweenCards ## Calculate x and y in hand
		var y = get_card_y_position_in_hand(x)
		i.anchorRotation = handEllipseData.get_card_hand_rotation(x)
		i.anchorPosition = Vector2(x,y)
		i.transition_state_to("InHand")
#		animate_card_within_hand_ellipse(i, Vector2(x,y))
#		print(i, " x:", x, " y:", y)


func hovering_in_hand(targetCard):
	var amountToMove = 50
	
	### Iterates through each other card, to make them move aside
	for i in cardsInHand:
		if i == targetCard:
			continue
		if i.position.x < targetCard.position.x:
			i.transition_state_to("InHandDodging", {"cardSide": "left"})
			
#			var x = i.anchorPosition.x - amountToMove
#			var y = get_card_y_position_in_hand(x)
#			animate_card_within_hand_ellipse(i, Vector2(x, y), 0.2)
#			i.set_mouse_filter(2)
		else:
			i.transition_state_to("InHandDodging", {"cardSide": "right"})
#			var x = i.anchorPosition.x + amountToMove
#			var y = get_card_y_position_in_hand(x)
#			animate_card_within_hand_ellipse(i, Vector2(x, y), 0.2)
#			i.set_mouse_filter(2)
	print("hovering in hand: ", targetCard)

func de_hovering_in_hand(targetCard):
	pass
#	for i in cardsInHand:
#		if i == targetCard:
#			continue
#		animate_card_within_hand_ellipse(i, i.anchorPosition, 0.05)
#		i.set_mouse_filter(0)

## Calculates y position of the card on the hand ellipse
func get_card_y_position_in_hand(xPos):
	var yPos = handEllipseData.calculate_ellipse_y(xPos - handEllipseData.xCenterOffset)
	return yPos

func switch_card_state(card, newState):
	card.transition_state_to(newState)
