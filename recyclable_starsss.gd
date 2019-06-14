extends Control

export var velocity = Vector2()

func _ready():
	set_process(true)
	pass
	
	
func _process(delta):
	translate(velocity * delta)
	pass
	
	if position.y >= get_viewport_rect().size.y:
		set_position(Vector2(125, 153))
	pass

