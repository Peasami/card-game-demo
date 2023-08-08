class_name InHandDodging
extends CardState

var originalZIndex ## stores value of z before zooming in, so we can return to it

func enter(_msg := {}) -> void:
	print("message: ", _msg)
	var tween = create_tween().set_parallel(true)
	tween.tween_property(cardBase, 'position', cardBase.anchorPosition - Vector2(50, 0), 0.1)

func physics_update(_delta: float) -> void:
	# if mouse is on card, and click event occurs,
	# state -> InMouse
	pass

func on_Focus_input_update(_event):
#	if _event.is_action_pressed('left_click'):
#		print('right mouse click')
#		state_machine.transition_to('InMouse')
	pass

func on_mouse_entered():
#	var tween = create_tween().set_parallel(true)
#	tween.tween_property(cardBase, 'scale', Vector2(1,1), 0)
#	tween.tween_property(cardBase, 'position', Vector2(cardBase.anchorPosition.x, 500), 0)
#	tween.tween_property(cardBase, 'rotation', 0, 0)
##	cardBase.scale = Vector2(1, 1)
##	cardBase.position = Vector2(cardBase.anchorPosition.x, 500)
##	cardBase.rotation = 0
#	originalZIndex = cardBase.z_index
#	cardBase.is_hovering_in_hand()
#	cardBase.z_index = 10
	pass

func on_mouse_exited():
#	var tween = create_tween().set_parallel(true)
#	tween.tween_property(cardBase, 'scale', cardBase.baseScale, 0.05)
#	tween.tween_property(cardBase, 'position', cardBase.anchorPosition, 0.05)
#	tween.tween_property(cardBase, 'rotation', cardBase.anchorRotation, 0.05)
#	cardBase.is_not_hovering_in_hand()
#	cardBase.z_index = originalZIndex
	pass
