# Debugging, can display information

extends Label


func _process(_delta):
	text = "CardsInDeck: " + str($"../CardsManager".cardsInDeck.size()) + \
		"\nCardsInHand: " + str($"../CardsManager".cardsInHand.size())
