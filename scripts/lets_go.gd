extends Node2D

@onready var lg = $AnimatedSprite2D

# Called when the node enters the scene tree for the first time.
func _ready():
	lg.play("lets_go")
