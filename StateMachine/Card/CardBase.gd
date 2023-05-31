# Base for every card
# Handles interface functions and signals

class_name CardBase
extends Node2D

signal hovered_in_hand

var finalPosition:Vector2 ## The destination where card is tweened towards

@onready var fsm := $StateMachine
@onready var state_label := $StateLabel

func _process(_delta):
	state_label.text = fsm.state.name

func get_state():
	return fsm.state.name

#Called when something wants to draw this card
func transition_state_to(newState):
	fsm.transition_to(newState)
	print("In Cardbase, transitioning to: ", newState)
