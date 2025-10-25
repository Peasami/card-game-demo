extends CardActionBase

static func on_play (source_card: CardBase, target_slots: Array[int], values: Array[int]) -> void:
	CardActions.deal_damage(source_card, target_slots, values[0])
