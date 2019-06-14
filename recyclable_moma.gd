extends Area2D

var motion = Vector2()
var screensize
var speed = 250


func _ready():
	screensize = get_viewport_rect().size
	pass
	
func _process(delta):
	var left_key = Input.is_action_pressed("ui_left")
	var right_key = Input.is_action_pressed("ui_right")
	
	if right_key:
		motion.x += speed
	elif left_key:
		motion.x = -speed
	elif !left_key and !right_key:
		motion.x = 0
		
	if motion.length() > 0:
		motion = motion.normalized() * speed
		
	position += motion * delta
	
	position.x = clamp(position.x, 0, screensize.x)
	position.y = clamp(position.y, 0, screensize.y)
	pass
