extends CharacterBody2D

const ACCELARATION = 10.0
const SPEED = 200.0
const JUMP_VELOCITY = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var animationPlayer = $AnimationPlayer
@onready var animationTree = $AnimationTree
@onready var animationState = animationTree.get("parameters/playback")

func _physics_process(_delta):
	# Add the gravity.
#	if not is_on_floor():
#		velocity.y += gravity * delta
	var input_vector = Vector2.ZERO
	# Handle Jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	input_vector.x = Input.get_axis("ui_left", "ui_right")
	input_vector.y = Input.get_axis("ui_up", "ui_down")
	if input_vector != Vector2.ZERO:
		animationTree.set("parameters/Idle/blend_position", input_vector)
		animationTree.set("parameters/Run/blend_position", input_vector)
		animationState.travel("Run")
		velocity += input_vector.normalized() * ACCELARATION
		velocity = velocity.normalized() * min(SPEED, velocity.length())
	else:
		animationState.travel("Idle")
		velocity = velocity.move_toward(Vector2.ZERO, SPEED)
	move_and_slide()

func _ready():
	animationState.travel("Idle")
#	print("Hello world!")
