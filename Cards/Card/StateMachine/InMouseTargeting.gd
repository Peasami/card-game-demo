# This state is entered when player drags the card from hand to board.
# Card is zoomed in, and an indicator shows where it is being played on.

extends CardState

@export var targetingCardPos: Vector2
@export var TargetingPath: Node2D # Node that handles drawing the targeting line

var hasLegalTarget: bool = false
var targeted_slot_id: int

func _init() -> void:
	state_enum = GEnums.card_state.IN_MOUSE_TARGETING
	super()

func enter(_msg := {}) -> void:
	Events.slot_hovered.connect(_on_slot_hovered)
	Events.slot_de_hovered.connect(_on_slot_de_hovered)
	cardBase.z_index = 10
	# Animating card to hover on left side of screen
	tween = create_tween().set_parallel(true).set_ease(Tween.EASE_OUT)
	tween.tween_property(cardBase, 'scale', Vector2(1,1), 0.1)
	tween.tween_property(cardBase, 'position', targetingCardPos, 0.1)
	tween.tween_property(cardBase, 'rotation', 0, 0.1)

func exit() -> void:
	hasLegalTarget = false
	Events.slot_hovered.disconnect(_on_slot_hovered)
	Events.slot_de_hovered.disconnect(_on_slot_de_hovered)
	cardBase.highlight_slots([]) # Clear highlights
	cardBase.z_index = cardBase.anchorZIndex
	
	TargetingPath.clear_draw()


func physics_update(_delta: float) -> void:
	TargetingPath.draw_curve()
	
	if cardBase.get_global_mouse_position().y > CardPositionData.hand_targeting_height:
		state_machine.transition_to("InMouse")


func on_input(_event: InputEvent) -> void:
	if Input.is_action_just_released("left_click"):
		if hasLegalTarget == true && PlayerVariables.current_mana >= cardBase.card_res.cost:
			state_machine.transition_to("InGraveyard")
			Events.emit_signal("mana_spent", cardBase.card_res.cost)
			Events.emit_signal("card_moved_within_hand")
			cardBase.is_not_hovering_in_hand()
			cardBase.card_res._on_play(cardBase, [targeted_slot_id])
		else:
			state_machine.transition_to("InHand")
			cardBase.is_not_hovering_in_hand()
	elif Input.is_action_just_pressed("right_click"):
		state_machine.transition_to("InHand")
		cardBase.is_not_hovering_in_hand()


# Called when a slot sends a signal that it is hovered.
#/ TODO: Match each slot state to card's legal targets
func _on_slot_hovered(slot_state: GEnums.slot_state, slot_id: int) -> void:
	print("Slot state: ", slot_state)
	targeted_slot_id = slot_id
	for i in cardBase.card_res.legal_targets:
		match i:
			CardEnums.card_target.SINGLE, \
			CardEnums.card_target.AOE_ENEMY, \
			CardEnums.card_target.SINGLE_ENEMY:
				if slot_state == GEnums.slot_state.ENEMY:
					hasLegalTarget = true
					TargetingPath.targeting_line_valid()
					cardBase.highlight_slots([slot_id])
				else:
					cardBase.highlight_slots([])
			CardEnums.card_target.AOE:
				hasLegalTarget = true
				TargetingPath.targeting_line_valid()
				cardBase.highlight_slots([slot_id])
			_:
				return

func _on_slot_de_hovered() -> void:
	hasLegalTarget = false
	TargetingPath.targeting_line_invalid()
