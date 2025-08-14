# Debugging, can display information

extends Label

func _process(_delta: float) -> void:
	# text = "CardsInDeck: " + str(CardTracking.cardsInDeck.size()) + str(CardTracking.cardsInDeck) +\
	# 	"\nCardsInHand: " + str(CardTracking.get_cards_in_hand().size()) + str(CardTracking.get_cards_in_hand()) +\
	# 	"\nCardsInGraveyard: " + str(CardTracking.cardsInGraveyard.size()) + str(CardTracking.cardsInGraveyard) +\
	# 	"\nCardsInMouse: " + str(CardTracking.cardsInMouse.size()) + str(CardTracking.cardsInMouse)
	return