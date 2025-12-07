extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var anim_sprite = $Background
	anim_sprite.play("background")


func _on_start_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/EPILOGUE.tscn")

func _on_settings_pressed() -> void:
	print("Settings Pressed")


func _on_exit_pressed() -> void:
	get_tree().quit()
