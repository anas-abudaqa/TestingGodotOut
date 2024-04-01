extends State

@export var chaseplayer_state: State
@export var acidshot_state: State
# Called when the node enters the scene tree for the first time.


func state_process(delta):
	##only check for ground collisions if character is expected to be moving down
	if character.direction.y == 1:
		check_for_ground()

func on_enter():
	character.direction.x = -1
	$HorizontalMovementTimer.start()

func on_exit():
	character.direction = Vector2.ZERO

func _on_horizontal_movement_timer_timeout():
	#character.direction.y = -1
	Transitioned.emit(self, acidshot_state)
	#$VerticalMovementTimer.start()


func _on_vertical_movement_timer_timeout():
	pass

func check_for_ground():
	if character.is_on_floor():
		character.direction.y *= -1


	
