extends StaticBody2D


# Called when the node enters the scene tree for the first time.
func _ready():
	$CollisionShape2D.set_deferred("disabled", true)


func _on_the_slime_slime_dead():
	queue_free()


func _on_the_slime_aggrod():
	$CollisionShape2D.set_deferred("disabled", false)
