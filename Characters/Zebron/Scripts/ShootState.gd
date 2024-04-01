extends State

@export var teleport_state: State
@export var idle_state: State

var zebron_bullet_scene = preload("res://Characters/Zebron/ZebronBullet.tscn")
var shot_direction: Vector2
# Called when the node enters the scene tree for the first time.
var shot_counter: int
var direction_vector = []
var x_array = [-1, 0, 1]
var y_array = [-1, 0, 1]

func on_enter():
	create_direction_vector()
	animated_sprite.play("Shoot")
	

func create_direction_vector():
	##(-1, -1), (-1, 0), (-1, 1), (0, -1), (0, 0), (0, 1), (1, -1), (1, 0), (1, 1)
	#
	for x in x_array:
		for y in y_array:
			direction_vector.append(Vector2(x, y))
	
	##remove zero vector
	direction_vector.erase(Vector2.ZERO)
	
	
func spawn_shot():
	for direction in direction_vector:
		var projectile = zebron_bullet_scene.instantiate()
		##Add as a child of root scene, in this case, we will add it as a child of Main Level
		get_tree().root.add_child(projectile)
		projectile.start(character.global_position + Vector2(0, -20))
		projectile.set_direction(direction)
	
	character.teleport_shot_counter += 1

func launch_shot():
	pass


func face_player():
	##player to the right of this character
	if character.playerbody.position.x - character.position.x > 20: 
		animated_sprite.flip_h = false
		#shot_direction.x = +1
	##player to the left of this character
	if character.playerbody.position.x - character.position.x < 20: 
		animated_sprite.flip_h = true
		#shot_direction.x = -1
		


func _on_animated_sprite_2d_animation_finished():
	if animated_sprite.animation == "Shoot":
		face_player()
		spawn_shot()
		$CooldownTimer.start()
		


func _on_cooldown_timer_timeout():
	print(character.teleport_shot_counter)
	if character.teleport_shot_counter <= 5:
		#create_direction_vector()
		#animated_sprite.play("Shoot")
		Transitioned.emit(self, teleport_state)
	else:
		Transitioned.emit(self, idle_state)
