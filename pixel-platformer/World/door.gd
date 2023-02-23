extends Area2D

@export_file("*.tscn")
var target_level_path: String = ""

func _on_body_entered(body):
	if not body is Player:
		return
	if target_level_path.is_empty():
		return
	get_tree().change_scene_to_file(target_level_path)
