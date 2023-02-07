extends Area2D

var player = null

func can_see_player() -> bool:
	return player != null

func _on_body_entered(body) -> void:
	player = body

func _on_body_exited(body) -> void:
	player = null
