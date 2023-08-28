extends CardState

@export var targetingCardPos: Vector2
@export var TargetingPath: Node2D # Node that handles drawing the targeting line

func enter(_msg := {}) -> void:
	cardBase.z_index = 10
	tween = create_tween().set_parallel(true)
	tween.tween_property(cardBase, 'scale', Vector2(1,1), 0.1)
	tween.tween_property(cardBase, 'position', targetingCardPos, 0.1)
	tween.tween_property(cardBase, 'rotation', 0, 0.1)
	
	TargetingPath.set_process(true)

func exit():
	cardBase.z_index = cardBase.anchorZIndex
	TargetingPath.clear_draw()
	TargetingPath.set_process(false)

func physics_update(_delta: float) -> void:
	if cardBase.get_get_global_mouse_pos().y > 500:
		state_machine.transition_to("InMouse")

func on_Focus_input_update(_event):
	if Input.is_action_just_pressed("right_click") || Input.is_action_just_released("left_click"):
		state_machine.transition_to("InHand")
		cardBase.is_not_hovering_in_hand()
