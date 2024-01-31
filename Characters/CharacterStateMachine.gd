extends Node

class_name CharacterStateMachine

@export var character: CharacterBody2D
@export var animation_state_machine : AnimationTree
@export var initial_state : State 
var states_array : Array[State]
var current_state : State

# Called when the node enters the scene tree for the first time.
func _ready():
	## get children under CharacterStateMachine node
	for child in get_children():
		##error handling; checking if the child is a state
		if child is State:
			##add to our array
			states_array.append(child)
			##define the character they affect
			child.character = character
			child.Transitioned.connect(on_state_transition)
			child.animation_playback = animation_state_machine["parameters/playback"]
			
			## DEBUGGING
			print(child)
			## END DEBUGGING
			
		else:
			push_warning("Warning, child " + child.name + " is not a State ya kos omak")
	
	if initial_state:
		initial_state.on_enter()
		current_state = initial_state
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	##run state_process of current state
	current_state.state_process(delta)
	
func can_move():
	return current_state.can_move

func _input(event: InputEvent):
	current_state.state_input(event)

func on_state_transition(calling_state : State, next_state : State):
	#if the state calling the function is not the current state, ignore
	print("Transitioning from ", current_state, " to", next_state)
	if calling_state != current_state:
		return

	## if there is a current state, call on_exit function
	if current_state:
		current_state.on_exit()
		
	## call next states	and its on_enter function
	if next_state in states_array:
		next_state.on_enter()
		current_state = next_state
		
	else:
		push_warning("Invalid input for next_state ")
