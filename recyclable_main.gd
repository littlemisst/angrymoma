extends Node2D

onready var collected = []
onready var music = get_node("/root/global").music

var screensize = get_viewport_rect().size.x
var score = 0
var life = 3

signal game_over
signal trophy_appear

func try_again():
	emit_signal("game_over")
	$recyclable_moma2.queue_free()
	$recyclable_basket.queue_free()
	$recyclable_score_canvaslayer/game_timer.set_paused(true)
	
func trophy_appear():
	emit_signal("trophy_appear")
	$recyclable_moma2.queue_free()
	$recyclable_basket.queue_free()
	$recyclable_score_canvaslayer/game_timer.set_paused(true)
	
	
var recyclable_list = ["recyclable_bottle",
	"recyclable_paper",
	"recyclable_plastic",
	"recyclable_straw",
	"recyclable_bag",
	"recyclable_box",
	"recyclable_cup",
	"recyclable_wine",
	"recyclable_beer",
	]
	
var not_recyclable_list = ["recyclable_battery",
	"recyclable_syringe",
	"recyclable_apple",
	"recyclable_seed",
	"recyclable_leaf",
	"recyclable_patis",
	"recyclable_vase",
	"recylable_mug"]


func _ready():
	$flower.position.x = get_random_number(400, 50)
	spawn_timer()
	nonrecyclable_items()
	music.stop()
	sound_play()
	set_process(true)
	
func _process(delta):
	$recyclable_score_canvaslayer/time/time_to_pass.set_text(str(int($recyclable_score_canvaslayer/game_timer.get_time_left())))

	
func nonrecyclable_items():
	
	var nonrecyclable = []
	
	var recyclable_leaf = preload("res://Recyclable/recyclable_scenes/recyclable_leaf.tscn")
	var recyclable_syringe = preload("res://Recyclable/recyclable_scenes/recyclable_syringe.tscn")
	var recyclable_seed = preload("res://Recyclable/recyclable_scenes/recyclable_seed.tscn")
	var recyclable_apple = preload("res://Recyclable/recyclable_scenes/recyclable_apple.tscn")
	var recyclable_battery = preload("res://Recyclable/recyclable_scenes/recyclable_battery.tscn")
	var recyclable_patis = preload("res://Recyclable/recyclable_scenes/recyclable_patis.tscn")
	var recyclable_vase = preload("res://Recyclable/recyclable_scenes/recyclable_vase.tscn")
	var recyclable_mug = preload("res://Recyclable/recyclable_scenes/recyclable_mug.tscn")
	
	nonrecyclable.append(recyclable_leaf)
	nonrecyclable.append(recyclable_apple)
	nonrecyclable.append(recyclable_battery)
	nonrecyclable.append(recyclable_seed)
	nonrecyclable.append(recyclable_syringe)
	nonrecyclable.append(recyclable_patis)
	nonrecyclable.append(recyclable_vase)
	nonrecyclable.append(recyclable_mug)
	
	for item in nonrecyclable:
		var nonrecyclable_items = item.instance()
		nonrecyclable_items.position.x = get_random_number(400, 50)
		add_child(nonrecyclable_items)
			
func recyclable_items():
	var items = []
	
	var recyclable_bottle = preload("res://Recyclable/recyclable_scenes/recyclable_bottle.tscn")
	var recyclable_plastic = preload("res://Recyclable/recyclable_scenes/recyclable_plastic.tscn")
	var recyclable_straw = preload("res://Recyclable/recyclable_scenes/recyclable_straw.tscn")
	var recyclable_bag = preload("res://Recyclable/recyclable_scenes/recyclable_bag.tscn")
	var recyclable_box = preload("res://Recyclable/recyclable_scenes/recyclable_box.tscn")
	var recyclable_paper = preload("res://Recyclable/recyclable_scenes/recyclable_paper.tscn")
	var recyclable_cup = preload("res://Recyclable/recyclable_scenes/recyclable_cup.tscn")
	var recyclable_wine = preload("res://Recyclable/recyclable_scenes/recyclable_wine.tscn")
	var recyclable_beer = preload("res://Recyclable/recyclable_scenes/recyclable_beer.tscn")
	

	items.append(recyclable_bottle)
	items.append(recyclable_plastic)
	items.append(recyclable_straw)
	items.append(recyclable_paper)
	items.append(recyclable_bag)
	items.append(recyclable_box)
	items.append(recyclable_cup)
	items.append(recyclable_wine)
	items.append(recyclable_beer)
	

	for item in items:
		var items_in_recyclable = item.instance()
		
		items_in_recyclable.position.x = get_random_number(400, 50)
		add_child(items_in_recyclable)
		
func add_score():
	$recyclable_score_canvaslayer/recyclable_score_margincontainer/recyclable_score_HBoxContainer/recyclable_scoreLabel.text = String(score)
		
		
func lost_life():
	if life == 2:
		$recyclable_score_canvaslayer/recyclable_life/recyclable_life_3.play("recyclable_blank")
	elif life == 1:
		$recyclable_score_canvaslayer/recyclable_life/recyclable_life_2.play("recyclable_blank")
	elif life == 0:
		$recyclable_score_canvaslayer/recyclable_life/recyclable_life_1.play("recyclable_blank")

func _on_recyclable_basket_area_entered(area):
	if area.name in recyclable_list:
		$recyclable_moma2/recyclable_moma_sprite.play("happy")
		$recyclable.play()
		score += 1
		add_score()
		
		if score == 15:
			trophy_appear()
			$collectibles.play()
		
	elif area.name in not_recyclable_list:
		$recyclable_moma2/recyclable_moma_sprite.play("angry")
		$nonrecyclable.play()
		life -=1
		lost_life()
		
		if life == 0:
			try_again()


func flower_area_entered(area):
	if area.name == "recyclable_basket":
		$collectibles.play()
		get_node("/root/global").collected.append("flower")
		$flower.queue_free()
		print(get_node("/root/global").collected)


func get_random_number(MAX, MIN):
	randomize()
	var number = randi()%MAX + MIN
	return number

func get_random_index(length, MIN):
	randomize()
	var index = randi()%length + MIN
	return index



func spawn_timer():
	recyclable_items()


func game_timer_timeout():
	try_again()


func sound_play():
	var music = AudioStreamPlayer.new()
	var stream = load("res://music/recycleBGM.ogg")
	
	music.set_stream(stream)
	music.volume_db = 1
	music.pitch_scale = 1
	music.play()
	add_child(music)
