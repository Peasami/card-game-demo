extends Node

@export var move_component: Node

func move_enemy(target_slot: int):
	$GridMoveComponent.move(self, target_slot)
