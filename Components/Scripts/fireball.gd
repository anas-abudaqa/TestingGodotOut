extends Area2D

@export var projectile_speed: int = 400
@export var projectile_damage: int = 20
var hitbox_orientation: float
# Called when the node enters the scene tree for the first time.
func _ready():
	hitbox_orientation = $Hitbox.position.x 

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	position.x += delta * projectile_speed


func start(starting_position, direction_x):
	position = starting_position
	
	if direction_x < 0 :
		print("GO LEFT ", direction_x)
		projectile_speed = -400
		$AnimatedSprite2D.flip_h = false
		$Hitbox.position.x = -hitbox_orientation
	
	if direction_x > 0:
		print("GO RIGHT ", direction_x)
		projectile_speed = 400
		$AnimatedSprite2D.flip_h = true
		$Hitbox.position.x = hitbox_orientation
		
		
func _on_area_entered(area):
#if area.is_in_group("Damageable"):
	print("Collision with area ", area)
	queue_free()


func _on_body_entered(body):
	print("Collision with body ", body)
	if body.is_in_group("Torch"):
		body.light_up()
		
	if body.is_in_group("Damageable"):
		body.take_damage(projectile_damage)
	queue_free()
