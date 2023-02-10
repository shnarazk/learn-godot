extends Label

@export
var stats: Node
@export
var max_treasure: int = 12
var count: int = 0

func set_value(value: int) -> void:
	count = value
	text = "treasure: " + str(count)
	if count == max_treasure:
		text = "ALL treasures found!"
	
func increment() -> void:
	set_value(count + 1)
	
func _ready():
	set_value(0)
	stats.connect("got_treasure", self.increment)

func _on_grass_unearth_treasure():
	increment()
