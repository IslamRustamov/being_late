extends Node2D
class_name Nipple

signal nipple_pressed

@onready var sprite = $Control/Sprite2D
@onready var timer = $Timer
@onready var player = $AudioStreamPlayer2D

func _ready():
	timer.wait_time = 0.1
	
	timer.one_shot = true

func _on_control_gui_input(event):
	if event.is_action_pressed("left_click"):
		player.play()
		
		nipple_pressed.emit()
		
		sprite.scale.y = [2, 3].pick_random()
		sprite.skew = [-30, 30, -60, 60].pick_random()
		
		timer.start()
		
func _on_timer_timeout():
	sprite.scale.y = 1
	sprite.skew = 0
