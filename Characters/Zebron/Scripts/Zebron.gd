extends CharacterBody2D

class_name ZebronAI
signal ZebronDead
signal GoToIdle

@export var playerbody: CharacterBody2D
@export var spawn_point: Marker2D

const SPEED = 200.0
const VERTICAL_SPEED = 140.0
const CONTACT_DAMAGE = 10
var maximum_health: float = 200
var current_health: float = 0
var teleport_shot_counter: int = 0

var direction: Vector2i = Vector2.ZERO

func _ready():
	$HealthAndShieldNode.set_health(maximum_health)
	#global_position = spawn_point.global_position

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
	#$AnimatedSprite2D.play("Death")
	#await $AnimatedSprite2D.animation_finished
	ZebronDead.emit()
	GoToIdle.emit()
	queue_free()


#func _on_player_player_died():
	#
	#print("Zebron detected Player died")
	#GoToIdle.emit()


func _on_player_max_player_died():
	print("Zebron detected Player died")
	GoToIdle.emit()
