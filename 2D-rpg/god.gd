extends CharacterBody2D

signal yuhina_in

@export
var yuhina: Node = null

var first = true

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_area_2d_body_entered(body):
	if body == yuhina and first:
		yuhina_in.emit()
		first = false
