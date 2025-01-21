extends Node
class_name LevelParent

var bullet_scene: PackedScene = preload("res://scenes/projectiles/bullet.tscn")
var laser_scene: PackedScene = preload("res://scenes/projectiles/laser.tscn")
var grenade_scene : PackedScene = preload("res://scenes/projectiles/grenade.tscn")
var item_scene: PackedScene = preload("res://scenes/Items/item.tscn")
var choice: PackedScene = preload("res://scenes/User Interface/choice_quit.tscn")
func _ready():
	for container in get_tree().get_nodes_in_group('Container'):
		container.connect("open", _on_container_opened)
	for pigeon in get_tree().get_nodes_in_group("Pigeons"):
		pigeon.connect('bullet', _on_pigeon_bullet)

func _on_container_opened(pos, direction): 
	var item = item_scene.instantiate()
	item.position = pos
	item.direction = direction
	$Items.call_deferred('add_child',item)

func _on_pigeon_bullet(pos, direction):
	create_bullet(pos, direction)

func create_bullet(pos, direction):
	var bullet = bullet_scene.instantiate() as Area2D
	bullet.position = pos
	bullet.rotation_degrees = rad_to_deg(direction.angle()) + 90
	bullet.direction = direction
	$Projectiles.add_child(bullet)

func _on_player_laser(pos: Variant, direction: Variant) -> void:
	create_laser(pos,direction)
	
func create_laser(pos,direction):
	#Amene la scene dans level quand on clique
	var laser = laser_scene.instantiate() as Area2D
	#Changer la position en fonction du joueur
	laser.position = pos
	laser.rotation_degrees = 	rad_to_deg(direction.angle()) + 90
	laser.direction = direction
	$Projectiles.add_child(laser)


func _on_player_grenade(pos: Variant, direction: Variant) -> void:
	var grenade = grenade_scene.instantiate() as RigidBody2D
	grenade.position = pos
	grenade.linear_velocity = direction * grenade.speed
	$Projectiles.add_child(grenade) 
	
func _process(_delta):
	if Input.is_action_pressed('Quit'):
		$"choice quit".show()
		get_tree().paused = true
		
