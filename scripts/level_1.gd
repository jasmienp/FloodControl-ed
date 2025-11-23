extends Node2D

func _on_area_2d_body_entered(body: Node2D) -> void:
	get_tree().change_scene_to_file("res://scenes/level_select_menu.tscn")
	LevelCore.lvl1_completed = true

func _ready():
	reset_timer()
	$Timer.start()
	_on_timer_timeout() 
	
var seconds = 0
var minutes = 0
var Dseconds = 30
var Dminutes = 1

func _on_timer_timeout() -> void:
	if seconds == 0:
		if minutes > 0:
			minutes -= 1
			seconds = 60		
	seconds -= 1
	$TimerLabel.text = str(minutes) + ":" + str(seconds)

func reset_timer():
	seconds = Dseconds
	minutes = Dminutes
