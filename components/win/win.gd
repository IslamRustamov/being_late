extends Control
class_name Win

@onready var explosion = $AnimatedSprite2D
@onready var player = $AudioStreamPlayer2D
@onready var timer = $Timer

var explosions = []

func _ready():
	timer.one_shot = true
	
	timer.wait_time = 3
	
	timer.start()
	
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
	
func _on_animation_finish():
	for explosion_node in explosions:
		explosion_node.queue_free()


func _on_timer_timeout():
	get_tree().change_scene_to_file("res://levels/pre_end/pre_end.tscn")
