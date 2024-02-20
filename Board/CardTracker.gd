# Debugging, can display information

extends Label

func _process(_delta):
	text = "CardsInDeck: " + str(CardTracking.cardsInDeck.size()) + str(CardTracking.cardsInDeck) +\
		"\nCardsInHand: " + str(CardTracking.cardsInHand.size()) + str(CardTracking.cardsInHand) +\
		"\nCardsInGraveyard: " + str(CardTracking.cardsInGraveyard.size()) + str(CardTracking.cardsInGraveyard) +\
		"\nCardsInMouse: " + str(CardTracking.cardsInMouse.size()) + str(CardTracking.cardsInMouse)
