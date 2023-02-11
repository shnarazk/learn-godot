extends CharacterBody2D

enum State {
	MOVE,
	ROLL,
	ATTACK
}

var state: State = State.MOVE
const ACCELARATION: float = 10.0
const SPEED: float = 200.0
const ROLL_SPEED: float = 180.0
const PlayerHurtSound: PackedScene = preload("res://Player/player_hurt_sound.tscn")
# const JUMP_VELOCITY = -400.0
var roll_vector: Vector2 = Vector2.UP

# # Get the gravity from the project settings to be synced with RigidBody nodes.
# var gravity: float = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready
var animationPlayer: Object = $AnimationPlayer
@onready
var animationTree: Object = $AnimationTree
@onready
var animationState: Object = animationTree.get("parameters/playback")
@onready
var sworditbox: Object = $HitboxPivot/SwordHitbox
@export
var stats: Node
@onready
var hurtbox: Object = $Hurtbox
@onready
var blinkAnimationPlayer: Node = $BlinkAnimationPlayer

func _physics_process(_delta: float) -> void:
	match state:
		State.MOVE:
			move_state()
		State.ATTACK:
			attack_state()
		State.ROLL:
			roll_state()

func move_state() -> void:
	var input_vector = Vector2.ZERO
	# if Input.is_action_just_pressed("ui_accept") and is_on_floor():
	# 	velocity.y = JUMP_VELOCITY
	input_vector.x = Input.get_axis("ui_left", "ui_right")
	input_vector.y = Input.get_axis("ui_up", "ui_down")
	if input_vector != Vector2.ZERO:
		animationTree.set("parameters/Idle/blend_position", input_vector)
		animationTree.set("parameters/Run/blend_position", input_vector)
		animationTree.set("parameters/Attack/blend_position", input_vector)
		animationTree.set("parameters/Roll/blend_position", input_vector)
		animationState.travel("Run")
		velocity += input_vector.normalized() * ACCELARATION
		velocity = velocity.normalized() * min(SPEED, velocity.length())
		roll_vector = input_vector
		sworditbox.knockback_vector = roll_vector
	else:
		animationState.travel("Idle")
		velocity = velocity.move_toward(Vector2.ZERO, SPEED)
	move()
	if Input.is_action_just_pressed("attack"):
		state = State.ATTACK
	if Input.is_action_just_pressed("roll"):
		state = State.ROLL

func move() -> void:
	move_and_slide()

func attack_state() -> void:
	velocity = Vector2.ZERO
	animationState.travel("Attack")

func roll_state() -> void:
	velocity = roll_vector * ROLL_SPEED
	animationState.travel("Roll")
	move()

func attack_animation_finished() -> void:
	state = State.MOVE

func roll_animation_finished() -> void:
	velocity /= 2
	state = State.MOVE

func _ready() -> void:
	randomize()
	stats.max_health = 4
	animationTree.active = true
	animationState.travel("Idle")
	sworditbox.knockback_vector = roll_vector

func _on_hurtbox_area_entered(area) -> void:
	stats.health -= area.damage
	hurtbox.start_invincibility(0.6)
	hurtbox.create_hit_effect()
	var playerHurtSound = PlayerHurtSound.instantiate()
	get_tree().current_scene.add_child(playerHurtSound)

func _on_player_stats_no_health() -> void:
	queue_free()

func _on_hurtbox_invincibility_started() -> void:
	blinkAnimationPlayer.play("Start")

func _on_hurtbox_invincibility_ended() -> void:
	blinkAnimationPlayer.play("Stop")
