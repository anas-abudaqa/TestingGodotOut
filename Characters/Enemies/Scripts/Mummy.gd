extends CharacterBody2D

@export var player: CharacterBody2D
var SPEED = 50.0
var maximum_health: float = 30
var current_health: float = 0
var direction: float
var is_aggrod: bool = false

var sword_position: float
var hitbox_position: float
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _ready():
	sword_position = $Sword/SwordHitbox.position.x
	hitbox_position = $Hitbox.position.x
	$HealthAndShieldNode.set_health(maximum_health)

func _physics_process(delta):
	has_died()
	#Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

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
	
	##check health in the healthnode since health has not refreshed for Mummy yet
	if $HealthAndShieldNode.current_health <= 0:
		SPEED = 0
		$AnimatedSprite2D.play("Death")
		await $AnimatedSprite2D.animation_finished
		queue_free()
	else:
		$AnimatedSprite2D.play("Hurt")
		await $AnimatedSprite2D.animation_finished

func _on_health_and_shield_node_health_changed(cur_health, _max_health):
	current_health = cur_health


func _on_aggro_area_body_entered(body):
	if body.is_in_group("Player"):
		print("Aggrooo")
		is_aggrod = true


func _on_aggro_area_body_exited(body):
	if body.is_in_group("Player"):
		print("Deaggroo")
		is_aggrod = false

func has_died():
	pass
