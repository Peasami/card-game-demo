class_name CardResBase
extends Resource

@export_category("Visual")
@export var name: String
@export var description: String
@export var sprite: CompressedTexture2D
@export_category("Functional")
@export var legal_targets: Array[CardEnums.card_target]
@export var on_play_script: Resource
@export var cost: int
@export var values: Array[int]

func _on_play(source_card: CardBase, target_slots: Array[int]) -> void:
	if on_play_script != null:
		on_play_script.on_play(source_card, target_slots, values)
	else:
		push_error("No on_play_script assigned to card: " + name)
