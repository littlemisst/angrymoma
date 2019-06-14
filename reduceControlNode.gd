extends Node2D

onready var collected = []
onready var music = get_node("/root/global").music

export (NodePath) var questionTextPath
export (NodePath) var trueAnswerPath
export (NodePath) var falseAnswerPath
export (NodePath) var animatorPath
export (NodePath) var timerPath
export (NodePath) var questionHolderPath

onready var questionText = get_node(questionTextPath)
onready var trueAnswer = get_node(trueAnswerPath)
onready var falseAnswer = get_node(falseAnswerPath)
onready var animator = get_node(animatorPath)
onready var timer = get_node(timerPath)
onready var questionHolder = get_node(questionHolderPath)

var score = 0
var answer = null
var question = 0

onready var godot = preload("res://Reduce/Scenes/godot.tscn")
onready var spawn = godot.instance()

onready var random_index = get_random_index(9, 1)


signal game_over
signal trophy_appear


func game_over():
	emit_signal("game_over")
	$buttonLayer/trueButton.queue_free()
	$buttonLayer/falseButton.queue_free()

func trophy_appear():
	emit_signal("trophy_appear")
	$buttonLayer/trueButton.queue_free()
	$buttonLayer/falseButton.queue_free()

		
func _ready():
	print(random_index)
	randomize()
	set_question()
	music.stop()
	sound_play()

		
func set_question():
	var childAmount = questionHolder.get_child_count()
	var whichQuestion 
	
	if childAmount > 0: 
		whichQuestion = questionHolder.get_child(randi(0, childAmount)%childAmount)
		questionText.set_text(whichQuestion.reduceQuestion)
		answer = whichQuestion.answer
		question += 1
		
		if question == random_index:
			add_child(spawn)
		
	else:
		questionText.set_text("No more questions, you answered " + str(score) + " out of 10 questions correctly.")
		if question == 10 and score <= 6:
			game_over()
		elif question == 10 and score >= 7:
			trophy_appear()
			$collectibles.play()
			
	if whichQuestion != null:
		questionHolder.remove_child(whichQuestion)



func _input(event):
	if event.is_action_pressed("true"):
		if answer == false:
			trueAnswer.set_text("WRONG")
			$wrong_answer.play()
			
		else:
			trueAnswer.set_text("CORRECT")
			score += 1
			$ScoreEachLayer/currentScore.text = str(score)
			$correct_answer.play()

		animator.play("trueSlide")
		timer.start()
		
	elif event.is_action_pressed("false"):
		if answer == true:
			falseAnswer.set_text("WRONG")
			$wrong_answer.play()
		
		else:
			falseAnswer.set_text("CORRECT")
			score += 1
			$ScoreEachLayer/currentScore.text = str(score)
			$correct_answer.play()
			
		animator.play("falseSlide")
		timer.start()
		


func _on_reduceTimer_timeout():
	animator.play_backwards(animator.get_current_animation())
	set_question()

func get_random_index(length, MIN):
	randomize()
	var index = randi()%length + MIN
	return index

func sound_play():
	var music = AudioStreamPlayer.new()
	var stream = load("res://music/reduceBGM.ogg")
	
	music.set_stream(stream)
	music.volume_db = 1
	music.pitch_scale = 1
	music.play()
	add_child(music)