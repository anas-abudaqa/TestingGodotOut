extends State

class_name InAir

@export var ground_state : State
@export var landing_state : State
@export var onwall_state: State

var has_double_jumped : bool = false
# Called when the node enters the scene tree for the first time.
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func state_process(delta):
	check_for_landing()
	check_for_wall()

func state_input(event: InputEvent):
	## 		## if space bar is pressed and if character has not used up double jump yet, boost horizontal and vertical velocity and use up double_jump
		if event.is_action_pressed("Jump"):
			#if character.is_on_wall():
				#character.velocity.y = -200
				#character.velocity.x += 0
				##print("Wallstreet")
			
			if not has_double_jumped:
				character.velocity.y = character.double_jump_velocity_vertical
				character.velocity.x += character.double_jump_velocity_horizontal
				has_double_jumped = true
				animation_playback.travel("double_jump")
			

func check_for_landing():
	##check if the character has touched ground yet
	if character.is_on_floor():
		#reset the double jump
		has_double_jumped = false
		#go to xxxxxxxxx
		Transitioned.emit(self, landing_state)
		animation_playback.travel("Move")
		
func check_for_wall():
	if character.is_on_wall_only():
		Transitioned.emit(self, onwall_state)
