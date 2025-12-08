extends Node2D

@onready var animated_sprite = $AnimatedSprite2D

func _ready() -> void:
	animated_sprite.play("thought_bubble3")
	animated_sprite.connect("animation_finished", Callable(self, "_on_animation_finished"))

func _on_animation_finished() -> void:
	await get_tree().create_timer(2.0).timeout
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
