extends Node

const HURT = preload("res://Sounds/Hit.wav")
const JUMP = preload("res://Sounds/Menu Move.wav")

@onready
var audioPlayers: Node = $AudioPlayers

func play_sound(sound: Resource) -> void:
	for audioStreamPlayer in audioPlayers.get_children():
		if not audioStreamPlayer.is_playing():
			audioStreamPlayer.stream = sound
			audioStreamPlayer.play()
			break
