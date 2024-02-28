extends CharacterBody2D

var direction: int = 1 ##left is negative 1, right is positive 1
var speed: int = 30.0
var has_died: bool = false
var aggrod: bool = false


var max_health: int = 40
var current_health: int
var contact_damage: int = 10


# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")



func _ready():
	$HealthAndShieldNode.health_changed.connect(health_node_health_changed)
	$HealthAndShieldNode.set_health(max_health)

func _physics_process(delta):
	$HealthAndShieldNode.is_dead()
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
	
	if !aggrod:
		roam_around()
	else:
		aggro_player()
	velocity.x = direction * speed
	
	move_and_slide()
	update_animation()
	update_orientation()

func update_animation():
	if not has_died:
		if velocity.x != 0: 
			$AnimatedSprite2D.play("Walking")
		else:
			$AnimatedSprite2D.play("Idle")

func update_orientation():
	##facing left
	if direction < 0: 
		$AnimatedSprite2D.flip_h = false
	##facing right
	if direction > 0:
		$AnimatedSprite2D.flip_h = true
		#$Sword.position.x *= -1


func get_damaged(value: int):
	$HealthAndShieldNode.deal_damage(value)
	
func health_node_health_changed(health, _max_hp):
	current_health = health

func _on_health_and_shield_node_has_died():
	has_died = true
	speed = 0
	$AnimatedSprite2D.play("Death")
	await $AnimatedSprite2D.animation_finished
	queue_free()


func roam_around():
	##check if timer is stopped so we don't keep starting it every physicks process
	if $RoamingTimer.is_stopped():
		$RoamingTimer.start()
		direction *= -1
		print("Starting direction ", direction)

func aggro_player():
	$RoamingTimer.stop()
	##player to the right of snail
	if get_parent().get_node("Player").position.x - position.x > 20: 
			direction = 1
	##player to the left of snail
	elif get_parent().get_node("Player").position.x - position.x < -20:  
		direction = -1
	else:
		direction = 0

func _on_aggro_area_body_entered(body):
	if body.is_in_group("Player"):
		print("aggro")
		aggrod = true


func _on_aggro_area_body_exited(body):
	if body.is_in_group("Player"):
		print("deaggro")
		aggrod = false


func _on_roaming_timer_timeout():
	direction *= -1
	print("Roam: ", direction)
#

	

##Not working properly
func _on_collision_shape_body_entered(body):
	if body.is_in_group("Player"):
		body.get_damaged(contact_damage)
