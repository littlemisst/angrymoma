extends ParallaxBackground

var background = 0
func _ready():
	set_process(true)
	
func _process(delta):
	background -= 100 * delta
	set_scroll_offset(Vector2(0, -background))
