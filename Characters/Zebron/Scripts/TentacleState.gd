extends State
var tentacle_scene = preload("res://Characters/Zebron/Zebrontentacle.tscn")


func on_enter():
	animated_sprite.play("Disappear")
	

func spawn_tentacles():
	for child in get_children():
		print("Child is: ", child.name)
		print("Child spawns: ", child.global_position)
		var tentacle = tentacle_scene.instantiate()
		tentacle.spawn(child.global_position)



func _on_animated_sprite_2d_animation_finished():
	if animated_sprite.animation == "Disappear":
		#print("we disappearing bro")
		animated_sprite.visible = false
		character.global_position = character.spawn_point.global_position
		animated_sprite.play("Reappear")
	
	if animated_sprite.animation == "Reappear":
		spawn_tentacles()
