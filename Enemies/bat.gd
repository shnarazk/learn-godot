extends CharacterBody2D

func _physics_process(_delta) -> void:
	velocity *= 0.96
	move_and_slide()

func _on_hurtbox_area_entered(area):
	var direction = area.get("knockback_vector")
	if direction != null:
		velocity = direction.normalized() * 120
