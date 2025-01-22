extends CharacterBody2D
var vulnerable:bool = true
var active: bool = false
var max_speed: int = 600
var speed:int = 0
var speed_mult:int = 1
var health:int = 50
var explode_active:bool = false
var explode_radius:int = 200

func _ready():
	$Explosion.hide()
	$drone.show()

func _process(delta):
	if active:
		look_at(Globals.player_pos)
		var direction = (Globals.player_pos - position).normalized()
		velocity = direction * speed * speed_mult
		var collision = move_and_collide(velocity * delta)
		if collision:
			$AnimationPlayer.play("Explode")
			explode_active = true
	if explode_active:
		var targets = get_tree().get_nodes_in_group("Container") + get_tree().get_nodes_in_group('Entity')
		for target in targets:
			var in_range = target.global_position.distance_to(global_position) < 400
			if in_range and "hit" in target:
				target.hit()


func stop_movement():
	speed_mult = 0

func hit():
	if vulnerable:
		health -= 10
		$drone.material.set_shader_parameter("progress", 1)
		$VisualTimer.start()
		vulnerable = false
		$HitTimer.start()
	if health <= 0:
		$AnimationPlayer.play("Explode")
		explode_active = true

func _on_notice_area_body_entered(_body: Node2D) -> void:
	active = true
	var tween = create_tween()
	tween.tween_property(self,"speed",max_speed, 6)


func _on_hit_timer_timeout() -> void:
	vulnerable = true


func _on_visual_timer_timeout() -> void:
	$drone.material.set_shader_parameter("progress", 0)
