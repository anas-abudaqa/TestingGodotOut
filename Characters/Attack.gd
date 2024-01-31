extends State

class_name AttackState
var animation_is_done = false
@export var ground_state : GroundState

# Called when the node enters the scene tree for the first time.
func _ready():
	$ComboInputTimer.wait_time = 0.6 ##set this time to same time as attack animation

func on_enter():
	attack()

func state_input(event: InputEvent):
	if event.is_action_pressed("Attack"):
		follow_up_attack()

func attack():
	animation_playback.travel("attack1")
	$ComboInputTimer.start()
	
func follow_up_attack():
	animation_playback.travel("attack2")
	$ComboInputTimer.start()

func _on_combo_input_timer_timeout():
	animation_playback.travel("Move")
	Transitioned.emit(self, ground_state)



