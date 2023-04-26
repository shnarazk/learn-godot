extends Node3D

@export
var spin: bool = false:
	set(value):
		if value:
			$AnimationPlayer.current_animation = "new_animation"
			$AnimationPlayer.play()
		else:
			$AnimationPlayer.stop()

var target: int = 0

func set_item(index: int):
	if index == -1:
		target = randi_range(1, 2)
	else:
		target = index
	$Stage/boy.visible = false
	$Stage/suzanne.visible = false
	match target:
		1:
			$Stage/suzanne.visible = true
		2:
			$Stage/boy.visible = true

