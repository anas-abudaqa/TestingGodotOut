extends Camera2D

@export var player: CharacterBody2D
# Called when the node enters the scene tree for the first time.


func _ready():
	pass
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	#camera_panning()

#func camera_panning():
	###Move camera at increments of 1/4th of the viewport resolution 1280×800
	#position = player.position
	#var x = floor(position.x / 640) * 640
	#var y = floor(position.y / 400) * 400
	#
	#position = Vector2(x, y)
