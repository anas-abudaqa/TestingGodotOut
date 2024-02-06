extends State

class_name GroundState

@export var air_state: State
@export var attack_state: State
@export var dash_state: State


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func state_process(delta):
	on_ground()

func state_input(event: InputEvent):
	if event.is_action_pressed("Jump"):
		jump()
		animation_playback.travel("jump")
	
	if event.is_action_pressed("Attack"):
		Transitioned.emit(self, attack_state )
	
	if event.is_action_pressed("Dash"):
		Transitioned.emit(self, dash_state )
	
func jump():
	character.velocity.y = character.jump_velocity
	
func on_ground():
	if not character.is_on_floor():
		Transitioned.emit(self, air_state)
	#animation_locked = true
	#has_double_jumped = false
