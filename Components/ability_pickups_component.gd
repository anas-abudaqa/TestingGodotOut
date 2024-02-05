extends Area2D

signal ability_unlocked
signal ability_locked

var ability_name = "OnWall"
# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

## use function to set ability name
func set_ability_name(ability):
	ability_name = ability

func unlock_ability():
	ability_unlocked.emit(ability_name)
	
func lock_ability():
	ability_locked.emit(ability_name)

## on collision, call unlock ability function and delete the pick up
func _on_body_entered(body):
	if body.name == "Player":
		print("Picked up")
		unlock_ability()
		queue_free()
