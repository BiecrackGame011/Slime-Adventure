extends Area2D


func _process(_delta):
	$Spin_AnimationPlayer.play("Coin")

func _on_Coin2D_body_entered(body):
	if body.get_name() == "player":
		$CollisionShape2D.set_deferred("disabled", true)
		visible = false
		body.add_coin()
		$AudioStreamPlayer2D.play()
		await $AudioStreamPlayer2D.finished
		queue_free()
