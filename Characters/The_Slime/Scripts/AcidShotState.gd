extends State

class_name AcidShotState

@export var idle_state : State

var acid_bullet_scene = preload("res://Characters/The_Slime/acid_bullets.tscn")
var shot_direction: int
# Called when the node enters the scene tree for the first time.


func on_enter():
	##If the cooldown time period expired
	face_player()
	if $CooldownTimer.is_stopped():
		spawn_acidshot()
		$CooldownTimer.start()
	

func spawn_acidshot():
	animated_sprite.play("Fire")
	var projectile = acid_bullet_scene.instantiate()
	##Add as a child of root scene, in this case, we will add it as a child of Main Level
	get_tree().root.add_child(projectile)
	projectile.start(character.global_position, shot_direction)


func face_player():
	##player to the right of this character
	if character.playerbody.position.x - character.position.x > 20: 
		animated_sprite.flip_h = false
		shot_direction = +1
	##player to the left of this character
	if character.playerbody.position.x - character.position.x < 20: 
		animated_sprite.flip_h = true
		shot_direction = -1


func _on_cool_down_timer_timeout():
	Transitioned.emit(self, idle_state)
	
