extends CardActionBase

static func on_play (source_card: CardBase, target_slot_num: int, values: Array[int]):
	CardActions.deal_damage(source_card, target_slot_num, values[0])
