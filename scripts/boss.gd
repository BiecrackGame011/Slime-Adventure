extends CharacterBody2D


var speed = 25
var direction = -1
var n = 0
var lifes = 5

@onready var Healthbar1 = get_tree().get_root().find_child("Healthbar1", true, false)
@onready var Healthbar2 = get_tree().get_root().find_child("Healthbar2", true, false)
@onready var Healthbar3 = get_tree().get_root().find_child("Healthbar3", true, false)
@onready var Healthbar4 = get_tree().get_root().find_child("Healthbar4", true, false)
@onready var Healthbar5 = get_tree().get_root().find_child("Healthbar5", true, false)
@onready var Healthbar_frame = get_tree().get_root().find_child("Healthbar_frame", true, false)
@onready var boss_label = get_tree().get_root().find_child("boss_label", true, false)

func _ready():
	$Sprite2D.visible = true
	$MapDetector.disabled = false
	$Area2D/Player_Detector.disabled = false
	$Dead_FX.visible = false
	Healthbar1.visible = true
	Healthbar2.visible = true
	Healthbar3.visible = true
	Healthbar4.visible = true
	Healthbar5.visible = true
	velocity.x = direction * speed
	scale.y = 0.5
	rotation_degrees = 0
	n = 0

func _physics_process(_delta):
	if n == 0:
		$Enemy_Walk_AnimationPlayer.play("Enemi_Wallk")
		if $RayCast_Wall.is_colliding():
			direction = -direction
		if direction == 1:
			scale.y = -0.5
			rotation_degrees = 180
		if direction == -1:
			scale.y = 0.5
			rotation_degrees = 0
		velocity.x = direction * speed
		
		move_and_slide()

func _on_area_2d_body_entered(body):
	if body.get_name() == "player":
		var pos = Vector2(position.x, position.y)
		var HUD = get_tree().get_root().find_child("HUD", true, false)
		HUD.player_heards(pos)

func _enemyLoseLife():
	lifes -= 1
	if lifes == 4:
		$damage_audio.play()
		Healthbar5.visible = false
	if lifes == 3:
		$damage_audio.play()
		Healthbar4.visible = false
	if lifes == 2:
		$damage_audio.play()
		Healthbar3.visible = false
	if lifes == 1:
		$damage_audio.play()
		Healthbar2.visible = false
	if lifes <= 0:
		Healthbar1.visible = false
		Healthbar_frame.visible = false
		boss_label.visible = false
		$dead_audio.play()
		$Enemy_Dead_FX_AnimationPlayer.play("Enemy_Dead_FX")
		$Sprite2D.visible = false
		$MapDetector.set_deferred("disabled", true)
		$Area2D/Player_Detector.set_deferred("disabled", true)
		$Dead_FX.visible = true

func _on_enemy_dead_fx_animation_player_animation_finished(_anim_name):
	queue_free()
