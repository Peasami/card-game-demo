# Debugging, can display information

extends Label


func _process(_delta):
	text = "CardsInDeck: " + str(CardTracking.cardsInDeck.size()) + \
		"\nCardsInHand: " + str(CardTracking.cardsInHand.size()) + \
		"\nCardsInGraveyard: " + str(CardTracking.cardsInGraveyard.size())
