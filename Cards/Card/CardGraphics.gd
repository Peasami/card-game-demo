# Responsible for interface functions for graphics

extends Node2D

@export var Header: Label
@export var target_size: Vector2 = Vector2(50, 43)

func set_header(header: String) -> void:
	Header.text = header

func set_image(image: Texture2D) -> void:
	var texture_size := image.get_size()
	$CardImage.texture = image
	$CardImage.scale = target_size / texture_size * 4
	$CardImage.position = Vector2(-100, -144)

func set_description(description: String) -> void:
	$Description.text = description
