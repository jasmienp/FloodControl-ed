extends Node2D

var velocity = Vector2(-15, 15)  
var start_position = Vector2(134.215, 41.653)  
var screen_size = Vector2(1920, 1080)    

func _process(delta):
	for leaf in get_children():
		leaf.position += velocity * delta

		if leaf.position.x > screen_size.x or leaf.position.y > screen_size.y:
			leaf.position = start_position
