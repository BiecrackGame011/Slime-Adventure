extends CharacterBody2D


var speed = 0
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var spike = 0

func _ready():
	spike = 0

func _physics_process(delta):
	if spike == 0:
		# Add the gravity.
		if not is_on_floor():
			velocity.y += gravity * delta
		
		# Movment
		var direction = Input.get_axis("left", "right")
		
		if is_on_wall():
			speed = 50
			velocity.x = direction * speed
		else:
			speed = 0
			velocity.x = direction * speed
		
		move_and_slide()

func box_spike():
	spike = 1
	speed = 0

