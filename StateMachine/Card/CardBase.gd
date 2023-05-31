# Base for every card
# Handles interface functions and signals

class_name CardBase
extends Node2D

@onready var cardsManager = $".."

var finalPosition:Vector2 ## The destination where card is tweened towards

@onready var fsm := $StateMachine
@onready var state_label := $StateLabel

func _process(_delta):
	state_label.text = fsm.state.name + "\n" + str(z_index)

func get_state():
	return fsm.state.name

#Called when something wants to draw this card
func transition_state_to(newState):
	fsm.transition_to(newState)
	print("In Cardbase, transitioning to: ", newState)

func is_hovering_in_hand():
	cardsManager.hovering_in_hand(self)

func is_not_hovering_in_hand():
	cardsManager.not_hovering_in_hand(self)
