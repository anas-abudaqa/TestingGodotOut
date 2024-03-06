extends CharacterBody2D

class_name TheSlimeAI

@export var playerbody: CharacterBody2D
const SPEED = 200.0
const VERTICAL_SPEED = 150.0
var aggrod: bool = false


# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var direction: Vector2i = Vector2.ZERO

func _physics_process(delta):

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	
	##+1 go right, -1 go left
	if direction.x == 1:
		velocity.x = SPEED
	elif direction.x == -1:
		velocity.x = -SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	##+1 go down, -1 go up
	if direction.y == 1:
		velocity.y = VERTICAL_SPEED
	elif direction.y == -1:
		velocity.y = -VERTICAL_SPEED
	else:
		velocity.y = move_toward(velocity.y, 0, VERTICAL_SPEED)

	move_and_slide()
	update_horizontal_orientation()
	check_for_wall()
	check_for_ceiling()
	
	
func update_horizontal_orientation():
	##facing right
	if direction.x == 1:
		$AnimatedSprite2D.flip_h = false
	
	##facing left
	if direction.x == -1:
		$AnimatedSprite2D.flip_h = true

func check_for_wall():
	if is_on_wall():
		direction.x *= -1

func check_for_ceiling():
	if is_on_ceiling():
		direction.y *= -1


##When player walks into range, start aggression
func _on_player_detector_player_detected():
	aggrod = true
	print("Now we are aggrod")
