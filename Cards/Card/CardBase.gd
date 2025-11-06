# Base for every card.
# Handles interface functions and signals to communicate with other nodes.
# Global variables within a card are declared here?

class_name CardBase
extends Node2D

signal hovered_in_hand
signal de_hovered_in_hand
signal slots_to_highlight(slot_ids: Array[int])
signal card_tween_finished

@export var card_res: CardResBase

## Takes the node that owns this node just above as cardsManager
@onready var cardsManager: Node = $".."
@onready var cardGraphics := %CardGraphics
@onready var fsm := $StateMachine
@onready var state_label := $StateLabel


var cardInfo: Dictionary
var cardProperties: Node
var legalTargets: Array

# anchor values
var anchorPosition:Vector2 ## The destination where card is tweened towards
var anchorRotation:float   ## ^ but for rotation
var anchorZIndex:int = 0 ## ^ but for z_index
var baseScale := Vector2(1, 1)

const deckPos := Vector2(50, 550)

func get_state_enum() -> GEnums.card_state:
	return fsm.get_state_enum()

func _ready() -> void:
	cardGraphics.set_header(card_res.name)
	cardGraphics.set_image(card_res.sprite)
	cardGraphics.set_description(card_res.description)
	cardGraphics.set_manacost(card_res.cost)
	# fsm.state_changed.connect(set_card_state_name)

	fsm.card_tween_finished.connect(_on_card_tween_finished)

func _process(_delta: float) -> void:
	# DEBUGGING #
	state_label.text = fsm.state.name + "\n" + str(z_index) + "\n" + str(anchorPosition)

func _on_card_tween_finished() -> void:
	card_tween_finished.emit()

# Set graphics and text
func initialize_graphics() -> void:
	cardGraphics.set_header(cardInfo["name"])

func get_state_name() -> String:
	return fsm.state.name

# Other nodes outside of this node can call this function to 
# call a transition to another state 
func transition_state_to(newState: String, msg: Dictionary = {}) -> void:
	fsm.transition_to(newState, msg)

# When you want to call teh on_enter() method without transitioning.
func invoke_enter() -> void:
	fsm.invoke_enter()

# Child nodes can call this to inform main scene that this is being hovered 
func is_hovering_in_hand() -> void:
	emit_signal("hovered_in_hand", self)

# Child nodes can call this to inform main scene that this is not being hovered
func is_not_hovering_in_hand() -> void:
	emit_signal("de_hovered_in_hand", self)

func highlight_slots(slot_ids: Array[int]) -> void:
	if card_res.legal_targets.any(func(t: CardEnums.card_target) -> bool: return t in CardEnums.aoe_target_types):
		if slot_ids.size() == 0:
			emit_signal("slots_to_highlight", slot_ids)
		else:
			var aoe_target_slots: Array[int] = CardActions.get_aoe_targets(slot_ids[0], card_res.aoe_size)
			emit_signal("slots_to_highlight", aoe_target_slots)
	elif card_res.legal_targets.any(func(t: CardEnums.card_target) -> bool: return t in CardEnums.single_target_types):
		emit_signal("slots_to_highlight", slot_ids)

func is_tweening() -> bool:
	var state_card: CardState = fsm.state
	return state_card.tween != null