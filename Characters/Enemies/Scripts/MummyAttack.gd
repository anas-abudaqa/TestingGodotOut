extends State

@export var idle_state: State

func on_enter():
	animated_sprite.play("Attack")
	$WindupTimer.start()

func _on_windup_timer_timeout():
	#Delay enabling the sword collision monitoring until the sword is going down at least
	#Enable the sword hitbox
	character.find_child("Sword").monitoring = true

func _on_animated_sprite_2d_animation_finished():
	if animated_sprite.animation == "Attack":
		character.find_child("Sword").monitoring = false
		$CooldownTimer.start()

func _on_cooldown_timer_timeout():
	Transitioned.emit(self, idle_state)


func on_exit():
	character.find_child("Sword").monitoring = false
