extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func spawn(position: Vector2):
	global_position = position
	$AnimatedSprite2D.play("Spawn")
	

func _on_animated_sprite_2d_animation_finished():
	if $AnimatedSprite2D.animation == "Spawn":
		$AnimatedSprite2D.play("Idle")
		$IdleTimer.start()
	
	if $AnimatedSprite2D.animation == "Despawn":
		queue_free()

func _on_timer_timeout():
	$AnimatedSprite2D.play("Despawn")
