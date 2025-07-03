extends TextureButton

func _pressed() -> void:
    Events.emit_signal("turn_ended")