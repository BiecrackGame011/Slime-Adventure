extends CharacterBody2D


@export var SPEED = 150
@export var JUMP_VELOCITY = -400
@export var walljump_tries = 1

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var g = gravity
var s = 0
var t = 0
var rot = 0
var lifes = 5

@onready var sprite = $Sprite2D
@onready var Walk_animation = $Walk_AnimationPlayer
@onready var Stomp_animation = $Stomp_AnimationPlayer
@onready var Dead_animation = $Dead_AnimationPlayer

func _ready():
	$Sprite2D.frame = 0
	$CannonFireSmoke_Left.visible = false
	$CannonFireSmoke_Right.visible = false
	$Area2D_PlayerWind/CollisionShape2D_Left.disabled = true
	$Area2D_PlayerWind/CollisionShape2D_Right.disabled = true
	$Area2D_PlayerWind/CollisionShape2D_Stomp.disabled = true
	if get_tree().get_current_scene().get_name() == "World3":
		$Sprite2D.flip_h = false
	t = 0
	
func _physics_process(delta):
	if Stomp_animation.is_playing() or Dead_animation.is_playing():
		velocity.y += gravity * delta
		velocity.x = 0
		move_and_slide()
		return
	else: 
			# Add the gravity.
		if not is_on_floor():
			velocity.y += gravity * delta
		if is_on_floor():
			walljump_tries = 1
			gravity = g
		
		# Handle rotation
		if is_on_wall():
			sprite.rotation_degrees = -90 * Input.get_axis("left", "right")
			rot = -90 * Input.get_axis("left", "right")
		else:
			sprite.rotation_degrees = -rot
			rot = 0
		
		# Handle jump.
		if Input.is_action_pressed("up") and is_on_floor():
			$jump_audio.play()
			velocity.y = JUMP_VELOCITY
		
		# Handle walljump
		if Input.is_action_just_pressed("up") and not is_on_floor() and is_on_wall():
			if walljump_tries != 0:
				walljump_tries = walljump_tries - 1
				velocity.y = JUMP_VELOCITY
		
		# Handle Stomp
		if Input.is_action_just_pressed("down") and not is_on_floor():
			gravity = gravity * 3
			$Area2D_PlayerWind/CollisionShape2D_Stomp.disabled = false
			s = 1
		if is_on_floor() and s == 1:
			$stomp_audio.play()
			Stomp_animation.play("Stomp")
		if is_on_floor():
			$Area2D_PlayerWind/CollisionShape2D_Stomp.disabled = true
			s = 0
		
		# Get the input direction and handle the movement/deceleration.
		var direction = Input.get_axis("left", "right")
		if direction:
			Walk_animation.play("Walk")
			velocity.x = direction * SPEED
			if direction == 1:
				sprite.flip_h = true
			else:
				sprite.flip_h = false
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)
		if Stomp_animation.is_playing() or Dead_animation.is_playing():
			Walk_animation.pause()
		
		move_and_slide()
	
func add_coin():
	var canvasLayer = get_tree().get_root().find_child("CanvasLayer", true, false)
	canvasLayer.CoinCollected()
	var HUD = get_tree().get_root().find_child("HUD", true, false)
	HUD.CoinCollected()

func _on_area_2d_player_wind_body_entered(body):
	if body.get_name() == "boss":
		body._enemyLoseLife()
		lifes -= 1
		if lifes == 0:
			add_coin()
	for i in range(11):
		if body.get_name() == "Enemy" + str(i):
			body._enemyLoseLife()
			add_coin()

func _loseLife():
	if t == 0:
		$dead_audio.play()
	t = 1
	Dead_animation.play("Dead")
func _on_dead_animation_player_animation_finished(_anim_name):
	get_tree().change_scene_to_file("res://scenes/menu.tscn")
	Heards.reset_gloval_heards()
