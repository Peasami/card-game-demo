# Responsible for interface functions
extends Node

@export var InfoNode: Node

signal card_initialized(name: String)

# responsible for making graphics on parent when this is called
func initialize():
	pass

func play_card():
	print(self, " Deals ", InfoNode.dmg, " damage")