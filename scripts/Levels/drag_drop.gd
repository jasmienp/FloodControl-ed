extends StaticBody2D
class_name MovableCrates

var dragging := false
var drag_offset := Vector2.ZERO
var last_valid_position := Vector2.ZERO
static var occupied_cells := {}
static var crates_locked := false

var tile_size: Vector2
var half_tile: Vector2

@export var targets_path: NodePath

@onready var blocking_tilemaps := [
	get_node("../../Tiles/Landscape"),
	get_node("../../Tiles/Animals"),
	get_node("../../Tiles/Crates"),
	get_node("../../Tiles/HouseWall"),
	get_node("../../Tiles/HouseDeco"),
	get_node("../../Tiles/HouseDeco2"),
]

func _ready():
	input_pickable = true
	set_process(true)
	last_valid_position = global_position

	var target_map := get_node_or_null("../../Tiles/Targets")
	if target_map:
		tile_size = target_map.tile_set.tile_size
	else:
		tile_size = Vector2(16,16)

	occupied_cells[global_position.snapped(tile_size)] = true

func _input_event(viewport, event, shape_idx):
	if crates_locked:
		return
		
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed:
			dragging = true
			z_index = 100
			occupied_cells.erase(global_position.snapped(tile_size))
		else:
			dragging = false
			z_index = 0

			var target_map := get_node_or_null("../../Tiles/Targets")
			if target_map == null:
				return

			var cell: Vector2i = target_map.local_to_map(get_global_mouse_position())
			var cell_origin: Vector2 = target_map.map_to_local(cell)
			var snapped_pos: Vector2 = target_map.to_global(cell_origin)

			if not is_colliding_at(snapped_pos):
				global_position = snapped_pos
				last_valid_position = snapped_pos
				occupied_cells[snapped_pos.snapped(tile_size)] = true

				var level := $"../../Tiles"
				if level.has_method("check_crate_position"):
					level.check_crate_position(cell, self)
			else:
				global_position = last_valid_position
				occupied_cells[last_valid_position.snapped(tile_size)] = true

func _process(delta):
	if dragging:
		var target_map := get_node_or_null("../../Tiles/Targets")
		if target_map == null:
			var new_pos := get_global_mouse_position().snapped(tile_size)
			global_position = new_pos
			modulate = Color(1, 0.5, 0.5)
			return

		var cell: Vector2i = target_map.local_to_map(get_global_mouse_position())
		var cell_origin: Vector2 = target_map.map_to_local(cell)
		var snapped_pos: Vector2 = target_map.to_global(cell_origin)

		global_position = snapped_pos
		if not is_colliding_at(snapped_pos):
			modulate = Color(1, 1, 1)
		else:
			modulate = Color(1, 0.5, 0.5)
	else:
		modulate = Color(1, 1, 1)

func is_colliding_at(position: Vector2) -> bool:
	if occupied_cells.has(position):
		return true

	for layer in blocking_tilemaps:
		var map_cell = layer.local_to_map(position)
		var source_id = layer.get_cell_source_id(map_cell)
		if source_id != -1: 
			return true

	return false
