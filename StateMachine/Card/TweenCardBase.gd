extends Tween


func move_card(target_pos):
	interpolate_property( get_node('/root'), 'rect_position', Vector2(0,0), target_pos, 1, Tween.TRANS_CUBIC, Tween.EASE_IN_OUT)
	start()
