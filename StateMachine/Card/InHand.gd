extends CardState

var originalZIndex ## stores value of z before zooming in, so we can return to it

func enter(_msg := {}) -> void:
	pass

func physics_update(_delta: float) -> void:
	# if mouse is on card, and click event occurs,
	# state -> InMouse
	pass

func on_Focus_input_update(_event):
	pass

func on_mouse_entered():
	var tween = create_tween()
	tween.tween_property(cardBase, 'scale', Vector2(1.5, 1.5), 0.05)
	originalZIndex = cardBase.z_index
	cardBase.is_hovering_in_hand()
	cardBase.z_index = 10

func on_mouse_exited():
	var tween = create_tween()
	tween.tween_property(cardBase, 'scale', Vector2(1, 1), 0.05)
	cardBase.is_not_hovering_in_hand()
	cardBase.z_index = originalZIndex
