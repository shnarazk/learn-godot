extends Area2D

@onready
var animatedSprite: Node = $AnimatedSprite2D

var active: bool = true

func _on_body_entered(body) -> void:
	if not body is Player:
		print(body)
		return
	if not active:
		return
	active = false
	animatedSprite.play("Checked")
	Events.emit_signal("hit_checkpoint", position)
