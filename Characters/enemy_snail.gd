extends CharacterBody2D


var speed = 10.0
var has_died = false
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var max_health: int = 40
var current_health: int

func _ready():
	$HealthAndShieldNode.health_changed.connect(health_node_health_changed)
	$HealthAndShieldNode.set_health_and_shield(max_health, false)
	
func get_damaged(value: int):
	$HealthAndShieldNode.deal_damage(value)
	
func health_node_health_changed(health, shield):
	current_health = health

func _process(delta):
	pass

func _physics_process(delta):
	# Add the gravity.
	$HealthAndShieldNode.is_dead()
	if not is_on_floor():
		velocity.y += gravity * delta
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.d
	var direction = -1
	velocity.x = direction * speed

	move_and_slide()
	update_animation()

func update_animation():
	if not has_died:
		if velocity.x != 0: 
			$AnimatedSprite2D.play("Walking")
		else:
			$AnimatedSprite2D.play("Idle")


func _on_health_and_shield_node_has_died():
	has_died = true
	speed = 0
	$AnimatedSprite2D.play("Death")
	await $AnimatedSprite2D.animation_finished
	queue_free()
	

