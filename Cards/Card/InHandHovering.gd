class_name InHandHovering
extends CardState

var originalZIndex ## stores value of z before zooming in, so we can return to it

func enter(_msg := {}) -> void:
#	if  _msg.has('lastState') && _msg['lastState'] == 'InMouse':
#		on_mouse_exited()
	
	cardBase.is_hovering_in_hand()
	
	tween = create_tween().set_parallel(true)
	tween.tween_property(cardBase, 'scale', Vector2(1,1), 0)
	tween.tween_property(cardBase, 'position', Vector2(cardBase.anchorPosition.x, 500), 0)
	tween.tween_property(cardBase, 'rotation', 0, 0)
	cardBase.scale = Vector2(1, 1)
	cardBase.position = Vector2(cardBase.anchorPosition.x, 500)
	cardBase.rotation = 0
	
	## Put card to show on top of other cards
	originalZIndex = cardBase.z_index
	cardBase.z_index = 10

func exit():
	
	if tween:
		tween.stop()

func on_Focus_input_update(_event):
	if _event.is_action_pressed('left_click'):
		print('right mouse click')
		state_machine.transition_to('InMouse')
	pass


func on_mouse_exited():
	cardBase.transition_state_to("InHand")
	cardBase.is_not_hovering_in_hand()
	cardBase.z_index = originalZIndex
	## Put z_index back to normal so card doesn't show on top of other cards
	
#	var tween = create_tween().set_parallel(true)
#	tween.tween_property(cardBase, 'scale', cardBase.baseScale, 0.05)
#	tween.tween_property(cardBase, 'position', cardBase.anchorPosition, 0.05)
#	tween.tween_property(cardBase, 'rotation', cardBase.anchorRotation, 0.05)
#	cardBase.is_not_hovering_in_hand()

