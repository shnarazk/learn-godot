extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	var start = Time.get_ticks_msec()
	comp_pi(100_000_000)
	var now = Time.get_ticks_msec()
	print((now - start)/ 1000.0)

func comp_pi(n: int):
	var sum: float = 0
	var den: int = 1
	for _n in range(n/2):
		sum += 1.0 / den
		den += 2
		sum -= 1.0 / den
		den += 2
	print(sum * 4)
