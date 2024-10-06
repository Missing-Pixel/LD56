extends Node

const maxTime: int = 45
var levelTime: int
signal endGame

func _ready() -> void:
	levelTime = maxTime
	$"../RichTextLabel2".text = "Time Left: " + str(levelTime)
	$Timer.start()

func _on_timer_timeout() -> void:
	if levelTime <= 0:
		endGame.emit()
	
	levelTime -= 1
	$"../RichTextLabel2".text = "Time Left: " + str(levelTime)
	$Timer.start()
