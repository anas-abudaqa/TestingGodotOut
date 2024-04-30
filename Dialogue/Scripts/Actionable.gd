extends Area2D

##Attach the dialogue script
@export var dialogue_resource: DialogueResource

##Attach the starting point of the dialogue
@export var dialogue_start: String = "Start"

func action(): 
	DialogueManager.show_example_dialogue_balloon(dialogue_resource, dialogue_start)
