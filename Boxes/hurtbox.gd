extends Area2D

signal invincibility_started
signal invincibility_ended

const HitEffect = preload("res://Effects/hit_effect.tscn")

var invincible: bool = false:
	set(value):
		invincible = value
		if invincible:
			emit_signal("invincibility_started")
		else:
			emit_signal("invincibility_ended")

@onready
var timer: Object = $Timer

func start_invincibility(duration: float) -> void:
	self.invincible = true
	timer.start(duration)

func create_hit_effect() -> void:
	var effect = HitEffect.instantiate()
	get_tree().current_scene.add_child(effect)
	effect.global_position = global_position

func _on_timer_timeout() -> void:
	self.invincible = false

func _on_invincibility_started() -> void:
	set_deferred("monitoring", false)

func _on_invincibility_ended() -> void:
	monitoring = true
