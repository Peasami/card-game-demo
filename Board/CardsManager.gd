# This node sees all cards and assigns them into proper states
# Manages movement of cards in hand, and assigns anchorPositions for cards. 
# manages drawing cards

class_name CardsManager
extends Node

@export var handEllipseData: Node # Has positional info for cards in hand
@export var playerStats: Node # stats like hp and base mana


func _ready():
	for i in get_children():
		if i.get_state() == "InDeck":
			CardTracking.cardsInDeck.append(i)
	Events.card_moved_within_hand.connect(_on_card_moved_within_hand)

func _on_card_moved_within_hand():
	organize_hand()

func _on_DrawCard_draw_cards(amountToDraw: int = 1):
	draw_cards(amountToDraw)

# Draw n cards to hand
func draw_cards(amountToDraw: int = 1):
	for i in amountToDraw:	
		if CardTracking.cardsInHand.size() >= playerStats.maxHandSize:
			return
		
		var drawnCard = CardTracking.cardsInDeck[randi() % CardTracking.cardsInDeck.size()] # Gets random card from hand
		
#		set_card_anchor_position(drawnCard)
		
		
		
		CardTracking.cardsInDeck.erase(drawnCard)
		CardTracking.cardsInHand.append(drawnCard)
		organize_hand()
		drawnCard.transition_state_to("InHand")



# Gets card's positioning and rotation, given the number of cards already in hand
# MAY BECOME UNNECESSARY
func set_card_anchor_position(card):
	card.anchorPosition = handEllipseData.get_card_hand_position(CardTracking.cardsInHand.size())
	var cardPosInHand:Vector2 = card.anchorPosition
	card.anchorRotation = handEllipseData.get_card_hand_rotation(cardPosInHand.x)

	card.z_index = CardTracking.cardsInHand.size() ## give z_index higher than other cards in hand

# Replaces reorganize_hand() function, which should be deleted if this works
func organize_hand():
	for card in CardTracking.cardsInHand:
		card.anchorPosition = handEllipseData.get_card_position_in_hand(CardTracking.cardsInHand.find(card), CardTracking.cardsInHand.size())
		card.anchorRotation = handEllipseData.get_card_hand_rotation(card.anchorPosition.x)
		card.transition_state_to("InHand")
		print(card, " AnchorPosition: ",card.anchorPosition)
		print(card, " bsearch: ",CardTracking.cardsInHand.find(card))

# Determine new position for each card in hand after drawing a card
# SHOULD BE REDONE FOR GENERAL USE, NOT JUST FOR ADDING CARDS TO HAND
func reorganize_hand():
	for i in CardTracking.cardsInHand:
		var x = i.anchorPosition.x - handEllipseData.distanceBetweenCards ## Calculate x and y in hand
		var y = get_card_y_position_in_hand(x)
		i.anchorRotation = handEllipseData.get_card_hand_rotation(x)
		i.anchorPosition = Vector2(x,y)
		i.transition_state_to("InHand")

# Called when a CardBase is hovered. Informs other CardBases to dodge
func hovering_in_hand(targetCard: CardBase):
	var amountToMove = 50
	
	### Iterates through each other card, to make them move aside by changing their state
	for i in CardTracking.cardsInHand:
		if i == targetCard:
			continue
		if i.position.x < targetCard.position.x:
			i.transition_state_to("InHandDodging", {"cardSide": "left"})
		else:
			i.transition_state_to("InHandDodging", {"cardSide": "right"})

# Called when a CardBase is dehovered. Informs other CardBases to go back to anchorPositions
func de_hovering_in_hand(targetCard: CardBase):
	for i in CardTracking.cardsInHand:
		if i == targetCard:
			continue
		i.transition_state_to("InHand")

## Calculates y-position of the card on the hand ellipse when x-position is known
func get_card_y_position_in_hand(xPos):
	var yPos = handEllipseData.calculate_ellipse_y(xPos - handEllipseData.xCenterOffset)
	return yPos

func switch_card_state(card, newState):
	card.transition_state_to(newState)
