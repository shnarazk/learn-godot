extends Node

signal no_health

@export_range(1, 10)
var max_health: int = 1

@onready
var health: int = max_health:
	set(value):
		health = value
		if health <= 0:
			emit_signal("no_health")
