extends State

@export var walk_state: State

func on_enter():
	animated_sprite.play("Idle")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func state_process(delta):
	if character.is_aggrod:
		Transitioned.emit(self, walk_state)



