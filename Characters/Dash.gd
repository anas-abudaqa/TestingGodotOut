extends State

class_name DashState

@export var ground_state : State

const DASH_XVELOCITY_BOOST = 1500

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.

func state_input(event: InputEvent):
	pass

func on_enter():
	if $CooldownTimer.is_stopped():
		$DashTimer.start()
		dash()
	else:
		Transitioned.emit(self, previous_state)
	
func dash():
	#var sprite = get_tree().root.find_child("Sprite2D")
	#print(get_tree())
	character.velocity.y = 0
	if character.facing_right:
		character.velocity.x = DASH_XVELOCITY_BOOST
	else:
		character.velocity.x = -DASH_XVELOCITY_BOOST
	#if Input.is_action_pressed("Right"):
		#character.velocity.x = DASH_XVELOCITY_BOOST
	#elif Input.is_action_pressed("Left"):
		#character.velocity.x = -DASH_XVELOCITY_BOOST
	#else: 
		#character.velocity.x = DASH_XVELOCITY_BOOST
	animation_playback.travel("dashing")
	character.become_invulnerable()

func _on_dash_timer_timeout():
	animation_playback.travel("Move")
	$CooldownTimer.start()
	Transitioned.emit(self, previous_state)
	
