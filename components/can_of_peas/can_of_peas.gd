extends Control
class_name CanOfPeas

signal throw_can_of_peas

@onready var button_control = $MarginContainer/VBoxContainer/Control
@onready var button = $MarginContainer/VBoxContainer/Control/Button
@onready var sprite = $MarginContainer/VBoxContainer/Control2/Sprite2D
@onready var player = $AudioStreamPlayer2D

var can_of_peas_opened = preload("res://assets/sprites/can_of_peas/can_of_peas_opened.png")

func _on_button_pressed():
	throw_can_of_peas.emit()
	
	button_control.modulate = 0

	button.hide()
	
	sprite.texture = can_of_peas_opened
	
	sprite.rotation -= 5
	
	player.play()
	
