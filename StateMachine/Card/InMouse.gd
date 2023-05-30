extends CardState

func enter(_msg := {}) -> void:
	# Card goes to hand
	pass

func physics_update(_delta: float) -> void:
	
	#Get the global mouse position from CardBase
	$"../..".position = $"../..".get_get_global_mouse_pos()
	
	if Input.is_action_just_pressed("right_click") || Input.is_action_just_released("left_click"):
		state_machine.transition_to("InHand")
