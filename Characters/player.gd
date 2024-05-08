extends CharacterBody2D

signal player_died

@onready var state_machine: CharacterStateMachine = $CharacterStateMachine

#@export_category("Player settings")
var player_speed: float = 130.0
var jump_velocity: float = -250.0
var double_jump_velocity_horizontal: float = 50
var double_jump_velocity_vertical: float = -150

var locked_abilities = ["OnWall", "Dash", "Fireball"]
var unlocked_abilities = []
#var cores_picked_up: int = 0
var direction: Vector2 = Vector2.ZERO
var sword_position: float
var max_health: int = 50
var current_health: int
var invulnerable: bool = false
var facing_right: bool = false
var is_in_respawn_point: bool = false
var respawn_point_ID: String 
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
	sword_position = $Sword/SwordHitbox.position.x
	$AnimationTree.active = true
	$HealthAndShieldNode.set_health(max_health)
	#$RemoteTransform2D.remote_path = get_tree().root.find_child("Camera2D")
	
func _physics_process(delta):
	$HealthAndShieldNode.is_dead()
	# Add the gravity.
	#print(cores_picked_up)
	if not is_on_floor():
		velocity.y += gravity * delta
	# Get the input direction and handle the movement/deceleration.
	if Input.is_action_just_pressed("Interact"):
		##Check if there is any collisions with our ActionableFinder collision box and fill var actionables with their references
		var actionables = $ActionableFinder.get_overlapping_areas()
		##if actionables has any entries in it
		if actionables.size() > 0:
			#run action method
			actionables[0].action()
		
		##Check if we are in a respawn point. If so, run the set active respawn point in the Level script
		if is_in_respawn_point:
			get_parent().set_active_respawn_point(respawn_point_ID)
		
		
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
		facing_right = true
		$Sword/SwordHitbox.position.x = sword_position
	##facing left
	if direction.x < 0:
		$Sprite2D.flip_h = true
		facing_right = false
		#$Sword.position.x *= -1
		$Sword/SwordHitbox.position.x = -sword_position


func take_damage(value: int):
	if not invulnerable:
		$HealthAndShieldNode.deal_damage(value)
		$InvulnerabilityTimer.start()
		invulnerable = true

func heal_HP(heal_value: int):
	$HealthAndShieldNode.heal(heal_value)

func increase_max_hp(boost_value: int):
	$HealthAndShieldNode.increase_max_health(boost_value)

func unlock_ability(ability_name: String):
	locked_abilities.erase(ability_name)
	unlocked_abilities.append(ability_name)
	$CharacterStateMachine.unlock_state(ability_name)
	print(unlocked_abilities)

func _on_health_and_shield_node_health_changed(health, max_hp):
	current_health = health
	max_health = max_hp


func _on_pick_up_ability_unlocked(ability_name):
	locked_abilities.erase(ability_name)
	unlocked_abilities.append(ability_name)
	$CharacterStateMachine.unlock_state(ability_name)
	print(unlocked_abilities)


func _on_dash_pick_up_ability_unlocked(ability_name):
	locked_abilities.erase(ability_name)
	unlocked_abilities.append(ability_name)
	$CharacterStateMachine.unlock_state(ability_name)
	print(unlocked_abilities)


func _on_fireball_pick_up_ability_unlocked(ability_name):
	unlock_ability(ability_name)


func _on_terrain_detector_entered_lava():
	take_damage(current_health)


func _on_terrain_detector_entered_spikes():
	take_damage(20)


func _on_health_and_shield_node_has_died():
	current_health = 0
	$AnimationTree.get("parameters/playback").travel("Death")
	#await $AnimationPlayer.animation_finished 
	queue_free()
	player_died.emit()


func _on_invulnerability_timer_timeout():
	invulnerable = false

##Set ID and proximity flag of player when collision with respawn point collision shape
func _on_respawn_point_player_detected(ID):
	print("Player entered vicinity of respawn point", ID)
	respawn_point_ID = ID
	is_in_respawn_point = true

##Remove ID and proximity flag of player when collision with respawn point collision shape
func _on_respawn_point_player_left(ID):
	print("Player left vicinity of respawn point: ", ID)
	respawn_point_ID = ""
	is_in_respawn_point = false

func _on_respawn_point_2_player_detected(ID):
	print("Player entered vicinity of respawn point", ID)
	respawn_point_ID = ID
	is_in_respawn_point = true

func _on_respawn_point_2_player_left(ID):
	print("Player left vicinity of respawn point: ", ID)
	respawn_point_ID = ""
	is_in_respawn_point = false

func _on_respawn_point_3_player_detected(ID):
	print("Player entered vicinity of respawn point", ID)
	respawn_point_ID = ID
	is_in_respawn_point = true

func _on_respawn_point_3_player_left(ID):
	print("Player left vicinity of respawn point: ", ID)
	respawn_point_ID = ""
	is_in_respawn_point = false
