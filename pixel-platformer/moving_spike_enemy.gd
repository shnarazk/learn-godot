@tool
extends Path2D

enum AnimationType {
	LOOP,
	FREEZE
}

@export
var animation_type: AnimationType:
	set(value):
		animation_type = value
		update_type()

@export_range(0.5, 8)
var speed: float = 1:
	set(value):
		speed = value
		var ap = find_child("AnimationPlayer")
		if ap:
			ap.speed_scale = speed

# Called when the node enters the scene tree for the first time.
func _ready():
	update_type()

func update_type():
	var ap = find_child("AnimationPlayer")
	if ap:
		match animation_type:
			AnimationType.LOOP: ap.play("MovingAlongPathLoop")
			AnimationType.FREEZE: ap.stop()

