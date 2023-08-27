# Base for every card
# Handles interface functions and signals

class_name CardBase
extends Node2D

## Takes the node that owns this node just above as cardsManager
@onready var cardsManager: Node = $".."

var anchorPosition:Vector2 ## The destination where card is tweened towards
var anchorRotation:float   ## ^ but for rotation
var baseScale := Vector2(0.5,0.5)


@onready var fsm := $StateMachine
@onready var state_label := $StateLabel

func _process(_delta):
	state_label.text = fsm.state.name + "\n" + str(z_index)

func get_state():
	return fsm.state.name

#Called when something wants to draw this card
func transition_state_to(newState, msg: Dictionary = {}):
	fsm.transition_to(newState, msg)
	print("In Cardbase, transitioning to: ", newState)

func is_hovering_in_hand():
	cardsManager.hovering_in_hand(self)

func is_not_hovering_in_hand():
	cardsManager.de_hovering_in_hand(self)

func set_mouse_filter(value: int):
	$Focus.mouse_filter = value

func get_get_global_mouse_pos():
	return get_global_mouse_position()

func get_in_hand_state():
	return $StateMachine/InHand.local_state

func set_in_hand_state(state):
	$StateMachine/InHand.local_state = state
