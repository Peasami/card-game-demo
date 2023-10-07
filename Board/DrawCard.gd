extends TextureButton
signal clicked()

func _pressed():
	emit_signal("clicked", 1)
