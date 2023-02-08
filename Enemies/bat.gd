extends CharacterBody2D

const EnemyDeaathEffect = preload("res://Effects/enemy_death_effect.tscn")

enum BatState {
	IDLE,
	WANDER,
	CHASE
}

@export
var acceleration: float = 300.0
@export
var max_speed: float = 50.0
@export
var friction: float = 200.0
 
var state: BatState = BatState.IDLE

@onready
var stats = $Stats
@onready
var playerDetectionZone: Object = $PlayerDetectionZone
@onready
var sprite: Object = $BatSprite
@onready
var hurtbox: Object = $Hurtbox

func _physics_process(delta) -> void:
	# velocity *= 0.96

	match state:
		BatState.IDLE:
			velocity = velocity.move_toward(Vector2.ZERO, friction * delta)
			move_and_slide()
			seek_player()
			pass
		BatState.WANDER:
			pass
		BatState.CHASE:
			var player: Object = playerDetectionZone.player
			if player != null:
				var direction: Vector2 = (player.global_position - global_position).normalized()
				velocity = velocity.move_toward(direction * max_speed, acceleration * delta)
				move_and_slide()
			else:
				state = BatState.IDLE
	sprite.flip_h = velocity.x < 0

func seek_player() -> void:
	if playerDetectionZone.can_see_player():
		state = BatState.CHASE

func _on_hurtbox_area_entered(area) -> void:
	var direction = area.get("knockback_vector")
	if direction != null:
		stats.health -= area.damage
		velocity = direction.normalized() * 120
	hurtbox.create_hit_effect()

func _on_stats_no_health() -> void:
	queue_free()
	var enemyDeathEffect = EnemyDeaathEffect.instantiate()
	get_parent().add_child(enemyDeathEffect)
	enemyDeathEffect.global_position = global_position
