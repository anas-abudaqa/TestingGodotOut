extends Area2D

@export var damage = 10
@export var HealthComponent: Node

# Called when the node enters the scene tree for the first time.
func _ready():
	monitoring = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_body_entered(body):
	if body.is_in_group("Damageable"):
		body.get_damaged(damage)
