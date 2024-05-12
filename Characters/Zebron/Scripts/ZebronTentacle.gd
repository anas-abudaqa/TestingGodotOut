extends Area2D
var tentacle_damage = 25
signal TentacleDespawned

func _ready():
	monitoring = false

func spawn(position: Vector2):
	global_position = position
	$AnimatedSprite2D.play("Prespawn")
	$SpawnTimer.start()
	print("Let's spawn")

func _on_animated_sprite_2d_animation_finished():
	if $AnimatedSprite2D.animation == "Spawn":
		$AnimatedSprite2D.play("Idle")
		$HoldTimer.start()
	
	elif $AnimatedSprite2D.animation == "Despawn":
		TentacleDespawned.emit()
		queue_free()
		


func _on_body_entered(body):
	if body.is_in_group("Player"):
		body.take_damage(tentacle_damage)


func _on_spawn_timer_timeout():
	$AnimatedSprite2D.play("Spawn")
	$AudioStreamPlayer.play()
	monitoring = true
	

func _on_hold_timer_timeout():
	$AnimatedSprite2D.play("Despawn")
