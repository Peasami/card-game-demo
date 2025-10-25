extends Control

func _ready() -> void:
    $VBoxContainer/StartButton.connect("pressed", _on_start_button_pressed)

func _on_start_button_pressed() -> void:
    get_tree().change_scene_to_file("res://Menus/NewGameMenu.tscn")