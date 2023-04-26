extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _on_body_entered(area):
	$Anime.animation = "open"
	$Anime.play()


func _on_body_exited(area):
	$Anime.animation = "close"
	$Anime.play()

