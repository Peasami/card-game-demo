extends Node
class_name CardSlotsManager

var card_slot_base = preload("res://CardSlots/CardSlotBase.tscn")

#@export var grid_position: Vector2 = Vector2(400, 150)
#@export var slot_size: Vector2 = Vector2(80, 80)
#@export var gap_size: int = 30

func _ready():
	for i in 16:
		var card_slot_instance = card_slot_base.instantiate()
		card_slot_instance.position = CardSlotData.get_slot_position(i)
		card_slot_instance.card_slot_id = i
		card_slot_instance.z_index = -5
		add_child(card_slot_instance)
		

func get_card_slot_position(slot_id: int) -> Vector2:
	if ! get_child(slot_id):
		push_error('invalid card slot number')
	return get_child(slot_id).position
