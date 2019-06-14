extends Node2D

func items():
	var items = []

	var recyclable_bottle = preload("res://recyclable_scenes/recyclable_bottle.tscn")
	var recyclable_mug = preload("res://recyclable_scenes/recylable_mug.tscn")
	var recyclable_plastic = preload("res://recyclable_scenes/recyclable_plastic.tscn")
	var recyclable_straw = preload("res://recyclable_scenes/recyclable_straw.tscn")
	var recyclable_battery = preload("res://recyclable_scenes/recyclable_battery.tscn")
	var recyclable_leaf = preload("res://recyclable_scenes/recyclable_leaf.tscn")
	
	items.append(recyclable_bottle)
	items.append(recyclable_mug)
	items.append(recyclable_plastic)
	items.append(recyclable_straw)
	items.append(recyclable_battery)
	items.append(recyclable_leaf)
	
	var velocity = Vector2()
	
	for item in items:
		
		var falling_items = item.instance()
		add_child(falling_items)
		position.x = get_random_number(100, 50)
		
		velocity.y = get_random_number(600, 200)
	
		if position.y >= get_viewport_rect().size.y:
			queue_free()
			
	

var screensize = get_viewport_rect().size.x

func _ready():
	items()
	pass
	
func get_random_number(MAX, MIN):
	randomize()
	var number = randi()%MAX + MIN
	return number