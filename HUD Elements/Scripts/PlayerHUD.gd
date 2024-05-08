extends HBoxContainer

#@export var player: CharacterBody2D

# Called when the node enters the scene tree for the first time.
func _ready():
	$Core1.visible = false
	$Core2.visible = false
	$Core3.visible = false
	$Core4.visible = false
	$Healthbar.max_value = get_parent().max_health
	$Healthbar.value = get_parent().current_health
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$Healthbar.value = get_parent().current_health

func _on_zebron_core1_pickup_picked_up():
	$Core1.visible = true
	$Core1.play("Twinkle")


func _on_zebron_core_pickup_2_picked_up():
	$Core2.visible = true
	$Core2.play("Twinkle")


func _on_zebron_core_pickup_3_picked_up():
	$Core3.visible = true
	$Core3.play("Twinkle")


func _on_zebron_core_pickup_4_picked_up():
	$Core4.visible = true
	$Core4.play("Twinkle")
