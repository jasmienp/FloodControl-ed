extends Node2D

@onready var flood_variations = [
	$f1,
	$f2,
	$f3,
	$f4
]

func _ready():
	for f in flood_variations:
		f.visible = false

func start_flood_sequence_with_delay() -> void:
	await get_tree().create_timer(1.0).timeout
	await show_flood_with_delay(0, 1.0)
	await show_flood_with_delay(1, 1.0)
	await show_flood_with_delay(2, 1.0)
	await show_flood_with_delay(3, 1.0)

func show_flood_with_delay(index: int, delay: float) -> void:
	for f in flood_variations:
		f.visible = false

	if index >= 0 and index < flood_variations.size():
		flood_variations[index].visible = true

	await get_tree().create_timer(delay).timeout
