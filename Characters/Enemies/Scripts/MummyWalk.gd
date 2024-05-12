extends State
@export var attack_state: State
@export var hurt_state: State
@export var idle_state: State
@export var melee_area: Area2D
var initial_position: float

func on_enter():
	initial_position = character.global_position.x
	#character.find_child("Sword").monitoring = false
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func state_process(delta):
	if character.is_aggrod:
		chase_player()
	else:
		Transitioned.emit(self, idle_state)
	if character.is_hurt:
		Transitioned.emit(self, hurt_state)
	if melee_area.has_overlapping_areas():
		Transitioned.emit(self, attack_state)
		
func chase_player():
	animated_sprite.play("Walk")
	#if character.player.global_position.x - character.global_position.x > 20: 
		#character.direction = +1
	###player to the left of snail
	#elif character.player.global_position.x - character.global_position.x < -20:  
		#character.direction = -1
	#else:
		#Transitioned.emit(self, attack_state)


#func _on_melee_area_body_entered(body):
	#if body.is_in_group("Player"):
		#Transitioned.emit(self, attack_state)
