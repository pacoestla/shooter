extends ItemContainer

func hit():
	if not opened:
		#$LidSprite.hide()			
		for i in range(5):
			var pos = $"Spawn Positions".get_child(randi()%$"Spawn Positions".get_child_count()).global_position
			open.emit(pos, current_direction)
		opened = true
