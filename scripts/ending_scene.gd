extends Node2D

@onready var animated_sprite = $AnimatedSprite2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	animated_sprite.play("thought_bubble2")


func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/letter_2.tscn")


func _on_animated_sprite_2d_animation_finished() -> void:
	$"Mail Button/Button".show()
