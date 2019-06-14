extends CanvasLayer

var collected = []

signal you_win

func you_win():
	emit_signal("you_win")


func slide_down():
	$slide_down.play("slide_down")
	
func _input(event):
	if event.is_action_pressed("select"):
		get_node("/root/global").collected.append("bronze")
		$select.queue_free()
		print(get_node("/root/global").collected)
		you_win()

func trophy_appear():
	slide_down()
