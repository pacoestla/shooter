extends CanvasLayer


func _on_no_pressed() -> void:
	get_tree().paused = false
	$".".hide()


func _on_yes_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/User Interface/main_title.tscn")
