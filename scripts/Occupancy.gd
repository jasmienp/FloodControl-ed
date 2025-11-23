extends Node

var occupied := {}

func is_cell_free(cell: Vector2) -> bool:
	return not occupied.has(cell)

func occupy(cell: Vector2, block: Node) -> void:
	occupied[cell] = block

func free_cell(cell: Vector2) -> void:
	occupied.erase(cell)
