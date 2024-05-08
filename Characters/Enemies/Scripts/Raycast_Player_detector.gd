extends RayCast2D

signal player_detected
signal player_not_detected

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if is_colliding():
		#var collider = get_collider()
		#if collider.name == "Player":
			#print("Player detected")
		player_detected.emit()
	else:
		#print("Player not detected")
		player_not_detected.emit()
