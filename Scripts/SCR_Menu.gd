extends Node


func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/level.tscn")

func _ready() -> void:
	$CanvasLayer/RichTextLabel.text = ("[center]High Score: " + str(ScrDatamanager.saveScore))
