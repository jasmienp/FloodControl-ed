extends Node2D

var seconds = 0
var minutes = 0
var Dseconds = 30
var Dminutes = 0

@onready var timer: Timer = $Timer
@onready var timer_label: Label = $TimerLabel
@onready var warning: Label = $Warning
@onready var flood_success = $FloodSuccess
@onready var flood_fail = $FloodFail

func _ready():
	MovableCrates.occupied_cells.clear()
	MovableCrates.crates_locked = false
	var lvl = LevelCore.current_level
	Dminutes = LevelCore.level_times[lvl]["minutes"]
	Dseconds = LevelCore.level_times[lvl]["seconds"]
	reset_timer()
	timer.start()
	timer.timeout.connect(_on_timer_timeout)
	
	flood_success.visible = false
	flood_fail.visible = false

func _on_timer_timeout() -> void:
	if seconds == 0:
		if minutes > 0:
			minutes -= 1
			seconds = 60
	seconds -= 1

	timer_label.text = "%02d:%02d" % [minutes, seconds]

	if minutes == 0 and seconds == 0:
		timer.stop()
		timer_label.text = "00:00"
		
		MovableCrates.crates_locked = true
		await warning._start_flicker()
		flood_fail.visible = true
		await $FloodFail.start_flood_sequence_with_delay()
		$FloodFail.change_to_level_select_scene()

func reset_timer():
	seconds = Dseconds
	minutes = Dminutes
	MovableCrates.crates_locked = false
