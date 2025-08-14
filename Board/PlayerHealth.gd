extends Label

func _process(_delta: float) -> void:
	text = str(PlayerVariables.current_player_health)
