extends State

@export var move_state: State
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func on_enter():
	animated_sprite.play("Idle")
	
		
func state_process(delta):
	if character.aggrod and $RestTimer.is_stopped():
		$RestTimer.start()

func _on_rest_timer_timeout():
	Transitioned.emit(self, move_state)
