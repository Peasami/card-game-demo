extends TextureButton

# Manually check if mouse is inside Focus
func is_being_hovered() -> bool:
	var mp := get_local_mouse_position()
	if (position.x+(size.x/2) < mp.x && \
	mp.x < position.x+(size.x*1.5) && \
	position.y+(size.y/2) < mp.y && \
	mp.y < position.y+(size.y*1.5)):
		return true
	else:
		return false
