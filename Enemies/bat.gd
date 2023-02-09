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
@export
var wander_target_range: float = 4.0
 
var state: BatState = BatState.IDLE

@onready
var stats = $Stats
@onready
var playerDetectionZone: Node = $PlayerDetectionZone
@onready
var sprite: Node = $BatSprite
@onready
var hurtbox: Node = $Hurtbox
@onready
var softCollision: Node = $SoftCollision
@onready
var wander_controller: Node = $WanderController

func _ready() -> void:
	state = pick_random_state([BatState.IDLE, BatState.WANDER])

func _physics_process(delta) -> void:
	match state:
		BatState.IDLE:
			seek_player()
			velocity = velocity.move_toward(Vector2.ZERO, friction * delta)
			if wander_controller.get_time_left() == 0:
				update_wander()
		BatState.WANDER:
			seek_player()
			accelarate_toward_position(wander_controller.target_position, delta)
			if wander_controller.get_time_left() == 0 \
				or global_position.distance_to(wander_controller.target_position) <= wander_target_range:
				update_wander()
		BatState.CHASE:
			var player: Object = playerDetectionZone.player
			if player != null:
				accelarate_toward_position(player.global_position, delta)
			else:
				state = BatState.IDLE
	velocity += softCollision.get_push_vector() * delta * 300
	sprite.flip_h = velocity.x < 0
	move_and_slide()

func accelarate_toward_position(pos: Vector2, delta: float) -> void:
	var direction = global_position.direction_to(pos)
	velocity = velocity.move_toward(direction * max_speed, acceleration * delta)

func update_wander() -> void:
	state = pick_random_state([BatState.IDLE, BatState.WANDER])
	wander_controller.start_wander_timer(randf_range(1, 3))

func seek_player() -> void:
	if playerDetectionZone.can_see_player():
		state = BatState.CHASE

func pick_random_state(state_list: Array) -> BatState:
	state_list.shuffle()
	var new_state = state_list.pop_front()
	return new_state

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
