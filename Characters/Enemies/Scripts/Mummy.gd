extends CharacterBody2D

#@export var player: CharacterBody2D
var SPEED = 50.0
var maximum_health: float = 30
var current_health: float = 0
var direction: float
var is_aggrod: bool = false
var is_hurt: bool = false
var is_hurt_by_fire: bool = false
var player_on_left: bool = false
var player_on_right: bool = true
var sword_position: float
var hitbox_position: float
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _ready():
	sword_position = $Sword/SwordHitbox.position.x
	hitbox_position = $Hitbox.position.x
	$HealthAndShieldNode.set_health(maximum_health)
	#var player = get_tree().root.find_child("Player")
	#var player = get_node("/root/Player")
	#print("Mummy sees this player ", player)


func _physics_process(delta):
	## Check every single frame for death, otherwise will run into bugs where death isn't registered if it happened mid animation
	$HealthAndShieldNode.is_dead()
	if is_hurt_by_fire:
		$AudioStreamPlayer.play()
		is_hurt_by_fire = false
	#Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
	if not player_on_left and not player_on_right:
		is_aggrod = false
		direction = 0
		
	if direction and $CharacterStateMachine.can_move():
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
	update_orientation()
	
	
func update_orientation():
	##facing right
	if direction == +1:
		$AnimatedSprite2D.flip_h = true
		
		##Sprite is not centered correctly in original art, so we need to move the collision shape too
		$Hitbox.position.x = -hitbox_position
		$Sword/SwordHitbox.position.x = -sword_position
	##facing left
	if direction == -1:
		$AnimatedSprite2D.flip_h = false
		
		##Sprite is not centered correctly in original art, so we need to move the collision shape too
		$Hitbox.position.x = hitbox_position
		#$Sword.position.x *= -1
		$Sword/SwordHitbox.position.x = sword_position

func take_damage(damage_value):
	$HealthAndShieldNode.deal_damage(damage_value)
	is_hurt = true
	##Commented code does not work as death will only register when take_damage function is called. Caused issues where other animations can overwrite death sequence
	#if $HealthAndShieldNode.current_health <= 0:
		#
		##SPEED = 0
		##$AnimatedSprite2D.play("Death")
		##await $AnimatedSprite2D.animation_finished
		##queue_free()
	#else:
		#is_hurt = true

func _on_health_and_shield_node_health_changed(cur_health, _max_health):
	current_health = cur_health



func _on_health_and_shield_node_has_died():
	print("DEAD MF")
	SPEED = 0
	$AnimatedSprite2D.play("Death")
	await $AnimatedSprite2D.animation_finished
	queue_free()


func _on_ray_cast_2d_left_player_detected():
	is_aggrod = true
	direction = -1
	player_on_left = true


func _on_ray_cast_2d_left_player_not_detected():
	player_on_left = false
	#is_aggrod = false
	#direction = 0


func _on_ray_cast_2d_right_player_detected():
	is_aggrod = true
	direction = +1
	player_on_right = true


func _on_ray_cast_2d_right_player_not_detected():
	player_on_right = false
	#is_aggrod = false
	#direction = 0
