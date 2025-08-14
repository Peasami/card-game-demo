# Tracks the position/state of cards on the board.
# For easier access to location of each card.
extends Node

var cards_manager_node: CardsManager

func _ready() -> void:
	cards_manager_node = get_node("/root/BoardBase/CardsManager")

func get_cards_in_deck() -> Array[CardBase]:
	var cards_in_deck: Array[CardBase]
	for card: CardBase in cards_manager_node.get_children():
		if card.get_state_enum() == GEnums.card_state.IN_DECK:
			cards_in_deck.append(card)
	return cards_in_deck

func get_cards_in_hand() -> Array[CardBase]:
	var cards_in_hand: Array[CardBase]
	for card: CardBase in cards_manager_node.get_children():
		if card.get_state_enum() == GEnums.card_state.IN_HAND:
			cards_in_hand.append(card)
	return cards_in_hand

var cardsInDeck := []
var cardsInHand := []
var cardsInGraveyard := []
var cardsInMouse := []

var listOfLocations := [cardsInDeck, cardsInHand, cardsInGraveyard, cardsInMouse]

# Changes card location.
# Removes card from previous location and adds it to the next location.
func change_card_location(card: CardBase, next_location: Array) -> void:
	for location: Array in listOfLocations:
		if location.has(card):
			location.erase(card)
	next_location.append(card)
