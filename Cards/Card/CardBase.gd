# Base for every card.
# Handles interface functions and signals to communicate with other nodes.
# Global variables within a card are declared here?

class_name CardBase
extends Node2D

signal hovered_in_hand
signal de_hovered_in_hand

## Takes the node that owns this node just above as cardsManager
@onready var cardsManager: Node = $".."
@onready var cardGraphics := $CardGraphics
@onready var fsm := $StateMachine
@onready var state_label := $StateLabel

var cardInfo: Dictionary
var cardProperties: Node
var legalTargets: Array

# anchor values
var anchorPosition:Vector2 ## The destination where card is tweened towards
var anchorRotation:float   ## ^ but for rotation
var anchorZIndex:int = 0 ## ^ but for z_index
var baseScale := Vector2(0.5,0.5)

# Should probably be a global singleton
const graveyardPos := Vector2(1100, 550)
const deckPos := Vector2(50, 550)

func _process(_delta):
	# DEBUGGING #
	state_label.text = fsm.state.name + "\n" + str(z_index) + "\n" + str(anchorPosition)

# Initializing card properities.
# Takes in an instance of cardProperties node,
# Which defines the functionality of each card
func initialize_card_as(cardNodeInstance: Node):
	cardProperties = cardNodeInstance
	# Cloning cardInfo -Array to this node for better access
	cardInfo = cardNodeInstance.get_card_info_array()
	#legalTargets = CARDINFO.
	print("legal targets: ", legalTargets)
	add_child(cardNodeInstance)
	initialize_graphics()
	print("initializing card as: ",cardNodeInstance)

# Set graphics and text
func initialize_graphics():
	$CardGraphics.set_header(cardInfo["name"])

# Called when card is played legally
func play_card() -> void:
	cardProperties.play_card()



func get_state():
	return fsm.state.name

# Other nodes outside of this node can call this function to 
# call a transition to another state 
func transition_state_to(newState, msg: Dictionary = {}):
	fsm.transition_to(newState, msg)
	print("transitioning to: ", newState)

# When you want to call teh on_enter() method without transitioning.
func invoke_enter():
	fsm.invoke_enter()


# Child nodes can call this to inform main scene that this is being hovered 
func is_hovering_in_hand():
	emit_signal("hovered_in_hand", self)

# Child nodes can call this to inform main scene that this is not being hovered
func is_not_hovering_in_hand():
	emit_signal("de_hovered_in_hand", self)

# Maybe needed. Sometimes cards in hand do not overlap properly,
# and one card is on top of another card based on initialization order.
func set_mouse_filter(value: int):
	$Focus.mouse_filter = value

# Returns the global mouse position for child nodes
func get_get_global_mouse_pos():
	return get_global_mouse_position()
