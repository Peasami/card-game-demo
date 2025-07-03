extends Node

signal moved_in_grid(new_slot_id: int)

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

# moves target unconditionally without checking legality
func move(moving_node: EnemyBase, target_slot: int) -> void:
	moving_node.position = CardSlotData.get_slot_position(target_slot)
	set_current_slot(target_slot)

# Called with an offset by move_dir() methods
func directional_move(moving_node: EnemyBase, target_offset: int) -> void:
	var target_slot: int = on_slot_id + target_offset
	if !legal_slots.has(target_slot):
		print('invalid move direction')
		return
	moving_node.position = CardSlotData.get_slot_position(target_slot)
	set_current_slot(target_slot)

# send a signal whenever on_slot_id is changed
func set_current_slot(slot_id: int) -> void:
	on_slot_id = slot_id
	emit_signal('moved_in_grid', on_slot_id)

func move_left(moving_node: EnemyBase) -> void:
	directional_move(moving_node, -1)

func move_right(moving_node: EnemyBase) -> void:
	directional_move(moving_node, +1)

func move_up(moving_node: EnemyBase) -> void:
	directional_move(moving_node, -4)

func move_down(moving_node: EnemyBase) -> void:
	directional_move(moving_node, +4)
