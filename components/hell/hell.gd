extends Control
class_name Hell

signal summon_sbeve

@onready var player_scary = $AudioStreamPlayer2D
@onready var player_sbeve = $AudioStreamPlayer2D2
@onready var sbeve = $VBoxContainer/Control3/Sprite2D
@onready var button_container = $VBoxContainer/MarginContainer
@onready var button = $VBoxContainer/MarginContainer/Control2/Button
@onready var explosion: AnimatedSprite2D = $VBoxContainer/Control3/AnimatedSprite2D

func _ready():
	sbeve.self_modulate.a = 0
	
	explosion.hide()
	
func _on_button_pressed():
	button_container.modulate = 0
	button.disabled = true
	
	player_scary.play()

func _on_audio_stream_player_2d_finished():
	sbeve.self_modulate.a = 1
	
	explosion.show()
	explosion.frame = 0
	explosion.play("default")
	
	player_sbeve.play()
	
	summon_sbeve.emit()
	
func _on_animated_sprite_2d_animation_finished():
	explosion.queue_free()
