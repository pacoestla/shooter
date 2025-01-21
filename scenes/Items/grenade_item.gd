extends Area2D

@onready var type = 'grenade'
func _on_body_entered(_body: Node2D) -> void:
	if type =='grenade':
		Globals.grenade_ammount += 2
	queue_free()
