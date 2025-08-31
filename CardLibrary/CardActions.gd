# Script for storing methods for cards to use.
class_name CardActions

static func deal_damage (source_card: CardBase, target_slots: Array[int], damage_amount: int) -> void:
	Events.emit_signal('damage_triggered', source_card, target_slots, damage_amount)

## Takes in targeted slot, and aoe size.
## Returns array of slots to target.
# TODO
static func get_aoe_targets(source_card: CardBase, target_slot: int, aoe_size: Vector2i) -> Array[int]:
	var aoe_target_slots: Array[int] = []
	
	
	return aoe_target_slots

## Takes in targeted slot, and returns all slots in that column.
static func get_column_targets(target_slot: int) -> Array[int]:
	var column_target_slots: Array[int] = []
	var column_index: int = target_slot % CardSlotData.x_length
	for i in range(CardSlotData.y_length):
		column_target_slots.append(i * CardSlotData.x_length + column_index)
	return column_target_slots

# func move_left() -> void:
# 	_directional_move(-1)

# func move_right() -> void:
# 	_directional_move(+1)

# func move_up() -> void:
# 	_directional_move(-CardSlotData.x_length)

# func move_down() -> void:
# 	_directional_move(CardSlotData.x_length)
