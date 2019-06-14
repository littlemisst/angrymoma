extends HBoxContainer

const sprite_numbers = [
	preload("res://reusable_0.png"),
	preload("res://reusable_1.png"),
	preload("res://reusable_2.png"),
	preload("res://reusable_3.png"),
	preload("res://reusable_4.png"),
	preload("res://reusable_5.png"),
	preload("res://reusable_6.png"),
	preload("res://reusable_7.png"),
	preload("res://reusable_8.png"),
	preload("res://reusable_9.png")
]
func _ready():
	game.connect("score_current_changed", self, "_on_score_current_changed")
	pass

func _on_score_current_changed():
	for child in get_children():
		child.queue_free()
		
	var str_number = str(game.score_current)
	var digits = []
	
	for i in range(str_number.lenght()):
		digits.append(str_number[i].to_int())
		
	for digit in digits:
		var texture_frame = TextureFrame.new()
		texture_frame.set_texture(sprite_numbers[digit])
		add_child(texture_frame)
		
	pass	
	
		