extends Node

var menu_mode: bool = true

const World: PackedScene = preload("res://world.tscn")

@onready
var replay_labels: Node = $CanvasLayer/PlayerDiedLabel
@onready
var restart_timer: Node = $Timer
var current_world: Node

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	new_game()

func new_game() -> void:
	menu_mode = false
	replay_labels.visible = false
	current_world = World.instantiate()
	current_world.connect("game_ended", self._on_world_game_ended)
	add_child(current_world)
	
func _on_timer_timeout() -> void:
	remove_child(current_world)
	new_game()

func _on_world_game_ended():
	menu_mode = true
	replay_labels.visible = true
	restart_timer.start(5)
