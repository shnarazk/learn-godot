extends CharacterBody2D

var direction: Vector2 = Vector2.RIGHT
@onready
var ledge_checkL: Node = $LedgeCheckL
@onready
var ledge_checkR: Node = $LedgeCheckR
@onready
var sprite: Node = $AnimatedSprite2D

func _physics_process(delta: float) -> void:
	var found_wall: bool = is_on_wall()
	var found_ledge: bool = not ledge_checkL.is_colliding() or not ledge_checkR.is_colliding()
	if found_wall or found_ledge:
		direction *= -1
	sprite.flip_h = 0 < direction.x

	velocity = direction * 25
	move_and_slide()
