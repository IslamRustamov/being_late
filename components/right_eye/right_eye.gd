extends Node2D
class_name RightEye

const MAX_CLICK_COUNT = 13

signal right_eye_clicked

@onready var timer: Timer = $Timer
@onready var sprite: AnimatedSprite2D = $Control/AnimatedSprite2D

var clicked_count = 0

func _ready():
	timer.wait_time = 0.3

func stop_timer():
	timer.stop()

func start_timer():
	timer.start()

func _on_control_gui_input(event):
	if event.is_action_pressed("left_click"):
		if clicked_count < 10:
			right_eye_clicked.emit()
			
		if clicked_count < 13:
			clicked_count += 1
		
		redraw_sprite()

func _on_timer_timeout():
	if clicked_count > 0:
		clicked_count -= 1

	redraw_sprite()

func redraw_sprite():
	if clicked_count >= 10:
		sprite.frame = 2
	elif clicked_count >= 3:
		sprite.frame = 1
	else:
		sprite.frame = 0
