extends StaticBody2D

var dragging := false
var drag_offset := Vector2.ZERO
const GRID_SIZE := Vector2(16, 16)

# Store the last valid position so we can revert if overlap
var last_valid_position := Vector2.ZERO
static var occupied_cells := {}

func _ready():
	input_pickable = true
	set_process(true)
	last_valid_position = global_position
	occupied_cells[global_position.snapped(GRID_SIZE)] = true
	
func _input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed:
			# Start drag
			dragging = true
			drag_offset = global_position - get_global_mouse_position()
			z_index = 100
			occupied_cells.erase(global_position.snapped(GRID_SIZE))
		else:
			# Stop drag
			dragging = false
			z_index = 0
			var snapped = global_position.snapped(GRID_SIZE)
			
			# Check if cell is occupied
			if not is_colliding_at(snapped):
				global_position = snapped
				last_valid_position = snapped
				occupied_cells[snapped] = true
			else:
				# Revert to last valid spot
				global_position = last_valid_position
				occupied_cells[last_valid_position] = true

func _process(delta):
	if dragging:
		var new_pos = (get_global_mouse_position() + drag_offset).snapped(GRID_SIZE)
		if not is_colliding_at(new_pos):
			modulate = Color(1, 1, 1)
			global_position = new_pos
		else:
			modulate = Color(1, 0.5, 0.5)
			global_position = new_pos
	else:
		modulate = Color(1, 1, 1)

func is_colliding_at(position: Vector2) -> bool:
	return occupied_cells.has(position)
