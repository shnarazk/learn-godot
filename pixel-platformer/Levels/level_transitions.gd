extends CanvasLayer

signal transition_completed

@onready
var animation_player = $AnimationPlayer

func play_exit_transition() -> void:
	animation_player.play("ExitLevel")

func play_enter_transition() -> void:
	animation_player.play("RESET")

func _on_animation_player_animation_finished(anim_name):
	if anim_name == "ExitLevel":
		#emit_signal("transition_completed")
		transition_completed.emit()
