extends Node2D

var cores_picked_up: int = 0
var Zebron_first_interaction: String = ""
var active_respawn_point

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func change_first_interaction():
	Zebron_first_interaction = "yum"

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	#player = load("res://Characters/player.tscn")
	#cores_picked_up = player_instance.cores_picked_up 
	#print("Kos ", cores_picked_up)
	#print("Omak ", player_instance.cores_picked_up)
	
	#print(cores_picked_up)
	#if cores_picked_up == 4:
		#print("You have won!")
	#print(Zebron_first_interaction)

func set_active_respawn_point(ID):
	if ID == "1":
		active_respawn_point = $RespawnPoint_1
	if ID == "2":
		active_respawn_point = $RespawnPoint2
	if ID == "3":
		active_respawn_point = $RespawnPoint3
	print("This is the set respawn point now: Respawn Point ", active_respawn_point)
	
	
	
func _on_zebron_core_pickup_4_picked_up():
	print("Picked up core number four!")
	cores_picked_up += 1


func _on_zebron_core_pickup_2_picked_up():
	print("Picked up core number two!")
	MainLevel.cores_picked_up += 1
	#call_deferred("_deferred_goto_scene")


func _on_zebron_core_pickup_3_picked_up():
	print("Picked up core number three!")
	cores_picked_up += 1


func _on_zebron_core_pickup_picked_up():
	print("Picked up core number one!")
	cores_picked_up += 1

	 


func _on_player_player_died():
	## create new instance of player, remote transform 2D, and connect the player death signal to this function
	var player_scene =  load("res://Characters/player.tscn")
	var player = player_scene.instantiate()
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
	
