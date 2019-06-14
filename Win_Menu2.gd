extends CanvasLayer

func _ready():
	pass


func _input(event):
	if event.is_action_pressed("quit"):
		get_tree().change_scene("res://new_game.tscn")
	elif event.is_action_pressed("continue"):
		get_tree().change_scene("res://Dialogues/reuse_dialogue.tscn")
		
		
func slide_up():
	$AnimationPlayer.play("for_win")
	$congrats_player.play()



func reduce_you_win():
	slide_up()
