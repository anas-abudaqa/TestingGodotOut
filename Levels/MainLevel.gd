extends Node2D

var cores_picked_up: int = 0
var Zebron_first_interaction: String = ""
var active_respawn_point
var unlocked_abilities = []
@export var playerbody: CharacterBody2D

# Called when the node enters the scene tree for the first time.
func _ready():
	active_respawn_point = $RespawnPoint_0

func change_first_interaction(text):
	Zebron_first_interaction = text

		
#func set_active_respawn_point(ID):
	#if ID == "1":
		#active_respawn_point = $RespawnPoint_1
	#if ID == "2":
		#active_respawn_point = $RespawnPoint2
	#if ID == "3":
		#active_respawn_point = $RespawnPoint3
	#print("This is the set respawn point now: Respawn Point ", active_respawn_point)
	

func trigger_Zebron_battle():
	print("Now we go fight!")
	get_tree().change_scene_to_file("res://Levels/zebron_battle.tscn")
	
func _on_zebron_core_pickup_4_picked_up():
	print("Picked up core number four!")
	cores_picked_up += 1
	if cores_picked_up == 4:
		$ZebronIdle/Actionable.dialogue_start = "Endgame"


func _on_zebron_core_pickup_2_picked_up():
	print("Picked up core number two!")
	cores_picked_up += 1
	if cores_picked_up == 4:
		$ZebronIdle/Actionable.dialogue_start = "Endgame"


func _on_zebron_core_pickup_3_picked_up():
	print("Picked up core number three!")
	cores_picked_up += 1
	if cores_picked_up == 4:
		$ZebronIdle/Actionable.dialogue_start = "Endgame"


func _on_zebron_core_pickup_picked_up():
	print("Picked up core number one!")
	cores_picked_up += 1
	if cores_picked_up == 4:
		$ZebronIdle/Actionable.dialogue_start = "Endgame"

func _on_player_player_died():
	## create new instance of player, remote transform 2D, and connect the player death signal to this function
	var player_scene =  load("res://Characters/player.tscn")
	var player = player_scene.instantiate()
	player.name = "Player"
	#create new RemoteTransform2D node
	var remote_transform = RemoteTransform2D.new()
	remote_transform.name = "RemoteTransform2D"
	#Provide path assuming we are in player scene
	remote_transform.remote_path = "/root/Level/Camera2D"
	#Add player to level scene
	get_tree().root.add_child(player)
	#print("Player has this many children: ", player.get_child_count())
	player.add_child(remote_transform)
	#Set respawn position to active respawn point position
	player.global_position = active_respawn_point.global_position
	#connect death signal from player to this fucntion
	player.connect("player_died", _on_player_player_died)
	player.add_to_group("Player")
	for ability in unlocked_abilities:
		player.unlock_ability(ability)
	playerbody = player
	print(get_children())


func _on_wall_jump_pick_up_ability_unlocked(ability_name):
	unlocked_abilities.append(ability_name)
	playerbody.unlock_ability(ability_name)


func _on_dash_pick_up_ability_unlocked(ability_name):
	unlocked_abilities.append(ability_name)
	playerbody.unlock_ability(ability_name)

func _on_fireball_pick_up_ability_unlocked(ability_name):
	unlocked_abilities.append(ability_name)
	playerbody.unlock_ability(ability_name)


func _on_respawn_point_3_player_detected(_respawn_point_ID):
	active_respawn_point = $RespawnPoint3
	print("This is now the active respawn point ", active_respawn_point)
	
func _on_respawn_point_2_player_detected(_respawn_point_ID):
	active_respawn_point = $RespawnPoint2
	print("This is now the active respawn point ", active_respawn_point)
	
func _on_respawn_point_1_player_detected(_respawn_point_ID):
	active_respawn_point = $RespawnPoint1
	print("This is now the active respawn point ", active_respawn_point)
