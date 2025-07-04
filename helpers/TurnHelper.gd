extends Node

func _init() -> void:
    Events.turn_ended.connect(initialize_end_turn)

func initialize_end_turn() -> void:
    EventQueue.append_event(Events.enemies_move_called, [GEnums.DIR.LEFT])
    EventQueue.append_event(Events.hand_reset_called, [5])
    EventQueue.start_event_queue()