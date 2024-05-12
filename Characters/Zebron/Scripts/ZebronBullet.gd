extends Area2D

const SPEED: int = 250

var projectile_speed_y: float = 0
var projectile_speed: float = 0
var projectile_damage: int = 20
var y_axis_offset: float = 0
# Called when the node enters the scene tree for the first time.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	position.x += delta * projectile_speed
	position.y += delta * projectile_speed_y
	#pass
	
func start(starting_position: Vector2):
	position = starting_position
	$AnimatedSprite2D.play("Normal")


func set_direction(direction: Vector2):
	if direction.x == -1:
		print("GO LEFT ", direction.x)
		projectile_speed = -SPEED
	
	if direction.y == -1:
		print("GO UP ", direction.y)
		projectile_speed_y = -SPEED/2 + y_axis_offset
	
	if direction.x == +1:
		print("GO RIGHT ", direction.x)
		projectile_speed = SPEED

	if direction.y == +1:
		print("GO DOWN ", direction.y)
		projectile_speed_y = SPEED/2 + y_axis_offset
	
func _on_body_entered(body):
	
	if body.is_in_group("Player"):
		body.take_damage(projectile_damage)
	queue_free()
	#$AnimatedSprite2D.play("Explode")
	

func _on_animated_sprite_2d_animation_finished():
	if $AnimatedSprite2D.animation == "Explode":
		queue_free()
