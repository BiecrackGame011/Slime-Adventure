extends Control


func _ready():
	visible = false

func _input(event):
	if event.is_action_pressed("esc"):
		get_tree().paused = not get_tree().paused
		if get_tree().paused == true:
			visible = true
		else:
			visible = false
