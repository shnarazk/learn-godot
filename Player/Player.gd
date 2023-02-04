extends CharacterBody2D

const ACCELARATION = 10.0
const SPEED = 200.0
const JUMP_VELOCITY = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta):
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
		velocity += input_vector.normalized() * ACCELARATION * delta
		velocity = velocity.normalized() * min(SPEED * delta, velocity.length())
	else:
		velocity = velocity.move_toward(Vector2.ZERO, SPEED * delta)
	move_and_collide(velocity)

func _ready():
	print("Hello world!")
