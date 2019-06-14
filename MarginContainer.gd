extends MarginContainer

onready var score_label = $HBoxContainer/score_label
onready var current_score = 0

func _ready():
	_on_moma_update_score(current_score)
	pass


func _on_moma_update_score(amount_to_add):
	current_score += amount_to_add
	score_label.text = String(current_score)
	pass # replace with function body
