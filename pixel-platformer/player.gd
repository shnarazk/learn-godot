extends CharacterBody2D
class_name Player

enum State { MOVE, CLIMB }

@export
var moveData: Resource

@onready
var animatedSprite: Node = $AnimatedSprite2D
@onready
var girlSprite: Node = $girlSprite
@onready
var ladderCheck: Node = $LadderCheck
@onready
var jump_buffer_timer: Node = $JumpBufferTimer
@onready
var coyote_jump_timer: Node = $CoyoteJumpTimer

var state: State = State.MOVE
var double_jump: int
var buffered_jump: bool = false
var coyote_jump: bool = false

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity: float = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready() -> void:
	# moveData = load("res://default_player_movement_data.tres")
	double_jump = moveData.DOUBLE_JUMP

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
	var was_in_air: bool = not is_on_floor()
	var was_on_floor: bool = is_on_floor()
	if input.length() != 0:
		velocity.x = input.x * moveData.SPEED
		animatedSprite.animation = "Run"
		animatedSprite.flip_h = 0 < velocity.x
	else:
		velocity.x = move_toward(velocity.x, 0, moveData.SPEED)
		animatedSprite.animation = "Idle"
	if is_on_floor():
		double_jump = moveData.DOUBLE_JUMP
	if is_on_floor() or coyote_jump:
		if Input.is_action_just_pressed("ui_up") or buffered_jump:
			velocity.y = -moveData.JUMP_VELOCITY
			buffered_jump = false
	else:
		velocity.y += gravity * delta
		if Input.is_action_just_released("ui_up") and velocity.y < -10.0:
			velocity.y *= moveData.AIR_BREAK
		if Input.is_action_just_pressed("ui_up"):
			if 0 < double_jump:
				velocity.y = -moveData.JUMP_VELOCITY
				double_jump -= 1
			else:
				buffered_jump = true
				jump_buffer_timer.start()

	move_and_slide()
	var just_left_ground: bool = not is_on_floor() and was_on_floor
	if just_left_ground and 0 <= velocity.y:
		coyote_jump = true
		coyote_jump_timer.start()
	if was_in_air:
		if is_on_floor():
			animatedSprite.animation = "Run"
			animatedSprite.frame = 1
		else:
			animatedSprite.animation = "Jump"
	if 0 < input.length():
		if 0 < velocity.x:
			girlSprite.play( "right")
		elif velocity.x < 0:
			girlSprite.play("left")
		elif 0 < velocity.y:
			girlSprite.play("down")
		elif velocity.y < 0:
			girlSprite.play("up")

func climb_state(_delta: float, input: Vector2) -> void:
	if not is_on_ladder():
		state = State.MOVE
	velocity = input * moveData.SPEED
	move_and_slide()
	if input.length() != 0:
		animatedSprite.animation = "Run"
	else:
		animatedSprite.animation = "Idle"

func _on_jump_buffer_timer_timeout():
	buffered_jump = false

func _on_coyote_jump_timer_timeout():
	coyote_jump = false
