extends Control
class_name Loss

signal restart

@onready var player_one = $AudioStreamPlayer2D
@onready var player_two = $AudioStreamPlayer2D2

func _ready():
	player_one.play()
	player_two.play()

func _on_button_pressed():
	restart.emit()
