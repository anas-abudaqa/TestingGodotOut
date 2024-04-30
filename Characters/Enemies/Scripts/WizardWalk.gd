extends State
@export var attack_state: State
@export var hurt_state: State
@export var idle_state: State
var initial_position: float

func on_enter():
	initial_position = character.global_position.x
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func state_process(delta):
	if character.is_aggrod:
		chase_player()
	else:
		Transitioned.emit(self, idle_state)
	if character.is_hurt:
		Transitioned.emit(self, hurt_state)

func chase_player():
	animated_sprite.play("Walk")
	if character.player.global_position.x - character.global_position.x > 20: 
		character.direction = +1
	##player to the left of snail
	elif character.player.global_position.x - character.global_position.x < -20:  
		character.direction = -1
	else:
		Transitioned.emit(self, attack_state)

func patrol():
	character.direction = +1
	if character.player.global_position.x - initial_position > 2: 
		character.direction = +1
	##player to the left of snail
	elif character.player.global_position.x - initial_position < -2:  
		character.direction = -1
