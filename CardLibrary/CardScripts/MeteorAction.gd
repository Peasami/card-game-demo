extends CardActionBase

static func on_play (source_card: CardBase, target_slots: Array[int], values: Array[int]) -> void:
	var column_target_slots: Array[int] = CardActions.get_column_targets(target_slots[0])
	CardActions.deal_damage(source_card, column_target_slots, values[0])
