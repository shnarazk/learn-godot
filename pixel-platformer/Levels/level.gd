extends Node2D

const PlayerScene: PackedScene = preload("res://Player/player.tscn")

@onready
var camera: Node = $Camera2D
@onready
var player: Node = $Player
@onready
var timer: Node = $Timer
var player_spawn_position: Vector2 = Vector2.ZERO

# Called when the node enters the scene tree for the first time.
func _ready():
	RenderingServer.set_default_clear_color(Color.LIGHT_SKY_BLUE)
	player.connect_camera(camera)
	Events.connect("player_died", self._on_player_died)
	Events.connect("hit_checkpoint", self._on_hit_checkpoint)
	player_spawn_position = player.global_position
#	print(player_spawn_position)

func _on_player_died() -> void:
	timer.start(1.0)
	await timer.timeout
	var new_player = PlayerScene.instantiate()
	add_child(new_player)
	# call_deferred("add_child", new_player)
	new_player.connect_camera(camera)
	new_player.global_position = player_spawn_position
#	print("moved to", player_spawn_position)
#	print("player.position", new_player.position)

func _on_hit_checkpoint(pos) -> void:
	player_spawn_position = pos
#	print("update position", player_spawn_position)
