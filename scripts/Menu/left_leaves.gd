extends Node2D

var velocity = Vector2(-5, 10)   
var screen_size = Vector2(1920, 1080)
var start_positions = {}         

func _ready():
	# Record each leaf’s starting position
	for leaf in get_children():
		start_positions[leaf] = leaf.position

func _process(delta):
	# Move all leaves together
	for leaf in get_children():
		leaf.position += velocity * delta

	# If ANY leaf goes off-screen, reset ALL together
	for leaf in get_children():
		if leaf.position.x < -100 or leaf.position.y > screen_size.y + 100:
			for l in get_children():
				l.position = start_positions[l]
			break
