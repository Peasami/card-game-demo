class_name CardSlotBase
extends Node2D

@export var card_slot_id: int
@export var card_slot_type: Enums.card_slot_type
@export var state_machine: Node

var slotted_enemy: EnemyBase

func get_state() -> String:
	return state_machine.name
