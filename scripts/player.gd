extends CharacterBody2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer
var walk_animation_template := "walk_%s"
var speed := 100


func _physics_process(_delta: float) -> void:
	# Movement input
	var dir := Input.get_vector("move_left", "move_right", "move_up", "move_down")

	# Try pushing a block if moving
	if dir != Vector2.ZERO:
		try_push_block(dir)

	# Move the player
	velocity = dir * speed
	move_and_slide()

	# Handle animations
	if Input.is_action_pressed("move_up"):
		animation_player.play(walk_animation_template % "up")
	elif Input.is_action_pressed("move_down"):
		animation_player.play(walk_animation_template % "down")
	elif Input.is_action_pressed("move_left"):
		animation_player.play(walk_animation_template % "left")
	elif Input.is_action_pressed("move_right"):
		animation_player.play(walk_animation_template % "right")
	else:
		animation_player.stop()


func try_push_block(dir: Vector2) -> void:
	var space_state = get_world_2d().direct_space_state
	var query = PhysicsRayQueryParameters2D.new()
	query.from = global_position
	query.to = global_position + dir.normalized() * 32  # distance to reach block
	query.exclude = [self]
	query.collision_mask = 1 << 2  # must match block layer

	var result = space_state.intersect_ray(query)

	if result and result["collider"].is_in_group("block"):
		result["collider"].push(dir)
		
		
		
