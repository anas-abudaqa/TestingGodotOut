extends State

class_name DashState

@export var ground_state : State

const DASH_XVELOCITY_BOOST = 1200

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func state_process(delta):
	pass

func state_input(event: InputEvent):
	pass

func on_enter():
	$DashTimer.start()
	dash()
	
func dash():
	#var sprite = get_tree().root.find_child("Sprite2D")
	#print(get_tree())
	
	#if Input.is_action_pressed("Right"):
		#character.velocity.x = DASH_XVELOCITY_BOOST
	#elif Input.is_action_pressed("Left"):
		#character.velocity.x = -DASH_XVELOCITY_BOOST
	#else: 
	#if sprite.flip_h == false:
		#character.velocity.x += DASH_XVELOCITY_BOOST
	#else:
	character.velocity.x = DASH_XVELOCITY_BOOST
	animation_playback.travel("dashing")
func on_exit():
	pass

func _on_dash_timer_timeout():
	animation_playback.travel("Move")
	Transitioned.emit(self, ground_state)
