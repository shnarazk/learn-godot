extends Node2D

@onready var GrassEffect = load("res://Effects/grass_effect.tscn")

func _process(_delta):
	if Input.is_action_just_pressed("attack"):
		var grassEffect = GrassEffect.instantiate()
		var world = get_tree().current_scene
		world.add_child(grassEffect)
		grassEffect.global_position = global_position
		queue_free()
