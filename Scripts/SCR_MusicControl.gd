extends Node

var get_stream = load("res://Kaiju Song.wav")

func _ready() -> void:
	$AudioStreamPlayer.stream = get_stream
	$AudioStreamPlayer.play()

func _on_audio_stream_player_finished() -> void:
	$AudioStreamPlayer.play()
