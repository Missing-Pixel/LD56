extends Node

signal sendScore
var saveScore: int = 0

func _ready() -> void:
	self.sendScore.connect(_saveScore)

func _saveScore(getScore):
	saveScore = getScore
