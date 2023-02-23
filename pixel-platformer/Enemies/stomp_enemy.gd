extends Node2D

enum St { HOVER, FALL, LAND, RISE }

var state: St = St.HOVER

@onready
var start_position: Vector2 = global_position
@onready
var timer: Node = $Timer
@onready
var ray_cast: Node = $RayCast2D
@onready
var animated_sprite: Node = $AnimatedSprite2D
@onready
var particles: Node = $GPUParticles2D

func _ready():
	particles.one_shot = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	match state:
		St.HOVER: hover_state()
		St.FALL: fall_state(delta)
		St.LAND: land_state()
		St.RISE: rise_state(delta)

func hover_state() -> void:
	state = St.FALL

func fall_state(delta: float) -> void:
	animated_sprite.play("Falling")
	position.y += 160 * delta
	if ray_cast.is_colliding():
		var collision_point: Vector2 = ray_cast.get_collision_point()
		position.y = collision_point.y
		particles.emitting = true
		timer.start(1.0)
		state = St.LAND

func land_state() -> void:
	if timer.time_left == 0:
		state = St.RISE

func rise_state(delta: float) -> void:
	animated_sprite.play("Rising")
	position.y = move_toward(position.y, start_position.y, 20.0 * delta)
	if position.y == start_position.y:
		state = St.HOVER
