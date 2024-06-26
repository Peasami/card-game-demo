class_name CardResBase
extends Resource

@export var name: String
@export var sprite: CompressedTexture2D
@export var legal_targets: Array[CardEnums.card_target]
@export var on_play_script: Resource
@export var cost: int
@export var values: Array[int]

func _on_play(source_card: CardBase, target_slots: Array[int]):
	if on_play_script != null :
		on_play_script.on_play(source_card, target_slots, values)
