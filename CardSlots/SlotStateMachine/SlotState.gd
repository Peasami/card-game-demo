class_name SlotState
extends Node

# Reference to the state machine, to call its `transition_to()` method directly.
# That's one unorthodox detail of our state implementation, as it adds a dependency between the
# state and the state machine objects, but we found it to be most efficient for our needs.
# The state machine node will set it.
var state_machine = null
var slot_base: CardSlotBase

# Set reference to the owner of state
func _ready() -> void:
	await owner.ready
	slot_base = owner
	assert(slot_base != null)

# Virtual function. Receives events from the `_unhandled_input()` callback.
func unhandled_input(_event: InputEvent) -> void:
	pass


# Virtual function. Corresponds to the `_process()` callback.
func process(_delta: float) -> void:
	pass


# Virtual function. Corresponds to the `_physics_process()` callback.
func physics_process(_delta: float) -> void:
	pass

func input(_event: InputEvent) -> void:
	pass

func on_focus_mouse_entered() -> void:
	pass

func on_focus_mouse_exited() -> void:
	pass

# Virtual function. Called by the state machine upon changing the active state. The `msg` parameter
# is a dictionary with arbitrary data the state can use to initialize itself.
func enter(_msg := {}) -> void:
	pass


# Virtual function. Called by the state machine before changing the active state. Use this function
# to clean up the state.
func exit() -> void:
	pass
