extends Node
var NPC_speed: float = 0
var NPC_Initial_Location: Vector2 = Vector2.ZERO
var NPC_Velocity: Vector2 = Vector2.ZERO
var direction = 1
var moving: bool = false
signal velocity_changed

func set_speed_and_location(speed: float, location: Vector2):
	NPC_speed = speed
	NPC_Initial_Location = location

func wander_around(wandering_radius: float, curr_location: Vector2):
	#var random_number: int = 0
	#if not moving:
		#random_number = randi_range(0, 1)
		#if random_number: 
			#direction = 1
		#else:
			#direction = -1
	#print(random_number)
	#moving = true
	
	NPC_Velocity.x = NPC_speed * direction
	if abs(curr_location.x - NPC_Initial_Location.x) > wandering_radius:
		direction *= -1
	velocity_changed.emit(NPC_Velocity)
	##Change NPC X velocity to speed * 
	
	##Need to input NPC speed X
	##Need to know NPC initial location X
	##pick right or left direction, randomly??
	##delta of X Location of NPC should not exceed radius in whatever direction is chosen
	##Wander either until delta of X direction reaches radius
	##Afterwards, flip direction
	
	 
	
	
	

