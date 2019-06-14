extends Node2D

onready var width = get_viewport_rect().size.x


func _ready():
	
	
	var platform = preload("res://Reusable/reusable_platform.tscn")
	var old_platform = platform.instance()
	add_child(old_platform)
	
	var old_x_position = old_platform.position.x
	var old_y_position = old_platform.position.y


	for i in range(3000):	
		var new_platform = platform.instance()
	
		add_child(new_platform)
	
		var height = 150
	
		new_platform.position.x = clamp(get_random_number(300,75), 50, width)
		new_platform.position.y = old_y_position - height
			
		old_y_position = new_platform.position.y
	
	

	
	pass
	
	
	

func get_random_number(MAX, MIN):
	randomize()
	var number = randi()%MAX + MIN
	return number
	
	
