extends Label

var flicker_active = false

func _ready():
	visible = false

func _start_flicker() -> void:
	visible = true
	flicker_active = true
	_do_flicker()

	await get_tree().create_timer(3.0).timeout
	flicker_active = false
	modulate.a = 1.0
	visible = false

func _do_flicker():
	if not flicker_active:
		return

	var tween = create_tween()
	tween.tween_property(self, "modulate:a", 0.0, 0.9)
	tween.tween_property(self, "modulate:a", 1.0, 0.9)
	tween.finished.connect(_do_flicker)
