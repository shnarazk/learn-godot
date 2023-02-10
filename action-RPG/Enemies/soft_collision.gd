extends Area2D

func is_colliding() -> bool:
	var areas = get_overlapping_areas()
	return 0 < areas.size()
	
func get_push_vector() -> Vector2:
	var areas = get_overlapping_areas()
	var push_vector = Vector2.ZERO
	if 0 < areas.size():
		var area = areas[0]
		push_vector = area.global_position.direction_to(-1 * global_position)
		push_vector = push_vector.normalized()
	return push_vector
