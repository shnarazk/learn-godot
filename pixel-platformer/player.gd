extends CharacterBody2D

@export
var SPEED         : float = 40.0
@export
var JUMP_VELOCITY : float = 400.0
@export
var AIR_BREAK     : float = 0.25
@onready
var animatedSprite: Node  = $AnimatedSprite2D

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity: float = ProjectSettings.get_setting("physics/2d/default_gravity")

func _physics_process(delta) -> void:
	var direction: float = Input.get_axis("ui_left", "ui_right")
	var was_in_air: bool = false
	if direction != 0:
		velocity.x = direction * SPEED
		animatedSprite.animation = "Run"
		animatedSprite.flip_h = 0 < velocity.x
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		animatedSprite.animation = "Idle"
	if is_on_floor():
		if Input.is_action_just_pressed("ui_accept"):
			velocity.y = -JUMP_VELOCITY
	else:
		was_in_air = true
		velocity.y += gravity * delta
		if Input.is_action_just_released("ui_accept") and velocity.y < -10.0:
			velocity.y *= AIR_BREAK
	move_and_slide()
	if was_in_air: 
		if is_on_floor():
			animatedSprite.animation = "Run"
			animatedSprite.frame = 1
		else: 
			animatedSprite.animation = "Jump"
