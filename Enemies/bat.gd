extends CharacterBody2D

@onready
var stats = $Stats

func _physics_process(_delta) -> void:
	velocity *= 0.96
	move_and_slide()

func _on_hurtbox_area_entered(area):
	stats.health -= area.damage
	var direction = area.get("knockback_vector")
	if direction != null:
		velocity = direction.normalized() * 120

func _on_stats_no_health():
	queue_free()
