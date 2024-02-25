extends Node

@export var movespeed: int
@export var signal_to_emit: String
@export var clamp_values: int

@export_category('legal_slots')
@export var ALLY: bool
@export var ENEMY: bool

var legal_slots: Array[int]

var on_slot_id: int # stores id of slot the enemy is on

func _ready():
	# Append legal slots
	if ALLY == true:
		legal_slots.append_array(CardSlotData.legal_slots_ally)
	if ENEMY == true:
		legal_slots.append_array(CardSlotData.legal_slots_enemy)

func move(moving_node: EnemyBase, target_slot: int):
	moving_node.position = CardSlotData.get_slot_position(target_slot)
	Events.emit_signal(signal_to_emit, moving_node, target_slot)
	on_slot_id = target_slot

func directional_move(moving_node: EnemyBase, target_offset: int):
	var target_slot = on_slot_id + target_offset
	if !legal_slots.has(target_slot):
		print('invalid move direction')
		return
	moving_node.position = CardSlotData.get_slot_position(target_slot)
	Events.emit_signal(signal_to_emit, moving_node, target_slot)
	on_slot_id = target_slot

func move_left(moving_node: EnemyBase):
	directional_move(moving_node, -1)

func move_right(moving_node: EnemyBase):
	directional_move(moving_node, +1)

func move_up(moving_node: EnemyBase):
	directional_move(moving_node, -4)

func move_down(moving_node: EnemyBase):
	directional_move(moving_node, +4)

