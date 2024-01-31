extends State

class_name Landing

@export var ground_state : State
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func state_process(delta):
	animation_playback.travel("landing")
	Transitioned.emit(self, ground_state)

func on_enter():
	pass
