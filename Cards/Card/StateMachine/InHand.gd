class_name InHand
extends CardState

@export var Focus: TextureButton

func enter(_msg := {}) -> void:
	
#	$"../../Focus".disabled = true
	
	tween = create_tween().set_parallel(true).set_ease(Tween.EASE_OUT)
	tween.tween_property(cardBase, 'scale', cardBase.baseScale, 0.2)
	tween.tween_property(cardBase, 'position', cardBase.anchorPosition, 0.2)
	tween.tween_property(cardBase, 'rotation', cardBase.anchorRotation, 0.2)
	
	# If tweening finishes and mouse is on card, change state accordingly.
	# Has to be custom function inside Focus.gd, because mouse_entered signal 
	# doesn't work when mouse isn't moving.
	await tween.finished
	if Focus.is_being_hovered():
		if tween:
			tween.stop()
		cardBase.transition_state_to("InHandHovering")

func exit():
	tween.stop()

func on_mouse_entered():
	if tween:
		tween.stop()
	cardBase.transition_state_to("InHandHovering")
