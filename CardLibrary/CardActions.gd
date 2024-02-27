# Script for storing methods for cards to use.
class_name CardActions

static func deal_damage (source_card: CardBase, target_slot_num: int, damage_amount: int):
	Events.emit_signal('damage_triggered', source_card, target_slot_num, damage_amount)
