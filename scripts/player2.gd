extends CharacterBody2D

const moveSpeed = 25
const maxSpeed = 50
const jumpHight = -300
const up = Vector2(0,-1)
const gravity = 15

var motion = Vector2()

@onready var sprite = $Sprite2D
@onready var animation = $AnimationPlayer

func _physics_process(_delta):
	
	motion.y += gravity
	var friction = false
	
	if Input.is_action_pressed("right"):
		sprite.flip_h = true 
		animation.play("Walk")
		motion.x = min(motion.x + moveSpeed, maxSpeed)
	elif Input.is_action_pressed("left"):
		sprite.flip_h = false
		animation.play("Walk")
		motion.x = max(motion.x - moveSpeed, maxSpeed)
	else:
		animation.play("Idle")
		friction = true
	
	if is_on_floor():
		if Input.is_action_pressed("up"):
			motion.y = jumpHight
		if friction == true:
			motion.x = lerp(motion.x, 0.0, 0.5)
	else:
		if friction == true:
			motion.x = lerp(motion.x, 0.0, 0.01)
	
	motion = move_and_slide()
