# Script for storing methods for cards to use.
class_name CardActions

static func deal_damage (source_card: CardBase,target_slot_num: int, damage_amount: int):
	print('deal ', damage_amount, ' damage to slot number ', target_slot_num, '. source of damage: ', source_card)
