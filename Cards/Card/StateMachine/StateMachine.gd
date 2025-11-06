# Generic state machine. Initializes states and delegates engine callbacks
# (_physics_process, _unhandled_input) to the active state.
class_name StateMachine
extends Node

signal state_changed(new_state_enum: GEnums.card_state)
signal card_tween_finished

# initial state
@onready var state: CardState = get_node("InDeck"):
	set(new_state):
		state_changed.emit(new_state.state_enum)
		state = new_state

func _ready() -> void:
	await owner.ready
	# The state machine assigns itself to the State objects' state_machine property.
	for child in get_children():
		child.state_machine = self
	state.enter()

func get_state_enum() -> GEnums.card_state:
	return state.state_enum

func invoke_enter() -> void:
	state.tween.finished.connect(_on_card_tween_finished)
	state.enter()

# The state machine subscribes to node callbacks and delegates them to the state objects.
func _unhandled_input(event: InputEvent) -> void:
	state.handle_input(event)


func _process(delta: float) -> void:
	state.update(delta)


func _physics_process(delta: float) -> void:
	state.physics_update(delta)


func transition_to(target_state_name: String, msg: Dictionary = {}) -> void:
	print("transitioning to: ", target_state_name)
	if not has_node(target_state_name):
		return
	state.exit()
	state = get_node(target_state_name)
	state.enter(msg)


func _on_Focus_gui_input(event) -> void: 
	state.on_Focus_input_update(event)

func _input(event) -> void:
	state.on_input(event)

func _on_focus_mouse_entered():
	state.on_mouse_entered()


func _on_focus_mouse_exited():
	state.on_mouse_exited()

func _on_card_tween_finished() -> void:
	print("card StateMachine _on_card_tween_finished")
	card_tween_finished.emit()
