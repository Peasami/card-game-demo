extends CardState

func _init() -> void:
	state_enum = GEnums.card_state.IN_DECK
	super()

func enter(_msg := {}) -> void:
	CardTracking.cardsInDeck.append(cardBase)

func exit() -> void:
	CardTracking.cardsInDeck.erase(cardBase)

func physics_update(_delta: float) -> void:
	# if mouse is on card, and click event occurs,
	# state -> InMouse
	pass
