@tool
extends EditorScript

@export var grid_position: Vector2
@export var slot_size: Vector2 = Vector2(80, 80)

func _run():
	for i in 4:
		for j in 4:
			var slot_node: Node2D = get_scene().get_node("CardSlotsManager").get_child(i*4+j)
			slot_node.position = grid_position + Vector2(j*slot_size.x, i*4*slot_size.y)
	
	#var i: int = 0
	#for node in get_scene().get_node("CardSlotsManager").get_children():
		#node.position = grid_position + Vector2(i*slot_size.x, 0)
