extends HBoxContainer

#@export var character: CharacterBody2D

# Called when the node enters the scene tree for the first time.
func _ready():
	$Healthbar.max_value = get_parent().maximum_health

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$Healthbar.value = get_parent().current_health
