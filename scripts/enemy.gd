extends CharacterBody2D


var speed = 25
var direction = -1
var n = 0


func _ready():
	$Sprite2D.visible = true
	$MapDetector.disabled = false
	$Area2D/Player_Detector.disabled = false
	$Dead_FX.visible = false
	velocity.x = direction * speed
	scale.y = 1
	rotation_degrees = 0
	n = 0

func _physics_process(_delta):
	if n == 0:
		$Enemy_Walk_AnimationPlayer.play("Enemi_Wallk")
		if not $RayCast_Floor.is_colliding() or  $RayCast_Wall.is_colliding():
			direction = -direction
		if direction == 1:
			scale.y = -1
			rotation_degrees = 180
		if direction == -1:
			scale.y = 1
			rotation_degrees = 0
		velocity.x = direction * speed
		
		move_and_slide()

func _on_area_2d_body_entered(body):
	if body.get_name() == "player":
		var pos = Vector2(position.x, position.y)
		var HUD = get_tree().get_root().find_child("HUD", true, false)
		HUD.player_heards(pos)
		print(position.x)
		print(position.y)

func _enemyLoseLife():
	$damage_audio.play()
	$Enemy_Dead_FX_AnimationPlayer.play("Enemy_Dead_FX")
	$Sprite2D.visible = false
	$MapDetector.set_deferred("disabled", true)
	$Area2D/Player_Detector.set_deferred("disabled", true)
	$Dead_FX.visible = true

func _on_enemy_dead_fx_animation_player_animation_finished(_anim_name):
	queue_free()
