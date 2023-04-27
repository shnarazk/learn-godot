extends StaticBody2D

signal coming_to_bed


func _on_area_2d_body_entered(body):
	if self != body:
		coming_to_bed.emit()
