extends Node2D

var Health = preload("res://scenes/Items/health_item.tscn")
var Egg = preload("res://scenes/Items/egg_item.tscn")
var Grenade = preload('res://scenes/Items/grenade_item.tscn')

var direction : Vector2
var distance : int = randi_range(300,350)

var available_options = ['health', 'laser','laser','laser','laser', 'grenade']
var type = available_options[randi()%len(available_options)]

func _ready():
	if type == 'health':
		spawnHealth()
	if type == 'laser':
		spawnEggAmmo()
	if type == 'grenade':
			spawnGrenadeAmmo()


	var target_pos = position + direction * distance
	var tween = create_tween()
	tween.set_parallel(true)
	tween.tween_property(self,"position",target_pos,0.5)
	tween.tween_property(self,"scale",Vector2(1,1), 0.3).from(Vector2(0,0))
func spawnHealth():
	var obj = Health.instantiate()
	add_child(obj)

func spawnEggAmmo():
	var obj2 = Egg.instantiate()
	add_child(obj2)

func spawnGrenadeAmmo():
	var obj3 = Grenade.instantiate()
	add_child(obj3)
