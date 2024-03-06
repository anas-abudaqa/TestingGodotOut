extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_body_entered(body):
	if body.is_in_group("Damageable"):
		body.direction.x *= -1
		body.direction.y *= -1
	
	elif body.is_in_group("Player"):
		body.velocity = Vector2.ZERO
	
	elif body.is_in_group("Projectile"):
		body.queue_free()
