extends Area2D

var is_open: bool = false
var player_near: bool = false

@onready var chest_sprite: AnimatedSprite2D = $AnimatedSprite2D


func _ready() -> void:
	chest_sprite.play("closed")  # make sure you have an animation called "closed"
	print("Chest ready.")


func _process(delta: float) -> void:
	# Check for interact key press every frame
	if player_near and Input.is_action_just_pressed("interact"):
		if not is_open:
			_open()
		else:
			_close()


func _on_body_entered(body: Node) -> void:
	print("Body entered:", body.name)
	if body.is_in_group("player") or body.name == "Player":
		player_near = true
		print("Player is near chest.")


func _on_body_exited(body: Node) -> void:
	print("Body exited:", body.name)
	if body.is_in_group("player") or body.name == "Player":
		player_near = false
		print("Player left chest area.")


func _open() -> void:
	is_open = true
	chest_sprite.play("open")
	print(name + " opened.")


func _close() -> void:
	is_open = false
	chest_sprite.play("closed")
	print(name + " closed.")
