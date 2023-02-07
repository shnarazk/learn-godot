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
const JUMP_VELOCITY = -400.0
var roll_vector: Vector2 = Vector2.RIGHT

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var animationPlayer = $AnimationPlayer
@onready var animationTree = $AnimationTree
@onready var animationState = animationTree.get("parameters/playback")

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
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
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
	animationTree.active = true
	animationState.travel("Idle")
#	print("Hello world!")
