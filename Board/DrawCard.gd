extends TextureButton
signal clicked()

func _pressed() -> void:
	print("draw card pressed")
	print(CardTracking.get_cards_in_deck())
	emit_signal("clicked", 1)
