extends State

@export var teleport_state: State
# Called when the node enters the scene tree for the first time.

func on_enter():
	animated_sprite.play("Uncloaked_Idle")
	
		
func state_process(delta):
	#print("state Idle prcess")
	if $RestTimer.is_stopped():
		$RestTimer.start()

func _on_rest_timer_timeout():
	Transitioned.emit(self, teleport_state)
