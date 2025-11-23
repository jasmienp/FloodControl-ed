extends StaticBody2D

var dragging := false
var drag_offset := Vector2.ZERO
const GRID_SIZE := Vector2(32, 32)

# Store the last valid position so we can revert if overlap
var last_valid_position := Vector2.ZERO

func _ready():
	input_pickable = true
	set_process(true)
	last_valid_position = global_position

func _input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed:
			# Start drag
			dragging = true
			drag_offset = global_position - get_global_mouse_position()
			z_index = 100
		else:
			# Stop drag
			dragging = false
			z_index = 0
			var snapped = global_position.snapped(GRID_SIZE)
			
			# Check if cell is occupied
			if Occupancy.is_cell_free(snapped):
				global_position = snapped
				last_valid_position = snapped
				Occupancy.occupy(snapped, self)
			else:
				# Revert to last valid spot
				global_position = last_valid_position

func _process(delta):
	if dragging:
		global_position = (get_global_mouse_position() + drag_offset).snapped(GRID_SIZE)
