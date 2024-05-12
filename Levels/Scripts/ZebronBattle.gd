extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	$YouDied.visible = false
	$RespawnButton.visible = false
	$Thanks.visible = false
	$ZebronDied.visible = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_respawn_button_pressed():
	print("Button pressed brooo")
	get_tree().reload_current_scene()


func _on_player_max_player_died():
	$YouDied.visible = true
	$DeathScreenTimer.start()

func _on_death_screen_timer_timeout():
	$RespawnButton.visible = true

func _on_zebron_boss_zebron_dead():
	$ZebronDied.visible = true
	$ZebronDeathTimer.start()

func _on_zebron_death_timer_timeout():
	$Thanks.visible = true
