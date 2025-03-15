extends Control
class_name Win

signal restart

@onready var explosion = $AnimatedSprite2D
@onready var player = $AudioStreamPlayer2D

var explosions = []

func _ready():
	explosion.position = Vector2(randi_range(400, 1400), randi_range(400, 1400))
	
	explosions.push_back(explosion)

	for i in 10:
		var new_explosion = explosion.duplicate()
		
		new_explosion.position = Vector2(randi_range(400, 1400), randi_range(400, 1400))
		
		add_child(new_explosion)

		explosions.push_back(new_explosion)
		
		new_explosion.play("default")

		player.play()
	
	explosion.play()

	explosion.connect("animation_finished", _on_animation_finish)

func _on_button_pressed():
	restart.emit()

	
func _on_animation_finish():
	for explosion_node in explosions:
		explosion_node.queue_free()
