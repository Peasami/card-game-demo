# Character that moves and jumps.
class_name CardBase
extends Node2D

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

func get_get_global_mouse_pos():
	return get_global_mouse_position()

func get_hand_size():
	return $"..".get_hand_size()
