class_name CardResBase
extends Resource

@export var name: String
@export var sprite: CompressedTexture2D
@export var legal_targets: Array[CARDINFO.targetTypes]
@export var on_play_script: Resource
@export var cost: int

func _on_play():
	if on_play_script != null and on_play_script.has_method('on_play'):
		on_play_script.on_play()
