extends State

class_name AttackState
@export var ground_state : GroundState
var first_attack_done = false

# Called when the node enters the scene tree for the first time.
func _ready():
	$ComboInputTimer.wait_time = 0.6 ##set this time to same time as attack animationd

func on_enter():
	attack()

func state_input(event: InputEvent):
	if event.is_action_pressed("Attack"):
		follow_up_attack()

func attack():
	first_attack_done = false
	animation_playback.travel("attack1")
	$AudioStreamPlayer.play()
	$ComboInputTimer.start()
	
func follow_up_attack():
	animation_playback.travel("attack2")
	$AudioStreamPlayer.play()
	$ComboInputTimer.start()

func _on_combo_input_timer_timeout():
	animation_playback.travel("Move")
	Transitioned.emit(self, ground_state)

func _on_animation_tree_animation_finished(anim_name):
	if anim_name == "attack1":
		first_attack_done = true
