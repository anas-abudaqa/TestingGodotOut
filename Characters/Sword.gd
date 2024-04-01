extends Area2D

@export var damage = 10

# Called when the node enters the scene tree for the first time.
func _ready():
	monitoring = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_body_entered(body):
	print("Player what did we touch")
	if body.is_in_group("Damageable"):
		print("Player we just molested an enemy")
		body.take_damage(damage)
