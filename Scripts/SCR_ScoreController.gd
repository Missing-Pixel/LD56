extends Node2D

var score: int

func _ready() -> void:
	score = 0
	ScrDatamanager.sendScore.connect(_score_get)

func _score_get(scoreGet):
	score += scoreGet
	$"../RichTextLabel".text = ("Score: " + str(score))

func _on_time_controller_end_game() -> void:
	ScrDatamanager.sendScore.emit(score)
	get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")
