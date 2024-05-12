extends State

@export var idle_state: State
@export var hurt_state: State

var projectile_scene = preload("res://Characters/Enemies/wizard_projectile.tscn") 



func state_process(delta): 
	if character.is_hurt:
		Transitioned.emit(self, hurt_state)

func on_enter():
	animated_sprite.play("Attack")
	var projectile = projectile_scene.instantiate()
	## Add it to the root scene of the current scene tree
	get_tree().root.add_child(projectile)
	#call start function and feed it spawn position. Adjusted for player height
	#print("This is the direction: ", character.facing_direction)
	projectile.start(Vector2(character.global_position.x, character.global_position.y - 33) , character.facing_direction)
	$AudioStreamPlayer.play()
	$CooldownTimer.start()

#func _on_animated_sprite_2d_animation_finished():
	#if animated_sprite.animation == "Attack":
		#$CooldownTimer.start()

func _on_cooldown_timer_timeout():
	Transitioned.emit(self, idle_state)

