extends Node

signal grid_move_requested(new_position: Vector2, new_slot_id: int)
signal reached_end_of_grid()

@export var movespeed: int
@export var clamp_values: int
@export_category('legal_slots')
@export var ALLY: bool
@export var ENEMY: bool

var legal_slots: Array[int]

var on_slot_id: int # stores id of slot the enemy is on

func _ready() -> void:
	# Append legal slots
	if ALLY == true:
		legal_slots.append_array(CardSlotData.legal_slots_ally)
	if ENEMY == true:
		legal_slots.append_array(CardSlotData.legal_slots_enemy)

# Request move to slot id without checking legality
func move_to_slot(target_slot: int) -> void:
	# Get global position of new slot from the slot ID
	var new_position: Vector2 = CardSlotData.slot_id_to_vector(target_slot)
	grid_move_requested.emit(new_position, target_slot)
	on_slot_id = target_slot

## Call this function from other scripts
##
## Calls move_direction(), which then calls directional_move()
func move_direction(direction: GEnums.DIR) -> void:
	match direction:
		GEnums.DIR.LEFT:
			move_left()
		GEnums.DIR.RIGHT:
			move_right()
		GEnums.DIR.UP:
			move_up()
		GEnums.DIR.DOWN:
			move_down()

func move_left() -> void:
	_directional_move(-1)

func move_right() -> void:
	_directional_move(+1)

func move_up() -> void:
	_directional_move(-CardSlotData.x_length)

func move_down() -> void:
	_directional_move(CardSlotData.x_length)

## Don't call from outside.
##
## Called with an offset by move_dir() methods
## [target_offset] is offset from current slot id to target slot id 
func _directional_move(target_offset: int) -> void:
	var target_slot: int = on_slot_id + target_offset
	# Check if the target slot is within bounds and not a wall
	if target_slot < 0 or (target_slot + 1) % CardSlotData.x_length == 0:
		print('enemy reached end of grid')
		emit_signal('reached_end_of_grid')
		return
	# if !legal_slots.has(target_slot):
	# 	print('invalid move direction')
	# 	return
	var new_position: Vector2 = CardSlotData.slot_id_to_vector(target_slot)
	grid_move_requested.emit(new_position, target_slot)
	on_slot_id = target_slot
