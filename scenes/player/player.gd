extends CharacterBody2D
class_name Player
signal laser(pos, direction)
signal grenade(pos, direction)
var can_laser: bool = true
var can_grenade: bool = true

@export var max_speed: int = 700
var speed: int = max_speed

func hit():
	Globals.health -= 10		

func _process(_delta):	
	#To get the player movement
	var direction = Input.get_vector("left","right","up","down")
	velocity = direction * speed
	move_and_slide()
	Globals.player_pos = global_position
	
	#rotate player to mouse
	look_at(get_global_mouse_position())
	
	#to make the gun shoot
	var player_direction = (get_global_mouse_position() - position).normalized()
	if Input.is_action_just_pressed("primary action") and can_laser and Globals.egg_ammount > 0 :
		Globals.egg_ammount -= 1
		$GPUParticles2D.emitting = true
		#Choisit un marked 2D random pour tirer le laser
		var laser_markers = $LaserStartPositions.get_children()
		var selected_laser = laser_markers[randi() % laser_markers.size()]
		can_laser = false
		$Timer.start()
		
		#emit the position so its received on level
		laser.emit(selected_laser.global_position, player_direction)
	
	if Input.is_action_just_pressed("secondary action") and can_grenade and Globals.grenade_ammount > 0:
		Globals.grenade_ammount -= 1
		var grenade_markers = $GrenadePosition.get_children()
		var selected_grenade = grenade_markers[randi() % grenade_markers.size()]
		can_grenade = false
		$GrenadeReloadTimer.start()
		grenade.emit(selected_grenade.global_position, player_direction)
func _on_timer_timeout() -> void:
	can_laser = true

func _on_grenade_reload_timer_timeout() -> void:
	can_grenade = true
