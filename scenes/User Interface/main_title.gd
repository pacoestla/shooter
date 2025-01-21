extends Control



func _on_play_button_pressed() -> void:
	TransitionLOL.change_scene("res://scenes/levels/outside.tscn")


func _on_quit_button_pressed() -> void:
	get_tree().quit()


func _on_story_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/User Interface/info.tscn")
