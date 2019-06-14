extends Area2D

func _ready():
	pass


func life_area_entered(area):
	if area.name == "moma_area":
		queue_free()
	pass # replace with function body
