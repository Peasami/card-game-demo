extends Node
class_name EnemyBase

@export var enemy_resource: Resource

func _ready():
	%EnemySprite.texture = enemy_resource.sprite

func move_enemy(target_slot: int):
	$GridMoveComponent.move(self, target_slot)

# TODO remove this
# debugging
func _input(event):
	if event.is_action_released("ui_left"):
		%GridMoveComponent.move_left(self)
