extends CardState


func enter(_msg := {}) -> void:
	# Card goes to hand
	tween = create_tween()
	tween.tween_property($"../..", 'position', Vector2(100,100), .5)
	pass

func physics_update(_delta: float) -> void:
	# if mouse is on card, and click event occurs,
	# state -> InMouse
	pass
