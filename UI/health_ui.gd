extends Control

@export
var stats: Node

var hearts: int = 4
var max_hearts: int = 4

func set_hearts(value) -> void:
	hearts = min(max_hearts, value)

func _ready():
	max_hearts = stats.max_health
	hearts = max_hearts
#	playerStats.connect("health_changed", self.set_hearts)

func _on_player_stats_health_changed(value):
	set_hearts(value)
	print(hearts)
