extends State

@export var idle_state: State
@export var hurt_state: State
@export var SwordHitBox: CollisionShape2D

func state_process(delta): 
	if character.is_hurt:
		Transitioned.emit(self, hurt_state)

func on_enter():
	animated_sprite.play("Attack")
	$AudioStreamPlayer.play()
	$WindupTimer.start()
	#SwordHitBox.set_deferred("disabled", false)

func _on_windup_timer_timeout():
	#Delay enabling the sword collision monitoring until the sword is going down at least
	#Enable the sword hitbox
	SwordHitBox.set_deferred("disabled", false)

func _on_animated_sprite_2d_animation_finished():
	if animated_sprite.animation == "Attack":
		#SwordHitBox.set_deferred("disabled", true)
		$CooldownTimer.start()

func _on_cooldown_timer_timeout():
	Transitioned.emit(self, idle_state)
	SwordHitBox.set_deferred("disabled", true)

func on_exit():
	SwordHitBox.set_deferred("disabled", true)


#func _on_melee_area_body_entered(body):
	#if body.is_in_group("Player"):
		#Transitioned.emit(self, self)
