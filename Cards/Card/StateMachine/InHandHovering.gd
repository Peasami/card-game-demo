class_name InHandHovering
extends CardState

func _init() -> void:
	state_enum = GEnums.card_state.IN_HAND_HOVERING
	super()

func enter(_msg := {}) -> void:
	cardBase.is_hovering_in_hand()
	
	cardBase.scale = Vector2(1.2, 1.2)
	cardBase.position = Vector2(cardBase.anchorPosition.x, CardPositionData.zoom_height)
	cardBase.rotation = 0
	
	## Put card to show on top of other cards
	#cardBase.anchorZIndex = cardBase.z_index
	cardBase.z_index = 10

func exit():
	
	if tween:
		tween.stop()

func on_Focus_input_update(_event):
	if _event.is_action_pressed('left_click'):
		state_machine.transition_to('InMouse')
		CardTracking.cardsInHand.erase(cardBase)
	pass


func on_mouse_exited():
	cardBase.transition_state_to("InHand")
	cardBase.is_not_hovering_in_hand()
	cardBase.z_index = cardBase.anchorZIndex
	## Put z_index back to normal so card doesn't show on top of other cards
	
#	var tween = create_tween().set_parallel(true)
#	tween.tween_property(cardBase, 'scale', cardBase.baseScale, 0.05)
#	tween.tween_property(cardBase, 'position', cardBase.anchorPosition, 0.05)
#	tween.tween_property(cardBase, 'rotation', cardBase.anchorRotation, 0.05)
#	cardBase.is_not_hovering_in_hand()
