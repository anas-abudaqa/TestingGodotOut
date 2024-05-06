extends Area2D

@export var respawn_point_ID: String
var activated: bool = false
signal player_detected
signal player_left


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_body_entered(body):
	if body.is_in_group("Player"):
		print("Player in spawn point detected")
		player_detected.emit(respawn_point_ID)


func _on_body_exited(body):
	if body.is_in_group("Player"):
		player_left.emit(respawn_point_ID)
