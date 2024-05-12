extends Area2D

@export var projectile_speed: int = 300
@export var projectile_damage: int = 10
var hitbox_orientation: float

# Called when the node enters the scene tree for the first time.
func _ready():
	hitbox_orientation = $Hitbox.position.x 

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	position.x += delta * projectile_speed


func start(starting_position, direction_x):
	position = starting_position
	$AnimatedSprite2D.play("Normal")
	
	if direction_x == -1:
		print("GO LEFT ", direction_x)
		projectile_speed = -300
		$AnimatedSprite2D.flip_h = false
		$Hitbox.position.x = -hitbox_orientation
	
	if direction_x == 1:
		print("GO RIGHT ", direction_x)
		projectile_speed = 300
		$AnimatedSprite2D.flip_h = true
		$Hitbox.position.x = hitbox_orientation

func explode():
	$AnimatedSprite2D.play("Explode")
	#await $AnimatedSprite2D.animation_finished
	queue_free()

func _on_body_entered(body):
	explode()
	if body.is_in_group("Player"):
		body.take_damage(projectile_damage)
		

func _on_animated_sprite_2d_animation_finished():
	pass
