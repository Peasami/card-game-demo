extends Node
class_name CardSlotsManager

var card_slot_base := preload("res://CardSlots/CardSlotBase.tscn")

#@export var grid_position: Vector2 = Vector2(400, 150)
#@export var slot_size: Vector2 = Vector2(80, 80)
#@export var gap_size: int = 30

# Creates the grid
# ---------------
# 0 | 1 | 2 | 3 |
# 4 | 5 | 6 | 7 |
# ---------------
# 8 | 9 | 10| 11|
# 12| 13| 14| 15|
# ---------------

func _ready() -> void:
	for i in CardSlotData.total_slot_amount:
		var card_slot_instance: CardSlotBase = card_slot_base.instantiate()
		card_slot_instance.position = CardSlotData.get_slot_position(i)
		
		# TODO Delete this, prints slot number for debugging
		var test_label := Label.new()
		card_slot_instance.add_child(test_label)
		test_label.text = str(i)
		
		card_slot_instance.card_slot_id = i
		card_slot_instance.z_index = -5
		add_child(card_slot_instance)
	Events.emit_signal('grid_created')

func get_card_slot_position(slot_id: int) -> Vector2:
	if ! get_child(slot_id):
		push_error('invalid card slot number')
	return get_child(slot_id).position
