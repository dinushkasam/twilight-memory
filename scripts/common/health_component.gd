extends Node
class_name HealthComponent


var current_health: int

signal did_damage(amount: int)


func do_damage(damage: int):
	current_health -= damage
	did_damage.emit(damage)

func heal(amount: int):
	current_health += amount

func is_dead() -> bool:
	return true if current_health <= 0 else false
