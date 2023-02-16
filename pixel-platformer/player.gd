extends CharacterBody2D
class_name Player

enum State { MOVE, CLIMB }

@export
var moveData: Resource

@onready
var animatedSprite: Node = $AnimatedSprite2D
@onready
var ladderCheck: Node = $LadderCheck

var state: State = State.MOVE

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity: float = ProjectSettings.get_setting("physics/2d/default_gravity")

func _physics_process(delta) -> void:
	var input: Vector2 = Vector2(Input.get_axis("ui_left", "ui_right"), Input.get_axis("ui_up", "ui_down"))
	match state:
		State.MOVE:
			move_state(delta, input)
		State.CLIMB:
			climb_state(delta, input)

func is_on_ladder() -> bool:
	return ladderCheck.is_colliding() and ladderCheck.get_collider() is Ladder

func move_state(delta: float, input: Vector2) -> void:
	if is_on_ladder() and 0 != input.y:
		state = State.CLIMB
	var was_in_air: bool = false
	if input.length() != 0:
		velocity.x = input.x * moveData.SPEED
		animatedSprite.animation = "Run"
		animatedSprite.flip_h = 0 < velocity.x
	else:
		velocity.x = move_toward(velocity.x, 0, moveData.SPEED)
		animatedSprite.animation = "Idle"
	if is_on_floor():
		if Input.is_action_just_pressed("ui_accept"):
			velocity.y = -moveData.JUMP_VELOCITY
	else:
		was_in_air = true
		velocity.y += gravity * delta
		if Input.is_action_just_released("ui_accept") and velocity.y < -10.0:
			velocity.y *= moveData.AIR_BREAK
	move_and_slide()
	if was_in_air:
		if is_on_floor():
			animatedSprite.animation = "Run"
			animatedSprite.frame = 1
		else:
			animatedSprite.animation = "Jump"

func climb_state(_delta: float, input: Vector2) -> void:
	if not is_on_ladder():
		state = State.MOVE
	velocity = input * moveData.SPEED
	move_and_slide()
	if input.length() != 0:
		animatedSprite.animation = "Run"
	else: 
		animatedSprite.animation = "Idle"
