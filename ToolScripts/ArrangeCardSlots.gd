@tool
extends EditorScript

@export var grid_position: Vector2 = Vector2(400, 150)
@export var slot_size: Vector2 = Vector2(80, 80)
@export var gap_size: int = 30

func _run():
	for i in 4:
		for j in 4:
			var slot_node: Node2D = get_scene().get_node("CardSlotsManager").get_child(i*4+j)
			if i < 2:
				slot_node.position = grid_position + Vector2(j*slot_size.x, i*slot_size.y)
				slot_node.card_slot_type = Enums.card_slot_type.ENEMY
			else:
				slot_node.position = grid_position + Vector2(j*slot_size.x, gap_size+i*slot_size.y)
				slot_node.card_slot_type = Enums.card_slot_type.ALLY
			slot_node.card_slot_id = j+i*4
	#var i: int = 0
	#for node in get_scene().get_node("CardSlotsManager").get_children():
		#node.position = grid_position + Vector2(i*slot_size.x, 0)
