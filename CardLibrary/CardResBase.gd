class_name CardResBase
extends Resource

@export var name: String
@export var sprite: CompressedTexture2D
@export var legal_targets: Array[CardEnums.card_target]
@export var on_play_script: Resource
@export var cost: int

func _on_play(source_card: CardBase, target_slot_num: int, values: Array[int]):
	if on_play_script != null and on_play_script.has_method('on_play'):
		on_play_script.on_play(source_card, target_slot_num, values)
