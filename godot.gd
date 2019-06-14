extends Area2D

var collected = []

var speed = 700
var direction = 1

func _ready():
	set_process(true)

func _process(delta):
	$catch.position.x += speed * direction * delta
	$catch.position.y =  100
	
	if $catch.position.x >= 450:
		direction = -1     
	elif $catch.position.x <= 10:       
		direction = 1    
		
		
func _input(event):
	if event.is_action_pressed("catch"):
		get_node("/root/global").collected.append("godot")
		queue_free()
		print(get_node("/root/global").collected)
		
		
func get_random_number(MAX, MIN):
	randomize()
	var number = randi()%MAX + MIN
	return number

