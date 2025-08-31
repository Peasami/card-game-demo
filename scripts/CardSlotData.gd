# Stores positional data for card slots.
class_name CardSlotData

const x_length: int = 8
const y_length: int = 4

const total_slot_amount: int = x_length * y_length

const grid_position: Vector2 = Vector2(584, 400)
const slot_width: int = 168 / 2
const slot_center: int = slot_width / 2
const middle_gap_size: int = 28
const gap_size: int = 12

# Not used for now
const legal_slots_enemy: Array[int] = [0, 1, 2, 3, 4, 5, 6, 7]
const legal_slots_ally: Array[int] = [8, 9, 10, 11, 12, 13, 14, 15]


# Creates the grid
# ---------------
# 0 | 1 | 2 | 3 |
# 4 | 5 | 6 | 7 |
# ---------------
# 8 | 9 | 10| 11|
# 12| 13| 14| 15|
# ---------------

# Returns the upper left position of given slot id
static func slot_id_to_vector(slot_id: int) -> Vector2:
	return grid_position + Vector2(
		(slot_id % x_length) * (slot_width + gap_size) + slot_center,
		(slot_id / x_length % y_length) * (slot_width + gap_size) # + middle_gap_size * (slot_id / 16 % 16) + slot_center
	)
