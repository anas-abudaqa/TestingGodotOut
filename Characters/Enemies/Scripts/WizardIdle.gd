extends State

@export var walk_state: State
@export var hurt_state: State

func on_enter():
	animated_sprite.play("Idle")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func state_process(delta):
	if character.is_aggrod:
		Transitioned.emit(self, walk_state)
	if character.is_hurt:
		Transitioned.emit(self, hurt_state)



