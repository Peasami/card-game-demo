# Keeps track of events
# Handles sending out signals in Events event bus

## TODO: fix this
extends Node

var event_queue: Array[QueueEvent]
var queue_running: bool = false

var event_running: bool = false

class QueueEvent:
	var my_signal: Signal
	var callable: Callable
	func _init(my_signal: Signal, callable: Callable) -> void:
		self.my_signal = my_signal
		self.callable = callable

func _init() -> void:
	# Events.connect("turn_ended", start_event_queue)
	# start_event_queue()
	return

var number_of_events: int = 0 # For debugging
func start_event_queue() -> void:
	queue_running = true
	if event_queue.is_empty():
		print("event_queue is empty.\n Number of events run: ", number_of_events)
		number_of_events = 0
		queue_running = false
		return
	
	number_of_events += 1

	call_next_event()
	start_event_queue()

signal dummysignal
## Append an event and start queue. If you don't want to start, insert [start_queue] = false
func append_event(new_event: Callable, finished_signal: Signal = dummysignal) -> void:
	print(new_event, " signal: ", finished_signal, "\nConnections: ", finished_signal.get_connections())

	var new_queue_event := QueueEvent.new(finished_signal, new_event)
	
	if finished_signal != dummysignal:
		finished_signal.connect(_on_finished_signal, CONNECT_ONE_SHOT)
	
	event_queue.push_back(new_queue_event)
	
	if event_running == true:
		return
	
	call_next_event()

func _on_finished_signal() -> void:
	event_running = false
	call_next_event()

func call_next_event() -> void:
	# event_running = true
	if event_queue.is_empty():
		return
	var next_event: QueueEvent = event_queue.pop_at(0)
	if next_event.my_signal != dummysignal:
		event_running = true
	next_event.callable.call()
