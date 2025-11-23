extends AnimatedSprite2D

var isOpen := false
@onready var sprite = $AnimatedSprite2D


func open():
	sprite.play()
	isOpen = true
	
func close():
	sprite.play_backwards()
	isOpen = false
	
func _input(event):
	if Input.is_action_pressed("interact"):
		if isOpen:
			close()
		else:
			open()
			
func show_speech():
	$AnimatedSprite2D.show()
	$AnimatedSprite2D.play("new_sprite_frames")
	
