extends Area2D


func banana_peel_area_entered(area):
	if area.name == "moma_area":
		queue_free()