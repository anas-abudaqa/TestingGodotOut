extends State

@export var acidshot_state: State
@export var idle_state: State
# Called when the node enters the scene tree for the first time.
var ceiling_collision_counter: int = 0

func on_enter():
	character.direction.y = -1

func on_exit():
	pass

func state_process(delta):
	if ceiling_collision_counter <= 10:
		return
	else: 
		Transitioned.emit(self, acidshot_state)
	

