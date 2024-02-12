extends CharacterBody2D

@onready var state_machine: CharacterStateMachine = $CharacterStateMachine

@export_category("Player settings")
@export var player_speed: float = 150.0
@export var jump_velocity: float = -200.0
@export var double_jump_velocity_horizontal: float = 50
@export var double_jump_velocity_vertical: float = -150

var locked_abilities = ["OnWall"]
var unlocked_abilities = []

var direction: Vector2 = Vector2.ZERO
var sword_position: float
var max_health: int = 100
var current_health: int


# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
	sword_position = $Sword/SwordHitbox.position.x
	$AnimationTree.active = true
	$HealthAndShieldNode.set_health(max_health)
	

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
	# Get the input direction and handle the movement/deceleration.
	direction = Input.get_vector("Left", "Right", "Up", "Down") #-1, +1, -1, +1
	##if there is an x-axis input, and we are in a state that allows moving, then move
	if direction.x and state_machine.can_move():
		velocity.x = direction.x *  player_speed
	else:
		velocity.x = move_toward(velocity.x, 0, player_speed)
	
	move_and_slide()
	update_animation_parameters() 
	update_orientation()
	 
	
func update_animation_parameters():
	$AnimationTree.set("parameters/Move/blend_position", direction.x)
	
func update_orientation():
	##facing right
	if direction.x > 0:
		$Sprite2D.flip_h = false
		$Sword/SwordHitbox.position.x = sword_position
	##facing left
	if direction.x < 0:
		$Sprite2D.flip_h = true
		#$Sword.position.x *= -1
		$Sword/SwordHitbox.position.x = -sword_position


func _on_health_and_shield_node_health_changed(health, max_hp):
	current_health = health
	max_health = max_hp


func _on_pick_up_ability_unlocked(ability_name):
	locked_abilities.erase(ability_name)
	unlocked_abilities.append(ability_name)
	$CharacterStateMachine.unlock_state(ability_name)
	print(unlocked_abilities)
