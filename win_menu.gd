extends CanvasLayer


func slide_up():
	$AnimationPlayer.play("slide_up")
	$congrats.play()
	
func _input(event):
	if event.is_action_pressed("achievement"):
		get_tree().change_scene("res://Achievements/achievements.tscn")
	elif event.is_action_pressed("quit"):
		get_tree().change_scene("res://new_game.tscn")
	


func you_win():
	slide_up()
