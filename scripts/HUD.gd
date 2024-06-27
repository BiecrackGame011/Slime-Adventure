extends CanvasLayer

@onready var coins_label = $Coins
@onready var panel = $Panel
@onready var sprite = $Sprite2D

var coins = 0
var coins_str = ""
var heards = Heards.heards
var can_take_damage = true

func _ready():
	$Hearts1.frame = 1
	$Hearts2.frame = 1
	$Hearts3.frame = 1
	visible = true
	if not get_tree().get_current_scene().get_name() == "World3":
		coins_label.text = str("  0/10")
	else:
		coins_label.text = str("  0/1")

func _process(_delta):
	if heards >= 3:
		$Hearts1.frame = 1
		$Hearts2.frame = 1
		$Hearts3.frame = 1
	if heards == 2:
		$Hearts1.frame = 3
		$Hearts2.frame = 1
		$Hearts3.frame = 1
	if heards == 1:
		$Hearts1.frame = 3
		$Hearts2.frame = 3
		$Hearts3.frame = 1
	if heards <= 0:
		$Hearts1.frame = 3
		$Hearts2.frame = 3
		$Hearts3.frame = 3
		var player = get_tree().get_root().find_child("player", true, false)
		player._loseLife()

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

func player_heards(enemy_pos):
	if can_take_damage == true:
		can_take_damage = false
		$can_take_damage_timer.start()
		heards -= 1
		Heards.gloval_heards()
		if heards == 2:
			$lose_life_audio.play()
		if heards == 1:
			$lose_life_audio.play()
		var player = get_tree().get_root().find_child("player", true, false)
		var player_pos = Vector2(player.position.x, player.position.y)
		player.velocity.x = ((player_pos.x - enemy_pos.x) / abs(player_pos.x - enemy_pos.x)) * 600
		player.velocity.y = ((player_pos.y - enemy_pos.y) / abs(player_pos.y - enemy_pos.y)) * 200
		player.move_and_slide()
func _on_can_take_damage_timer_timeout():
	can_take_damage = true
