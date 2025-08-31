# Keeps track of events
# Handles sending out signals in Events event bus
extends Node

signal dummysignal

var event_queue: Array[QueueEvent] = [QueueEvent.new(dummysignal)]
var queue_running: bool = false

class QueueEvent:
	var my_signal: Signal
	var args: Array
	func _init(my_signal: Signal, args: Array = []) -> void:
		self.my_signal = my_signal
		self.args = args

func _init() -> void:
	# Events.connect("turn_ended", start_event_queue)
	start_event_queue()

func start_event_queue() -> void:
	queue_running = true
	if event_queue.is_empty():
		print("event_queue is empty")
		queue_running = false
		return

	call_next_event()
	start_event_queue()

func append_event(new_signal: Signal, args: Array = []) -> void:
	event_queue.append(QueueEvent.new(new_signal, args))

func call_next_event() -> void:
	assert(!event_queue.is_empty())
	var next_event: QueueEvent = event_queue.pop_at(0)
	assert(next_event.my_signal)
	print("Calling event: ", next_event.my_signal.get_name(), "\nwith arguments: ", next_event.args)
	
	emit_dynamic_signal(next_event.my_signal, next_event.args)

# TODO: Whenever array destructuring comes to godot, rework this junk
func emit_dynamic_signal(signal_to_emit: Signal, args: Array) -> void:
	match args.size():
		0:
			signal_to_emit.emit()
		1:
			signal_to_emit.emit(args[0])
		2:
			signal_to_emit.emit(args[0], args[1])
		3:
			signal_to_emit.emit(args[0], args[1], args[2])
