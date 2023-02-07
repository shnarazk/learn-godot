extends CharacterBody2D

const EnemyDeaathEffect = preload("res://Effects/enemy_death_effect.tscn")

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
	var enemyDeathEffect = EnemyDeaathEffect.instantiate()
	get_parent().add_child(enemyDeathEffect)
	enemyDeathEffect.global_position = global_position
