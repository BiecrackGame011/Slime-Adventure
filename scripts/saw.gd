extends Node2D

@onready var animiation = $AnimationPlayer

func _physics_process(_delta):
	animiation.play("Saw_Rotation")

func _on_area_2d_body_entered(body):
	if body.get_name() == "player":
		var pos = Vector2(position.x, position.y)
		var HUD = get_tree().get_root().find_child("HUD", true, false)
		HUD.player_heards(pos)
