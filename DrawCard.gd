extends TextureButton
signal draw_cards()

func _pressed():
	emit_signal("draw_cards", 1)
