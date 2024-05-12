extends CharacterBody2D

class_name TheSlimeAI
signal SlimeDead
signal aggrod

#@export var playerbody: CharacterBody2D
const SPEED = 175.0
const VERTICAL_SPEED = 150.0
const CONTACT_DAMAGE = 5
var is_aggrod: bool = false
var maximum_health: float = 80
var current_health: float = 0
var player_is_right: bool = false

var direction: Vector2i = Vector2.ZERO

func _ready():
	$HealthAndShieldNode.set_health(maximum_health)

func _physics_process(delta):

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	$HealthAndShieldNode.is_dead()
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

func take_damage(damage_value):
	$HealthAndShieldNode.deal_damage(damage_value)

func _on_health_and_shield_node_health_changed(curr_health, max_health):
	current_health = curr_health
	maximum_health = max_health


func _on_health_and_shield_node_has_died():
	$AnimatedSprite2D.play("Death")
	await $AnimatedSprite2D.animation_finished
	SlimeDead.emit()
	queue_free()


func _on_hitbox_body_entered(body):
	if body.is_in_group("Player"):
		body.take_damage(CONTACT_DAMAGE)


func _on_ray_cast_2d_left_player_detected():
	if not is_aggrod:
		is_aggrod = true
		aggrod.emit()
	player_is_right = false


func _on_ray_cast_2d_right_player_detected():
	player_is_right = true
