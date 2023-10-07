# Generic state machine for CardSlot. Initializes states and delegates engine callbacks
# (_physics_process, _unhandled_input) to the active state.
class_name SlotStateMachine
extends Node

# initial state
@onready var state: Node = get_node("SlotEmpty")


func _ready() -> void:
	await owner.ready
	# The state machine assigns itself to the State objects' state_machine property.
	for child in get_children():
		child.state_machine = self
	state.enter() # Calling the inital state enter function


# The state machine subscribes to node callbacks and delegates them to the state objects.
func _unhandled_input(event: InputEvent) -> void:
	state.unhandled_input(event)


func _process(_delta: float) -> void:
	state.process(_delta)


func _physics_process(_delta: float) -> void:
	state.physics_process(_delta)


func transition_to(target_state_name: String, msg: Dictionary = {}) -> void:
	if not has_node(target_state_name):
		return
	state.exit()
	state = get_node(target_state_name)
	state.enter(msg)


func _on_Focus_gui_input(_event) -> void: 
	state.on_Focus_gui_input(_event)

func _input(_event) -> void:
	state.input(_event)

func _on_focus_mouse_entered():
	state.on_focus_mouse_entered()


func _on_focus_mouse_exited():
	state.on_mouse_exited()
