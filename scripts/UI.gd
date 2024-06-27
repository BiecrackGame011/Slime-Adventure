extends CanvasLayer

@onready var coins_label = $Coins
@onready var panel = $Panel
@onready var sprite = $Sprite2D
@onready var area2D = $Coins_Area2D/CollisionShape2D

var coins = 0
var coins_str = ""

func _ready():
	if not get_tree().get_current_scene().get_name() == "World3":
		coins_label.text = str("  0/10")
	else:
		coins_label.text = str("  0/1")
	area2D.set_deferred("disabled", false)
	coins_label.visible = true
	panel.visible = true
	sprite.visible = true

func CoinCollected():
	coins += 1
	coins_str = str(coins)
	if not get_tree().get_current_scene().get_name() == "World3":
		if coins < 10:
			coins_label.text = str("  " + coins_str + "/10")
		else:
			coins_label.text = str(coins_str + "/10")
	else:
		$Coins.text = coins_str + "/1"
	if coins == 10 or get_tree().get_current_scene().get_name() == "World3" and coins == 1:
		area2D.set_deferred("disabled", true)
		$Coins.visible = false
		panel.visible = false
		sprite.visible = false
