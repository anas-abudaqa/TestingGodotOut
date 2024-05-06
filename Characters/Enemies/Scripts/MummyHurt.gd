extends State

@export var idle_state: State
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func on_enter():
	animated_sprite.play("Hurt")
	#$AudioStreamPlayer.play()
	await animated_sprite.animation_finished
	Transitioned.emit(self, idle_state)

func on_exit():
	character.is_hurt = false
