extends Area2D

signal PlayerDetected

# Called when the node enters the scene tree for the first time.

func _on_body_entered(body):
	if body.is_in_group("Player"):
		PlayerDetected.emit()
