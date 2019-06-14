extends Area2D

var velocity = Vector2()

func _ready():
	set_process(true)
	pass

func _process(delta):
	velocity.y = get_random_number(20, 10)

	translate(velocity * delta)


func get_random_number(MAX, MIN):
	randomize()
	var number = randi()%MAX + MIN
	return number


func _on_recyclable_apple_area_entered(area):
	if area.name == "recyclable_basket":
		queue_free()
