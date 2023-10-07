# Tracks the position/state of cards on the board.
# For easier access to location of each card.

extends Node

var cardsInDeck = []
var cardsInHand = []
var cardsInGraveyard = []
var cardsInMouse = []

var listOfLocations = [cardsInDeck, cardsInHand, cardsInGraveyard, cardsInMouse]

# Changes card location.
# Removes card from previous location and adds it to the next location.
func change_card_location(card: CardBase, nextLocation: Array):
	for location in listOfLocations:
		if location.has(card):
			location.erase(card)
	nextLocation.append(card)


