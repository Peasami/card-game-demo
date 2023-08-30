# Tracks the position/state of cards on the board

extends Node

var cardsInDeck = []
var cardsInHand = []
var cardsInGraveyard = []

var listOfLocations = [cardsInDeck, cardsInHand, cardsInGraveyard]

func change_card_location(card: CardBase, nextLocation: Array):
	for location in listOfLocations:
		if location.has(card):
			location.erase(card)
	nextLocation.append(card)

#
#func get_deck_size() -> int:
#	return cardsInDeck.size()
#
#func get_hand_size() -> int:
#	return cardsInHand.size()
#
#func get_graveyard_size() -> int:
#	return cardsInGraveyard.size()
