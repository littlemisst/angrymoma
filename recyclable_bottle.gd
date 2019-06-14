extends "res://Recyclable/recyclable_scripts/recyclable_apple.gd"

func _process(delta):
	velocity.y = get_random_number(120, 20)

	translate(velocity * delta)
