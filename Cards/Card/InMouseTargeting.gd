extends CardState

@export var targetingCardPos: Vector2
@export var TargetingPath: Node2D # Node that handles drawing the targeting line

var hasLegalTarget: bool = false

func enter(_msg := {}) -> void:
	Events.slot_hovered.connect(_on_slot_hovered)
	cardBase.z_index = 10
	# Animating card to hover on left side of screen
	tween = create_tween().set_parallel(true).set_ease(Tween.EASE_OUT)
	tween.tween_property(cardBase, 'scale', Vector2(1,1), 0.1)
	tween.tween_property(cardBase, 'position', targetingCardPos, 0.1)
	tween.tween_property(cardBase, 'rotation', 0, 0.1)
	
	# Enabling targetingline
	TargetingPath.set_process(true)

func exit():
	hasLegalTarget = false
	Events.slot_hovered.disconnect(_on_slot_hovered)
	cardBase.z_index = cardBase.anchorZIndex
	
	# Disabling targetingLine, first clearing latest draw
	TargetingPath.clear_draw()
	TargetingPath.set_process(false)


func physics_update(_delta: float) -> void:
	if cardBase.get_get_global_mouse_pos().y > 500:
		state_machine.transition_to("InMouse")


func on_input(_event):
	if Input.is_action_just_released("left_click"):
		if hasLegalTarget == true:
			state_machine.transition_to("InGraveyard")
			Events.emit_signal("card_moved_within_hand")
			play_card()
		else:
			state_machine.transition_to("InHand")
			cardBase.is_not_hovering_in_hand()
	elif Input.is_action_just_pressed("right_click"):
		state_machine.transition_to("InHand")
		cardBase.is_not_hovering_in_hand()

func play_card():
	cardBase.play_card()

func _on_slot_hovered(hovered: bool) -> void:
	if hovered == false:
		hasLegalTarget = false
		TargetingPath.targeting_line_invalid()
		return
	match cardBase.cardInfo.target:
		CardEnums.card_target.SINGLE, \
		CardEnums.card_target.AOE_ENEMY, \
		CardEnums.card_target.SINGLE_ENEMY:
			hasLegalTarget = true
			TargetingPath.targeting_line_valid()
		_:
			return
