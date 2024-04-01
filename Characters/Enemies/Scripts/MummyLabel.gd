extends Label

@export var state_machine: MummyStateMachine
@export var Character: CharacterBody2D
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	text = "State: " + str(state_machine.current_state.name)
	text += "
	Aggrod: " + str(Character.is_aggrod)
	text += "
	HP: " + str(Character.current_health)
