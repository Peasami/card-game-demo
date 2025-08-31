extends CardState

func _init() -> void:
	state_enum = GEnums.card_state.IN_DECK
	super()

func enter(_msg := {}) -> void:
	tween = create_tween().set_parallel(true)
	tween.tween_property(cardBase, 'scale', cardBase.baseScale, 0.1)
	tween.tween_property(cardBase, 'position', CardPositionData.deck_position, 0.1)
	tween.tween_property(cardBase, 'rotation', 0, 0.1)