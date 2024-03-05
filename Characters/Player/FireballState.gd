extends State

class_name FireballState

@export var ground_state : State

var fireball_scene = preload("res://Components/fireball.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func on_enter():
	##If the cooldown time period expired
	if $CooldownTimer.is_stopped():
		## create instance of fireball scene and save it to variable projectile
		var projectile = fireball_scene.instantiate()
		## Add it to the root scene of the current scene tree
		get_tree().root.add_child(projectile)
		##call start function and feed it spawn position. Adjusted for player height
		projectile.start(character.position + Vector2(48, -56), character.direction.x)
		##Start timer
		$CooldownTimer.start()
	#Transition back always, regardless of cooldown timer status
	Transitioned.emit(self, previous_state)


