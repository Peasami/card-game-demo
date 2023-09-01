# Responsible for interface functions for graphics

extends Node2D

@export var Header: Label

func set_header(header: String):
	Header.text = header
