extends CardState


func enter(_msg := {}) -> void:
	#$"../../HandEllipse".draw_card() #Useless if Board.tscn handles card movement
	pass

func physics_update(_delta: float) -> void:
	# if mouse is on card, and click event occurs,
	# state -> InMouse
	pass

func on_Focus_input_update(event):
	if event.is_action_pressed("left_click") && !tween.is_running():
		state_machine.transition_to("InMouse")
		pass
