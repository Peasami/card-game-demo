# Stores positional data for card slots.
class_name CardSlotData

const grid_position: Vector2 = Vector2(400, 150)
const slot_width: int = 80
const gap_size: int = 30

# Returns the upper left position of given slot id
static func get_slot_position(slot_id: int):
	return grid_position + Vector2((slot_id % 4) * slot_width, (slot_id/4 % 4) * slot_width + gap_size * (slot_id/8%8))
