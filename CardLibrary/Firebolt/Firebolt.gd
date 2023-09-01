# Responsible for interface functions
extends Node

@export var InfoNode: Node

signal card_initialized(name: String)

func play_card():
	print(self, " Deals ", InfoNode.cardInfoArray["damage"], " damage")

func get_card_info_array() -> Dictionary:
	return InfoNode.get_card_info_array()

func get_card_name() -> String:
	return InfoNode.cardName

func get_card_damage() -> int:
	return InfoNode.damage

func get_card_target() -> int:
	return InfoNode.target
