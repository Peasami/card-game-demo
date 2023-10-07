extends CardState


func enter(_msg := {}) -> void:
	CardTracking.cardsInDeck.append(cardBase)

func exit() -> void:
	CardTracking.cardsInDeck.erase(cardBase)

func physics_update(_delta: float) -> void:
	# if mouse is on card, and click event occurs,
	# state -> InMouse
	pass
