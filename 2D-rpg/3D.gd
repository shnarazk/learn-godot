extends Node3D

@export
var spin: bool = false:
	set(value):
		if value:
			$AnimationPlayer.current_animation = "new_animation"
			$AnimationPlayer.play()
		else:
			$AnimationPlayer.stop()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

