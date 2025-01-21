extends RigidBody2D

const speed = 500
var explode_active: bool = false
var explosion_radius: int = 300
func explode():
	$AnimationPlayer.play("Explosion")
	explode_active = true
	

func _process(_delta):
	if explode_active:
		var targets = get_tree().get_nodes_in_group("Container") + get_tree().get_nodes_in_group('Entity')
		for target in targets:
			var in_range = target.global_position.distance_to(global_position) < explosion_radius
			if 'hit' in target and in_range:
				target.hit()
	
