extends Node

signal stat_change

var egg_ammount = 20:
	set(value):
		egg_ammount = value
		stat_change.emit()

var grenade_ammount = 5:
	set(value):
		grenade_ammount = value
		stat_change.emit()
var player_vulnerable: bool = true
var health = 60:
	set(value):
		if value > health:
			health = min(value, 100)
		else:
			if player_vulnerable:
				player_vulnerable = false
				player_vulnerable_timer()
				health = value
		stat_change.emit()

func player_vulnerable_timer():
	await get_tree().create_timer(0.3).timeout
	player_vulnerable = true

var player_pos: Vector2
