extends StaticBody2D

signal unlock_pathway

var lit_texture = preload("res://Art/Lit_torch.png")
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func light_up():
	unlock_pathway.emit()
	$Sprite2D.texture = lit_texture
	$AudioStreamPlayer.play()
