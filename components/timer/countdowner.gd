extends Control
class_name Countdowner

signal time_out

@onready var timer: Timer = $Timer
@onready var time_text: Label = $HBoxContainer/Label2

const INITIAL_MINUTES = 1
const INITIAL_SECONDS = 0

var minutes = INITIAL_MINUTES
var seconds = INITIAL_SECONDS

func _ready():
	time_text.text = "{minutes}:{seconds}0".format({"minutes": minutes, "seconds": seconds})

func start_countdown():
	timer.one_shot = false
	timer.start()

func stop_countdown():
	timer.stop()

func reset_countdown():
	minutes = INITIAL_MINUTES
	seconds = INITIAL_SECONDS
	
	time_text.text = "{minutes}:{seconds}0".format({"minutes": minutes, "seconds": seconds})

func _on_timer_timeout():
	if seconds > 0:
		seconds -= 1
		if seconds == 0 and minutes == 0:
			timer.stop()
			time_out.emit()
	else:
		minutes -= 1
		seconds = 5

	time_text.text = "{minutes}:{seconds}0".format({"minutes": minutes, "seconds": seconds})
