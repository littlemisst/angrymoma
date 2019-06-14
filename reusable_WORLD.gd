extends Node

onready var collected = []

onready var music = get_node("/root/global").music


func spawn_chicken():
	$chicken.position = Vector2(get_random_number(400, 100), get_random_number(-800, -1200))
	
	
func _ready():
	spawn_chicken()
	non_reusable_items()
	reusable_items()
	add_life()
	music.stop()
	sound_play()
	
func non_reusable_items():
	var non_reusable_old_y_position = get_random_number(1000, 800)
	var non_reusable_item_height = get_random_number(1200, 1000)
	
	var non_resuable_items = []
	
	var plastic_straw = preload("res://Reusable/reusable_plastic_straw.tscn")
	var banana_peel = preload("res://Reusable/reusable_banana_peel.tscn")
	var battery = preload("res://Reusable/reusable_battery.tscn")
	var leaf = preload("res://Reusable/reusable_leaf.tscn")
	var poison = preload("res://Reusable/reusable_poison.tscn")
	var syringe = preload("res://Reusable/reusable_syringe.tscn")
	

	
	non_resuable_items.append(plastic_straw)
	non_resuable_items.append(banana_peel)
	non_resuable_items.append(battery)
	non_resuable_items.append(leaf)
	non_resuable_items.append(poison)
	non_resuable_items.append(syringe)



	for i in range(non_resuable_items.size()):
		var items_in_nonreusable = non_resuable_items[i].instance()
		add_child(items_in_nonreusable)
	#
		items_in_nonreusable.position.y = non_reusable_old_y_position - non_reusable_item_height
		items_in_nonreusable.position = Vector2(get_random_number(400, 50), items_in_nonreusable.position.y)
				
		non_reusable_old_y_position = items_in_nonreusable.position.y

func reusable_items():
	var reusable_item_height = get_random_number(800, 500)
	var reusable_old_y_position = get_random_number(500,300)
	
	var reusable_items = []
	
	var plastic_bottle = preload("res://Reusable/reusable_bottle.tscn")
	var basket = preload("res://Reusable/reusable_bag.tscn")
	var box = preload("res://Reusable/reusable_box.tscn")
	var cd = preload("res://Reusable/reusable_cd.tscn")
	var jar = preload("res://Reusable/reusable_jar.tscn")
	var books = preload("res://Reusable/reusable_books.tscn")
	var paint = preload("res://Reusable/reusable_paint.tscn")
	var plastic = preload("res://Reusable/reusable_plastic.tscn")
	var seedling = preload("res://Reusable/reusable_seed.tscn")
	var paper = preload("res://Reusable/reusable_paper.tscn")
	
	reusable_items.append(plastic_bottle)
	reusable_items.append(basket)
	reusable_items.append(box)
	reusable_items.append(cd)
	reusable_items.append(jar)
	reusable_items.append(books)
	reusable_items.append(paint)
	reusable_items.append(plastic)
	reusable_items.append(seedling)
	reusable_items.append(paper)
	
	for i in range(2):
		for j in range(reusable_items.size()):
			var random_index = get_random_index(reusable_items.size()-1, 1)
			var items_in_reusable = reusable_items[random_index].instance()
			add_child(items_in_reusable)
			
			items_in_reusable.position.y = reusable_old_y_position - reusable_item_height
			items_in_reusable.position = Vector2(get_random_number(400, 50), items_in_reusable.position.y)
			
			reusable_old_y_position = items_in_reusable.position.y

func add_life():
	var old_y_position = get_random_number(1200, 500)
	var life_height = get_random_number(1500, 1200)
	
	var lives = []
	
	var life_1 = preload("res://Reusable/reusable_add_life_1.tscn")
	var life_2 = preload("res://Reusable/reusable_add_life_2.tscn")
	var life_3 = preload("res://Reusable/reusable_add_life_3.tscn")
	
	lives.append(life_1)
	lives.append(life_2)
	lives.append(life_3)
	
	for life in lives:
		var add_life = life.instance()
		add_child(add_life)
		
		add_life.position.y = old_y_position - life_height
		add_life.position = Vector2(get_random_number(400, 50), add_life.position.y)
#
		old_y_position = add_life.position.y


func get_random_number(MAX, MIN):
	randomize()
	var number = randi()%MAX + MIN
	return number
	
func get_random_index(length, MIN):
	randomize()
	var index = randi()%length + MIN
	return index


func chicken_area_entered(area):
	if area.name == "moma_area":
		$moma_body/collectibles.play()
		get_node("/root/global").collected.append("chicken")
		$chicken.queue_free()
		print(get_node("/root/global").collected)
		
func sound_play():
	var music = AudioStreamPlayer.new()
	var stream = load("res://music/reuseBGM.ogg")
	
	music.set_stream(stream)
	music.volume_db = 1
	music.pitch_scale = 1
	music.play()
	add_child(music)
