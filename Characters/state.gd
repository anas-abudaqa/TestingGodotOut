extends Node

class_name State

@export var can_move: bool = true
var character: CharacterBody2D
var animation_playback: AnimationNodeStateMachinePlayback
var previous_state: State

signal Transitioned

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# create a custom process function that uses delta. 'delta' is the elapsed time since the previous frame.
# This is so the process only runs when this is the current state in the character state machine 
func state_process(delta):
	pass

# create a custom function for input events (as opposed to just using _input() ) 
# This is so the process only runs when this is the current state in the character state machine 
func state_input(event: InputEvent):
	pass

func on_enter():
	pass

func on_exit():
	pass
