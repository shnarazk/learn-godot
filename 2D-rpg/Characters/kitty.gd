extends CharacterBody2D

signal kitty_meets_yuhina

var met: bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	met = false


func _on_area_2d_body_entered(body):
	if body != self and not met:
		met = true
		kitty_meets_yuhina.emit()

