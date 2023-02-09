extends Node2D

@export
var wander_range: int = 32

@onready
var start_position: Vector2 = global_position

@onready
var target_position: Vector2 = global_position

@onready
var timer: Timer = $Timer

func _ready() -> void:
	update_target_position()

func update_target_position() -> void:
	var target_vector = Vector2(randf_range(-wander_range, wander_range), randf_range(-wander_range, wander_range))
	target_position = start_position + target_vector

func get_time_left() -> float:
	return timer.time_left

func start_wander_timer(duration: float) -> void:
	update_target_position()
	timer.start(duration)

func _on_timer_timeout():
	update_target_position()
