# This node sees all cards and assigns them into proper states
# Manages movement of cards in hand, and assigns anchorPositions for cards. 
# manages instantiating and drawing cards

class_name CardsManager
extends Node

@export var handEllipseData: Node # Has positional info for cards in hand
@export var playerStats: Node # stats like hp and base mana
@export var playerDeck: Node # info on all cards in deck

func _ready():
	# loads and instantiates cards
	for i in 3:
		var card1 = load("res://Cards/Card/CardBase.tscn").instantiate()
		card1.connect("hovered_in_hand", hovering_in_hand)
		card1.connect("de_hovered_in_hand", de_hovering_in_hand)
		card1.initialize_card_as(playerDeck.get_card_instance("Firebolt"))
		add_child(card1)
	
	# Connect signal from event bus. Called whenever a card is moved within hand
	Events.card_moved_within_hand.connect(_on_card_moved_within_hand)

# Called when a card is moved within hand
func _on_card_moved_within_hand():
	print("Signal received in CardsManager card moved within hand")
	organize_hand()

# Called when DrawCards button is clicked
func _on_draw_card_clicked(amountToDraw: int = 1):
	draw_cards(amountToDraw)

# Draw n cards to hand
func draw_cards(amountToDraw: int = 1):
	for i in amountToDraw:
		# Checks if hand is full or deck is empty
		if CardTracking.cardsInHand.size() >= playerStats.maxHandSize || CardTracking.cardsInDeck.size() == 0:
			return
		
		# Get random card from deck
		var drawnCard = CardTracking.cardsInDeck[randi() % CardTracking.cardsInDeck.size()]

		print("Drawing card in draw_cards(): ", drawnCard)
		drawnCard.transition_state_to("InHand")
		organize_hand()
		


# Organizes cards in hand. Assigns anchorPositions to cards based on the number of cards in hand.
# Takes into account cards that are InMouse.
func organize_hand():
	for card in CardTracking.cardsInHand:
		card.anchorPosition = handEllipseData.get_card_position_in_hand(CardTracking.cardsInHand.find(card), CardTracking.cardsInHand.size())
		card.anchorRotation = handEllipseData.get_card_hand_rotation(card.anchorPosition.x)
		# Invokes the enter() function of the current state.
		if card.get_state() == "InHand":
			card.invoke_enter()
		else:
			card.transition_state_to("InHand")

# Called when a card is hovered. Informs other CardBases to dodge
func hovering_in_hand(targetCard: CardBase):
	# Iterates through each other card, to make them move aside by changing their state
	for i in CardTracking.cardsInHand:
		if i == targetCard:
			continue
		if i.position.x < targetCard.position.x:
			i.transition_state_to("InHandDodging", {"cardSide": "left"})
		else:
			i.transition_state_to("InHandDodging", {"cardSide": "right"})

# Called when a card is dehovered. Informs other CardBases to go back to anchorPositions
func de_hovering_in_hand(targetCard: CardBase):
	print("Signal to dehovering in hand")
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



