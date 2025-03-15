extends Control
class_name Radio

signal drake_played

@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D
@onready var button: Button = $MarginContainer/VBoxContainer/Control/Button

func _on_button_pressed():
	button.disabled = true
	
	audio_stream_player_2d.play()

func _on_audio_stream_player_2d_finished():
	drake_played.emit()
