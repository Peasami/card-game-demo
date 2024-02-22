extends Node

@export var movespeed: int

func move(moving_node: Node2D, target_slot: int):
	moving_node.position = CardSlotData.get_slot_position(target_slot)
