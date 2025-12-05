extends Camera2D

func _ready():
	if enabled and is_inside_tree():
		make_current()
	else:
		await get_tree().process_frame
		if enabled and is_inside_tree():
			make_current()
