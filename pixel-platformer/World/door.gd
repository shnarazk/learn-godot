extends Area2D

@export_file("*.tscn")
var target_level_path: String = ""

var player: Node = null

func _process(_delta: float) -> void:
	if not player: return
	if not player.is_on_floor(): return
	if Input.is_action_just_pressed("ui_up"):
		if target_level_path.is_empty():
			return
		go_to_next_level()
		player.on_door = false

func go_to_next_level():
	LevelTransitions.play_exit_transition()
	get_tree().paused = true
	await LevelTransitions.transition_completed
	LevelTransitions.play_enter_transition()
	get_tree().paused = false
	get_tree().change_scene_to_file(target_level_path)

func _on_body_entered(body):
	if not body is Player: return
	player = body
	player.on_door = true

func _on_body_exited(body):
	if body is Player and player:
		player.on_door = false
		player = null
