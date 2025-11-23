extends StaticBody2D

var dragging := false
var drag_offset := Vector2.ZERO
const GRID_SIZE := Vector2(16, 16)

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
			if not is_colliding_at(snapped):
				global_position = snapped
				last_valid_position = snapped
			else:
				# Revert to last valid spot
				global_position = last_valid_position

func _process(delta):
	if dragging:
		global_position = (get_global_mouse_position() + drag_offset).snapped(GRID_SIZE)

func is_colliding_at(position: Vector2) -> bool:
	var space_state = get_world_2d().direct_space_state
	var params = PhysicsPointQueryParameters2D.new()
	params.position = position
	params.collide_with_areas = true
	params.collide_with_bodies = true
	
	var result = space_state.intersect_point(params, 1)
	for hit in result:
		if hit.collider != self:
			return true
	return false
