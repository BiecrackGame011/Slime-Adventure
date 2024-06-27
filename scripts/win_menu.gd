extends Control


func _ready():
	visible = false

func _input(event):
	if visible == true:
		get_tree().paused = true
		if event.is_action_pressed("esc"):
			get_tree().paused = false
			Heards.reset_gloval_heards()
			get_tree().change_scene_to_file("res://scenes/menu.tscn")
