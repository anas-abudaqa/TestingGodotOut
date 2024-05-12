extends State
var player_position: Vector2
var teleport_counter = 0

@export var idle_state: State
@export var shoot_state: State
@export var stop_state: State
# Called when the node enters the scene tree for the first time.

func on_enter():
	animated_sprite.play("Disappear")
	character.find_child("CollisionShape2D").set_deferred("disabled", true)
	$DisappearAudio.play()
	

func invisible_bro():
	animated_sprite.visible = false

func find_player():
	if character.playerbody != null:
		player_position = character.playerbody.global_position
	else:
		Transitioned.emit(self, stop_state)
	
func teleport():
	character.global_position = player_position + Vector2(30, -33)
	animated_sprite.visible = true
	animated_sprite.play("Reappear")
	$ReappearAudio.play()

func _on_invisibility_timer_timeout():
	find_player()
	$ReemergenceTimer.start()

func _on_reemergence_timer_timeout():
	teleport()

func _on_cool_down_timer_timeout():
	#if teleport_counter <= 5:
		#animated_sprite.play("Disappear")
	#else:
		Transitioned.emit(self, shoot_state)


func _on_animated_sprite_2d_animation_finished():
	#print("Animatioin ENDED!!! : ", animated_sprite.animation)
	##If we just finished Disappear animation
	if animated_sprite.animation == "Disappear":
		#print("we disappearing bro")
		invisible_bro()
		$InvisibilityTimer.start()
	##made into elif to avoid bugs	
	elif animated_sprite.animation == "Reappear":
		character.find_child("CollisionShape2D").set_deferred("disabled", false)
		#print("we reappearing nowww")
		$CoolDownTimer.start()


func _on_timer_timeout():
	pass # Replace with function body.
