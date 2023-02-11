extends Control

@export
var stats: Node

@onready
var label = $Label
@onready
var heartEmpty = $HeartEmpty
@onready
var heartFull = $HeartFull

var hearts: int = 4
var max_hearts: int = 4

func set_hearts(value) -> void:
	hearts = min(max_hearts, value)
	# label.text = "HP: " + str(hearts)
	heartFull.size.x = hearts * 15

func _ready():
	max_hearts = stats.max_health
	heartEmpty.size.x = max_hearts * 15
	hearts = max_hearts
#	playerStats.connect("health_changed", self.set_hearts)

func _on_player_stats_health_changed(value) -> void:
	set_hearts(value)

