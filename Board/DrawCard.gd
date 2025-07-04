extends TextureButton
signal clicked()

func _pressed() -> void:
	print("draw card pressed")
	emit_signal("clicked", 1)
