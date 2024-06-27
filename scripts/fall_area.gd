extends Area2D


@onready var win_menu = get_tree().get_root().find_child("win_menu", true, false)

var t = 0

func _ready():
	t = 0

func _process(_delta):
	if t == 1:
		get_tree().change_scene_to_file("res://scenes/world" + str((get_tree().current_scene.name).to_int() + 1) + ".tscn")

func _on_body_entered(body):
	if body.get_name() == "player":
		if not get_tree().get_current_scene().get_name() == "World3":
			t = 1
		else:
			win_menu.visible = true
