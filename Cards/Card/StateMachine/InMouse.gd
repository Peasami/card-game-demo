extends CardState

func enter(_msg := {}) -> void:
	cardBase.z_index = 10
	pass

func exit():
	cardBase.z_index = cardBase.anchorZIndex

func physics_update(_delta: float) -> void:
	
	#Get the global mouse position from CardBase
	cardBase.position = cardBase.get_get_global_mouse_pos()

func on_Focus_input_update(_event):
	if Input.is_action_just_pressed("right_click") || Input.is_action_just_released("left_click"):
		state_machine.transition_to("InHand")
		cardBase.is_not_hovering_in_hand()
