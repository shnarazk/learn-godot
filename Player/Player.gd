extends CharacterBody2D

enum {
	MOVE,
	ROLL,
	ATTACK
}

var state = MOVE
const ACCELARATION = 10.0
const SPEED = 200.0
const JUMP_VELOCITY = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var animationPlayer = $AnimationPlayer
@onready var animationTree = $AnimationTree
@onready var animationState = animationTree.get("parameters/playback")

func _process(_delta):
	match state:
		MOVE:
			move_state()
		ATTACK:
			attack_state()
		ROLL:
			move_state()
	
func move_state():
	var input_vector = Vector2.ZERO
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	input_vector.x = Input.get_axis("ui_left", "ui_right")
	input_vector.y = Input.get_axis("ui_up", "ui_down")
	if input_vector != Vector2.ZERO:
		animationTree.set("parameters/Idle/blend_position", input_vector)
		animationTree.set("parameters/Run/blend_position", input_vector)
		animationTree.set("parameters/Attack/blend_position", input_vector)
		animationState.travel("Run")
		velocity += input_vector.normalized() * ACCELARATION
		velocity = velocity.normalized() * min(SPEED, velocity.length())
	else:
		animationState.travel("Idle")
		velocity = velocity.move_toward(Vector2.ZERO, SPEED)
	move_and_slide()
	if Input.is_action_just_pressed("attack"):
		state = ATTACK
	
func attack_state():
	velocity = Vector2.ZERO
	animationState.travel("Attack")
	
func attack_animation_finished():
	state = MOVE

func _ready():
	animationTree.active = true
	animationState.travel("Idle")
#	print("Hello world!")
