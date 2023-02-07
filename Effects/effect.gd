extends AnimatedSprite2D

#@onready var animatedSprite = $AnimatedSprite2D

func _ready() -> void:
	connect("animation_finished", _on_animation_finished)
	play("Animate")

func _on_animation_finished() -> void:
	queue_free()
