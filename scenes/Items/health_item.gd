extends Area2D

@onready var type = 'health'

func _on_body_entered(_body: Node2D) -> void:
	if type == 'health':
		Globals.health += 10
	queue_free()		
