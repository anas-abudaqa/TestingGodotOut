extends Area2D

var projectile_speed: int
@export var projectile_damage: int = 10
var hitbox_orientation: float
# Called when the node enters the scene tree for the first time.
func _ready():
	hitbox_orientation = $Hitbox.position.x 

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	position.x += delta * projectile_speed

func start(starting_position, facing_direction):
	position = starting_position
	
	if facing_direction == "left":
		print("GO LEFT ")
		projectile_speed = 200
		$Sprite2D.flip_h = true
		$Hitbox.position.x = -hitbox_orientation
	
	if facing_direction == "right":
		print("GO RIGHT ")
		projectile_speed = -200
		$Sprite2D.flip_h = false
		$Hitbox.position.x = hitbox_orientation
		
		
#func _on_area_entered(area):
##if area.is_in_group("Damageable"):
	#print("Collision with area ", area)
	#queue_free()

func _on_body_entered(body):
	print("Collision with body ", body)
	if body.is_in_group("Player"):
		body.take_damage(projectile_damage)
		queue_free()
