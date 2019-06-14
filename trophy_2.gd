extends CanvasLayer

signal congrats_window

func you_win():
	emit_signal("congrats_window")
	
func slide_down():
	$slide_down.play("slide_down")

func trophy_appear_2():
	slide_down()

func _input(event):
	if event.is_action_pressed("select"):
		get_node("/root/global").collected.append("silver")
		$select.queue_free()
		print(get_node("/root/global").collected)
		you_win()