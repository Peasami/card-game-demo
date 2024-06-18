extends CardState

func enter(_msg := {}) -> void:
	if !CardTracking.cardsInMouse.has(cardBase):
		CardTracking.cardsInMouse.append(cardBase)
	cardBase.z_index = 10
	tween = create_tween().set_parallel(true)
	tween.tween_property(cardBase, 'scale', Vector2(1.4,1.4), 0.1)
	tween.tween_property(cardBase, 'position', cardBase.get_global_mouse_position(), 0.1)
	tween.tween_property(cardBase, 'rotation', 0, 0.1)

func exit():
	cardBase.z_index = cardBase.anchorZIndex

func physics_update(_delta: float) -> void:
	#Get the global mouse position from CardBase
	cardBase.position = cardBase.get_global_mouse_position()
	if cardBase.position.y < CardPositionData.hand_targeting_height:
		state_machine.transition_to("InMouseTargeting")
		

func on_Focus_input_update(_event):
	if Input.is_action_just_pressed("right_click") || Input.is_action_just_released("left_click"):
		CardTracking.cardsInMouse.erase(cardBase)
		state_machine.transition_to("InHand")
		cardBase.is_not_hovering_in_hand()
