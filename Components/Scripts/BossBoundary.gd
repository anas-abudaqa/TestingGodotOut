extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready():
	 = false


## Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
	#pass
#
#
#func _on_body_entered(body):
	#if body.is_in_group("Damageable"):
		#body.direction.x *= -1
		#body.direction.y *= -1
	#
	##elif body.is_in_group("Player"):
		##body.position.x = body.position.x
#
#
#func _on_the_slime_slime_dead():
	#queue_free()
	#
#
#
#func _on_the_slime_aggrod():
	#print("We should be blocking now")
	#monitoring = true


func _on_the_slime_slime_dead():
	queue_free()


func _on_the_slime_aggrod():
	


func _on_the_slime_slime_dead():
	pass # Replace with function body.


func _on_the_slime_slime_dead():
	pass # Replace with function body.


func _on_the_slime_aggrod():
	pass # Replace with function body.


func _on_the_slime_aggrod():
	pass # Replace with function body.
