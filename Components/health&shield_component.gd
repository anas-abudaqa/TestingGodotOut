extends Node

var max_health: int = 0
var current_health: int
var max_shield: int = 0
var current_shield: int = 0
var shield_enabled: bool = false 
signal has_died
signal health_changed
signal shield_changed
signal on_max_hp_boost
signal on_shield_heal
signal on_max_shield_boost


# Called when the node enters the scene tree for the first time.
func set_health_and_shield(maximum_health, enable_shield: bool):
	max_health = maximum_health
	current_health = clamp(max_health, 0, max_health)
	#current_health = max_health
	health_changed.emit(current_health, current_shield)

func set_shield(maximum_shield):
	shield_enabled = true
	max_shield = maximum_shield
	current_shield = clamp(max_shield, 0, max_shield)
	shield_changed.emit(current_shield, max_shield)

func deal_damage(damage_value: int):
	##if shield is enabled and current shield is not zero
	if shield_enabled and current_shield > 0:
		var damage_through_shield = damage_value - current_shield
		#if there is more damage value than current shield
		if damage_through_shield > 0:
			#subtract it from current_health
			current_health -= damage_through_shield
			#and set shield to 0
			current_shield = 0
		else: #if damage_through_shield is 0 or negative, deal damage to shield instead
			current_shield += damage_through_shield
	else: ##if shield not enabled or current shield is 0, deal damage to health directly
		current_health -= damage_value
	
	health_changed.emit(current_health, current_shield)
	
func heal(healing_amount: int):
	#heal by this amount
	current_health += healing_amount
	health_changed.emit(current_health)
	
func increase_max_health(max_health_boost: int):
	#increase max health and heal for the boost amount too
	max_health += max_health_boost
	current_health += max_health_boost
	on_max_hp_boost.emit(current_health, max_health)

func heal_shield(shield_healing_amount: int):
	current_shield += shield_healing_amount
	on_shield_heal.emit(current_shield)

func increase_max_shield(max_shield_boost: int):
	if shield_enabled:
		max_shield += max_shield_boost
		on_max_shield_boost.emit(max_shield)

func is_dead():
	if current_health <= 0:
		has_died.emit() ##emit more information?
	else:
		return
		
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
