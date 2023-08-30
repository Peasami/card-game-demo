class_name InHand
extends CardState

func enter(_msg := {}) -> void:
	
#	$"../../Focus".disabled = true
	
	tween = create_tween().set_parallel(true).set_ease(Tween.EASE_OUT)
	tween.tween_property(cardBase, 'scale', cardBase.baseScale, 0.2)
	tween.tween_property(cardBase, 'position', cardBase.anchorPosition, 0.2)
	tween.tween_property(cardBase, 'rotation', cardBase.anchorRotation, 0.2)
	
#	await tween.finished
#	$"../../Focus".disabled = false

func exit():
	tween.stop()

func physics_update(_delta: float) -> void:
	# if mouse is on card, and click event occurs,
	# state -> InMouse
	pass

func on_mouse_entered():
	if tween:
		tween.stop()
	cardBase.transition_state_to("InHandHovering")
