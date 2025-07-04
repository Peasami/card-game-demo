extends TextureButton

func _pressed() -> void:
    print("pressed turn end")
    Events.turn_ended.emit()