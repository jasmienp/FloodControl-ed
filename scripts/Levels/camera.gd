extends Node2D

func _ready():
	var cam = Camera2D.new()
	cam.make_current()  
	add_child(cam)
