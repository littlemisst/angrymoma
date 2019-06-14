extends RigidBody2D


onready var speed = 250
onready var jump_speed = 600

#var motion = Vector2()
#var speed = 300
#const UP = Vector2(0, -1)
#var gravity = 20
#var jump = -900

onready var health = 4

#scoring
onready var score_label = get_parent().get_node("hud/MarginContainer/HBoxContainer/score_label")
onready var score = 0

signal game_over
signal congrats_window

func _ready():
	set_process(true)
	pass

func _process(delta):
	var left_key = Input.is_action_pressed("ui_left")
	var right_key = Input.is_action_pressed("ui_right")

	if right_key:
		set_linear_velocity(Vector2(speed, get_linear_velocity().y))

	elif left_key:
		set_linear_velocity(Vector2(-speed, get_linear_velocity().y))
	pass

func moma_collide(body):
	if body.is_in_group("platform"):
		set_linear_velocity(Vector2(0, -jump_speed))
	pass # replace with function body
	

	


func moma_area_entered(area):
	
	var non_reusable_items_list = [
	"plastic_straw",
	"banana_peel",
	"battery",
	"leaf",
	"poison",
	"syringe"
	]
	
	if area.name in non_reusable_items_list:
		$momasprite.play("angry")
		health -= 1
		MinusLife()

	else:
		$momasprite.play("normal")
		if area.name == "life" or area.name == "life_1" or area.name == "life_2" or area.name == "life_3":
			health += 1
			AddLife()
		else:
			score += 1
			add_score()
			if score == 10:
				you_win()
			
	

	pass # replace with function body
	

	
func AddLife():
	if (health >= 4):
		var heart = get_parent().get_node("hud/life/heart_2")
		heart.play("life")
	elif (health == 3):
		var heart = get_parent().get_node("hud/life/heart_1")
		heart.play("life")
	elif (health == 2):
		var heart = get_parent().get_node("hud/life/heart_0")
		heart.play("life")
	
	
func MinusLife():

	
	if (health == 2):
		var heart = get_parent().get_node("hud/life/heart_2")
		heart.play("empty")
		
	elif (health == 1):
		var heart = get_parent().get_node("hud/life/heart_1")
		heart.play("empty")
		
	elif (health == 0):
		queue_free()
		game_over()
		
		
	pass # replace with function body

func add_score():
	score_label.text = String(score)
	
func game_over():
	emit_signal("game_over")
	

func you_win():
	emit_signal("congrats_window")


func area_restrictions_1_entered(area):
	if area.name == "moma_area":
		game_over()
		
	pass # replace with function body


func area_restrictions_2_entered(area):
	if area.name == "moma_area":
		game_over()
	pass # replace with function body



