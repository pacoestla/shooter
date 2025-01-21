extends CharacterBody2D
var player_nearby: bool = false
var can_bullet: bool = true
var prime_gun_use: bool =		 true
var health: int = 30
var vulnerable: bool = true
signal bullet(pos, direction)

func hit():
	if vulnerable:
		health -= 10
		vulnerable = false
		$Invicible.start()
		$Invicible_visual.start()
		$Sprite2D.material.set_shader_parameter("progress", 1)
	if health <= 0:
		queue_free()


func _process(_delta):

	if player_nearby:
		look_at(Globals.player_pos)
		if can_bullet:
			var marker_node = $BulletSpawnPositions.get_child(prime_gun_use)
			prime_gun_use = not prime_gun_use
			var pos: Vector2 = marker_node.global_position
			var direction: Vector2 = (Globals.player_pos - position).normalized()
			bullet.emit(pos, direction)
			can_bullet = false
			$BulletCooldown.start()

func _on_attack_area_body_entered(_body: Node2D) -> void:
	player_nearby = true


func _on_attack_area_body_exited(_body: Node2D) -> void:
	player_nearby = false


func _on_bullet_cooldown_timeout() -> void:
	can_bullet = true


func _on_invicible_timeout() -> void:
	vulnerable = true
	#$Sprite2D.material.set_shader_parameter("progress", 0)


func _on_invicible_visual_timeout() -> void:
	$Sprite2D.material.set_shader_parameter("progress", 0)
