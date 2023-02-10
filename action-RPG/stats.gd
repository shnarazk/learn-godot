extends Node

signal no_health
signal health_changed(value)

@export_range(1, 10)
var max_health: int = 1

@onready
var health: int = max_health:
	set(value):
		health = value
		emit_signal("health_changed", health)
		if health <= 0:
			emit_signal("no_health")
