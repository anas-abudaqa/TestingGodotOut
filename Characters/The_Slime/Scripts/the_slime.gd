extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0
var aggrod: bool = false

var acid_bullet_scene = preload("res://Characters/The_Slime/acid_bullets.tscn")
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta):


	

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()



func shoot_acid():
	var projectile = acid_bullet_scene.instantiate()
	##Add as a child of root scene, in this case, we will add it as a child of Main Level
	get_tree().root.add_child(projectile)
	
	pass



##When player walks into range, start aggression
func _on_player_detector_player_detected():
	aggrod = true
