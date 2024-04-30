extends Node2D

var cores_picked_up: int = 0
var Zebron_first_interaction: String = ""
#var player = load("res://Characters/player.tscn")
#var player_instance
# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	#player_instance = player.instantiate()

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
	#call_deferred("_deferred_goto_scene")
#
#func _deferred_goto_scene():
	#var current_script = self
	##current_script.queue_free()
	#var script_path = "res://Levels/MainLevel.gd"
	#var script = ResourceLoader.load(script_path)
	#current_script = script.instantiate()
	 
