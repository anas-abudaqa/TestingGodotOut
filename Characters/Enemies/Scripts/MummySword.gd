extends Area2D

@export var damage = 10

# Called when the node enters the scene tree for the first time.
func _ready():
	
	monitoring = false

func _on_body_entered(body):
	if body.is_in_group("Player"):
		print("Take that bitch")
		body.take_damage(damage)
