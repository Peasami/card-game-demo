extends CardState

func enter(_msg := {}):
	CardTracking.change_card_location(cardBase, CardTracking.cardsInGraveyard)
	tween = create_tween().set_parallel(true)
	tween.tween_property(cardBase, 'scale', cardBase.baseScale, 0.1)
	tween.tween_property(cardBase, 'position', cardBase.graveyardPos, 0.1)
	tween.tween_property(cardBase, 'rotation', 0, 0.1)