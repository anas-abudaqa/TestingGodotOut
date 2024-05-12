extends State
@export var idle_state: State

var tentacle_scene = preload("res://Characters/Zebron/Zebrontentacle.tscn")


func on_enter():
	animated_sprite.play("Disappear_1")
	$DisappearAudio.play()
	#character.global_position = character.spawn_point.global_position
	#spawn_tentacles()

func spawn_tentacles():
	for child in get_children():
		if child.name != "Timer" and child.name != "DisappearAudio" and child.name != "ReappearAudio":
			print("Child is: ", child.name)
			print("Child spawns: ", child.global_position)
			var tentacle = tentacle_scene.instantiate()
			character.add_child(tentacle)
			tentacle.spawn(child.global_position)
			tentacle.connect("TentacleDespawned", move_to_idle_state)


func spawn_tentacles_2():
	var x_offset = -25
	for child in get_children():
		if child.name != "Timer" and child.name != "DisappearAudio" and child.name != "ReappearAudio":
			print("Child is: ", child.name)
			print("Child spawns: ", child.global_position + Vector2(x_offset, 0))
			print("Child has this offset: ", x_offset)
			var tentacle = tentacle_scene.instantiate()
			character.add_child(tentacle)
			tentacle.spawn(child.global_position)
			tentacle.connect("TentacleDespawned", move_to_idle_state)
			x_offset += 10

func _on_animated_sprite_2d_animation_finished():
	if animated_sprite.animation == "Disappear_1":
		print("we disappearing bro")
		animated_sprite.visible = false
		#$Timer.start()
		animated_sprite.visible = true
		animated_sprite.play("Reappear_1")
		$ReappearAudio.play()
		character.global_position = character.spawn_point.global_position
		
	elif animated_sprite.animation == "Reappear_1":
		print("I'm reappearing now")
		animated_sprite.play("Tentacle")
		$Timer.start()
	#else:
		#print("What the fuck is this animation: ", animated_sprite.animation)

func _on_timer_timeout():
	spawn_tentacles()
	
func move_to_idle_state():
	Transitioned.emit(self, idle_state)
