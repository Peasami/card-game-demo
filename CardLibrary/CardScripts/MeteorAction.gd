extends CardActionBase

static func on_play (source_card: CardBase, target_slots: Array[int], values: Array[int]) -> void:
	var column_target_slots: Array[int] = CardActions.get_aoe_targets(target_slots[0], Vector2i(3, 3))
	CardActions.deal_damage(source_card, column_target_slots, values[0])
