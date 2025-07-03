# Script for storing methods for cards to use.
class_name CardActions

static func deal_damage (source_card: CardBase, target_slots: Array[int], damage_amount: int) -> void:
	Events.emit_signal('damage_triggered', source_card, target_slots, damage_amount)
