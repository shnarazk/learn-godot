extends CharacterBody2D

@export
var SPEED        : float =  40.0
@export
var JUMP_VELOCITY: float = 400.0
@export
var AIR_BREAK    : float =   0.25

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity: float = ProjectSettings.get_setting("physics/2d/default_gravity")

func _physics_process(delta) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
	# Handle Jump.
	if is_on_floor():
		if Input.is_action_just_pressed("ui_accept"):
			velocity.y = -JUMP_VELOCITY
	else:
		if Input.is_action_just_released("ui_accept") and velocity.y < -10.0:
			velocity.y *= AIR_BREAK

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction: float = Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	move_and_slide()
