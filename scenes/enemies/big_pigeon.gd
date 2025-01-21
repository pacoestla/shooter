extends CharacterBody2D
var active: bool = true
var speed: int = 300
var vulnerable: bool = true
var player_nearby: bool = false

var health = 50

func _process(_delta):
	var direction = (Globals.player_pos - position).normalized()
	velocity = direction * speed
	if active:
		move_and_slide()
		look_at(Globals.player_pos)

func hit():
	if vulnerable:
		vulnerable = false
		$Timers/Hit.start()
		health -= 10
		$AnimatedSprite2D.material.set_shader_parameter("progress", 0.9)
		$Particles/HitParticles.emitting = true
		$"Timers/Visibility timer".start()
	if health <= 0:
		await get_tree().create_timer(0.35).timeout
		queue_free()
		


func _on_notice_area_body_entered(_body: Node2D) -> void:
	active = true
	$AnimatedSprite2D.play("walk")

func _on_attack_area_body_entered(_body: Node2D) -> void:
	player_nearby = true
	$AnimatedSprite2D.play("attack")

func _on_attack_area_body_exited(_body: Node2D) -> void:
	player_nearby = false


func _on_notice_area_body_exited(_body: Node2D) -> void:
	active = false
	$AnimatedSprite2D.stop()

func _on_animated_sprite_2d_animation_finished() -> void:
	if player_nearby:
		Globals.health -= 10
		$Timers/Attack.start()

func _on_hit_timeout() -> void:
	vulnerable = true


func _on_attack_timeout() -> void:
	$AnimatedSprite2D.play("attack")


func _on_visibility_timer_timeout() -> void:
	$AnimatedSprite2D.material.set_shader_parameter("progress",0)
