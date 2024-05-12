extends State

class_name ChasePlayerState

@export var acidshot_state: State
var shot_direction: int

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func state_process(delta):
	#if $ChaseTimer.is_stopped():
		#character.direction.x = 0
		#$ChaseTimer.start()
	####player is below this character
	##if character.playerbody.position.y - character.position.y > 32:
		##character.direction.y = +1
	####player is above this character
	##if character.playerbody.position.y - character.position.y < -32:
		##character.direction.y = -1
	#face_player()
	#
#
#func _on_chase_timer_timeout():
	### stop all x and y movements and shoot an acid projectile
	#character.direction = Vector2.ZERO
	#Transitioned.emit(self, acidshot_state)
#
#
#
#func face_player():
	###player to the right of this character
	#if character.playerbody.position.x - character.position.x > 20: 
		#animated_sprite.flip_h = false
		#shot_direction = +1
	###player to the left of this character
	#if character.playerbody.position.x - character.position.x < 20: 
		#animated_sprite.flip_h = true
		#shot_direction = -1
