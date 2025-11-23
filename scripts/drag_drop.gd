extends StaticBody2D

var dragging := false
var drag_offset := Vector2.ZERO
const GRID_SIZE := Vector2(8, 8)  # Adjust to your grid cell size
const GRID_SIZE := Vector2(32, 32)  # Adjust to your grid cell size

func _ready():
	input_pickable = true
	set_process(true)

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
			# Snap to grid when released
			global_position = global_position.snapped(GRID_SIZE)

func _process(delta):
	if dragging:
		global_position = (get_global_mouse_position() + drag_offset).snapped(GRID_SIZE)
