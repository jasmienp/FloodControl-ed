extends Node2D

@onready var target_map = $Targets
var target_cells: Array = []
var filled_cells := {}
var all_filled: bool = false

func _ready():
	target_cells = target_map.get_used_cells()

func check_crate_position(cell: Vector2i, crate: Node):
	if cell in target_cells:
		filled_cells[cell] = crate
	else:
		filled_cells.erase(cell)

	var all_filled = true
	for target in target_cells:
		if not filled_cells.has(target):
			all_filled = false
			break

	if all_filled:
		$"../Timer".stop()
		await $"../Warning"._start_flicker()
		$"..".flood_success.visible = true
		await $"../FloodSuccess".start_flood_sequence_with_delay()
		level_finished()		


func level_finished():
	if LevelCore.current_level == "lvl1":
		LevelCore.lvl1_completed = true
	elif LevelCore.current_level == "lvl2":
		LevelCore.lvl2_completed = true
	else:
		LevelCore.lvl3_completed = true

	get_tree().change_scene_to_file("res://scenes/level_select_menu.tscn")
