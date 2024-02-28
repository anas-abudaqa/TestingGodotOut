extends State

class_name OnWallState


@export var inair_state: State
@export var landing_state: State

const WALL_JUMP_VELOCITY = -200
const WALL_JUMP_KNOCKBACK = 150
const WALL_SLIDE_GRAVITY = 100

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func on_enter():
	inair_state.has_double_jumped = false

func state_process(delta):
	if character.is_on_wall_only:
		wall_slide(delta)
	check_for_air()
	check_for_landing()
	
# Called every frame. 'delta' is the elapsed time since the previous frame.

func state_input(event: InputEvent):
	if event.is_action_pressed("Jump"):
		character.velocity.y = WALL_JUMP_VELOCITY
		#Add some knockback from the wall to the jump
	#if event.is_action_pressed("Left"):
		#character.velocity.x = WALL_JUMP_KNOCKBACK ##knock back to the right
		#print("Pressing LEft")
	#if event.is_action_pressed("Right"):
		#character.velocity.x = -WALL_JUMP_KNOCKBACK ##knock back to the left
		#print("Pressing Right")
	
	
func wall_slide(delta):
	if Input.is_action_pressed("Left") or Input.is_action_pressed("Right"):
		character.velocity.y += WALL_SLIDE_GRAVITY*delta
		character.velocity.y = min(character.velocity.y, WALL_SLIDE_GRAVITY)

func check_for_landing():
	if character.is_on_floor():
		Transitioned.emit(self, landing_state)
		
func check_for_air():
	if not character.is_on_wall():
		if not character.is_on_floor():
			Transitioned.emit(self, inair_state)
		
