extends Area2D

@onready var type = 'egg'

func _on_body_entered(_body: Node2D) -> void:
	if type == 'egg':
		Globals.egg_ammount += 5
	queue_free()
