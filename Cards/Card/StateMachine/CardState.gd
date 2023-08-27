# Virtual base class for all card states.

class_name CardState
extends Node

# We store a reference to the state machine to call its `transition_to()` method directly.
var state_machine: Node = null
var cardBase: CardBase
var tween: Tween

func _ready() -> void:
	await owner.ready
	cardBase = owner as CardBase
	assert(cardBase != null)

# All methods below are virtual and called by the state machine.
func handle_input(_event: InputEvent) -> void:
	pass


# Corresponds to the `_process()` callback.
func update(_delta: float) -> void:
	pass


# Corresponds to the `_physics_process()` callback.
func physics_update(_delta: float) -> void:
	pass


# Called by the state machine upon changing the active state. The `msg` parameter
# is a dictionary with arbitrary data the state can use to initialize itself.
func enter(_msg := {}) -> void:
	pass


# Called by the state machine before changing the active state. Use this function
# to clean up the state.
func exit() -> void:
	pass

func on_Focus_input_update(_event) -> void:
	pass


func on_mouse_entered():
	pass


func on_mouse_exited():
	pass
