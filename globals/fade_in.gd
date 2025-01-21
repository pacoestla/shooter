extends CanvasLayer
func _ready():
	$ColorRect.modulate = Color(0,0,0, 0)

func change_scene(target: String) -> void:
	$AnimationPlayer.play("Noir")
	await $AnimationPlayer.animation_finished
	get_tree().change_scene_to_file(target)
	$AnimationPlayer.play_backwards("Noir")
