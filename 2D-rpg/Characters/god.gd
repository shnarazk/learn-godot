extends CharacterBody2D

signal yuhina_in(first)

@export
var yuhina: Node = null

var first = true

func _on_area_2d_body_entered(body):
#	print(body, yuhina, body == yuhina)
	if body == yuhina:
		yuhina_in.emit(first)
		first = false
