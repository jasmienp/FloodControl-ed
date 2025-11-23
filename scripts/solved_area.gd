extends Area2D

@export var required_block_count := 10
var filled_targets := {}

func _ready() -> void:
	print("SolvedArea ready. Required blocks =", required_block_count)

func _on_body_entered(body: Node2D) -> void:
	print("body_entered signal fired with:", body.name, "at", body.global_position)
	if body is StaticBody2D:
		var snapped_pos = body.global_position.snapped(Vector2(16,16))
		print("StaticBody2D entered. Snapped position =", snapped_pos)
		if is_in_target(snapped_pos):
			print("Block is inside a target cell:", snapped_pos)
			filled_targets[snapped_pos] = true
			check_win_condition()
		else:
			print("Block entered area but not in a target cell")

func _on_body_exited(body: Node2D) -> void:
	print("body_exited signal fired with:", body.name, "at", body.global_position)
	if body is StaticBody2D:
		var snapped_pos = body.global_position.snapped(Vector2(16,16))
		print("StaticBody2D exited. Snapped position =", snapped_pos)
		if filled_targets.has(snapped_pos):
			print("Removing block from filled_targets:", snapped_pos)
		filled_targets.erase(snapped_pos)

func is_in_target(pos: Vector2) -> bool:
	print("Checking if position is in target:", pos)
	# Loop through all CollisionShape2D children of this Area2D
	for child in get_children():
		if child is CollisionShape2D and child.shape:
			var shape = child.shape
			var xform = child.global_transform
			if shape is RectangleShape2D:
				var rect = Rect2(xform.origin - shape.extents, shape.extents * 2)
				if rect.has_point(pos):
					print("Position", pos, "is inside target rect at", rect)
					return true
	print("Position", pos, "is NOT inside any target")
	return false

func check_win_condition():
	print("Checking win condition… filled_targets =", filled_targets.size(), "/", required_block_count)
	if filled_targets.size() == required_block_count:
		print("Level Passed! Changing scene…")
		get_tree().change_scene_to_file("res://scenes/level_select_menu.tscn")
