extends CanvasLayer

func _ready():
	pass


func slide_up():
	$AnimationPlayer.play("reusable_gameover")
	
func slide_out():
	$AnimationPlayer.play_backwards("reusable_gameover")


func _on_continue_pressed():
	pass # replace with function body


func _on_quit_pressed():
	pass # replace with function body


func _on_moma_body_congrats_window():
	slide_up()
	pass # replace with function body
