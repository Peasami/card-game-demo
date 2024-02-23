# Stores positional data for card slots.
class_name CardSlotData

const grid_position: Vector2 = Vector2(584, 100)
const slot_width: int = 168
const slot_center: int = slot_width/2
const middle_gap_size: int = 28
const gap_size: int = 12

# Returns the upper left position of given slot id
static func get_slot_position(slot_id: int):
	return grid_position + Vector2((slot_id % 4) * (slot_width + gap_size) + slot_center, (slot_id/4 % 4) * (slot_width + gap_size) + middle_gap_size * (slot_id/8%8) + slot_center)
