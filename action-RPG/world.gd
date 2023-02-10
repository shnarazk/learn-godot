extends Node2D

signal game_ended

func _on_player_stats_no_health():
	emit_signal("game_ended")
