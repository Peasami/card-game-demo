## Used to call turn end signals, but probably better to connect turn end to affected nodes themselves and not have this middleware.

extends Node

# func _init() -> void:
# 	Events.turn_ended.connect(initialize_end_turn)

# func initialize_end_turn() -> void:
# 	EventQueue.append_event(func() -> void:
# 		Events.enemies_move_called.emit(GEnums.DIR.LEFT),
# 		Events.enemies_move_finished
# 	)
# 	EventQueue.append_event(func() -> void:
# 		Events.hand_reset_called.emit(5)
# 	)
# 	EventQueue.start_event_queue()
