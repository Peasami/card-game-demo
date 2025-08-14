extends CardState

func _init() -> void:
	state_enum = GEnums.card_state.IN_DECK
	super()

func physics_update(_delta: float) -> void:
	# if mouse is on card, and click event occurs,
	# state -> InMouse
	pass
