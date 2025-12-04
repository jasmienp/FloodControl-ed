extends Node2D


var seconds = 0
var minutes = 0
var Dseconds = 10   
var Dminutes = 0    
# Weather state
var current_weather = "none"

@onready var timer: Timer = $Timer
@onready var rain = $Rain
@onready var timer_label = $TimerLabel


@onready var flood_variations = [
	$"var 1",
	$"var 2",
	$"var 3",
	$"var 4"
]

func _ready():
	reset_timer()
	timer.start()
	timer.timeout.connect(_on_timer_timeout)

   
	if current_weather == "none":
		rain.visible = false

  
	for f in flood_variations:
		f.visible = false

func _on_timer_timeout() -> void:
	if seconds == 0:
		if minutes > 0:
			minutes -= 1
			seconds = 60
	seconds -= 1
	timer_label.text = str(minutes) + ":" + str(seconds)

   
	if minutes == 0 and seconds == 0:
		rain.visible = true
		timer.stop()  # keep timer at 0
		start_flood_sequence_with_delay()

func reset_timer():
	seconds = Dseconds
	minutes = Dminutes


func start_flood_sequence_with_delay() -> void:
	await get_tree().create_timer(3.0).timeout  
	await show_flood_with_delay(0, 3.0)  
	await show_flood_with_delay(1, 3.0)  
	await show_flood_with_delay(2, 3.0)  
	await show_flood_with_delay(3, 3.0)  

func show_flood_with_delay(index: int, delay: float) -> void:
	
	for f in flood_variations:
		f.visible = false
	
	if index >= 0 and index < flood_variations.size():
		flood_variations[index].visible = true

	await get_tree().create_timer(delay).timeout
