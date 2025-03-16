extends Control
class_name End

@onready var player = $AudioStreamPlayer2D
@onready var label = $Panel/Label
@onready var timer = $Timer

var texts = [
	"Game by:\nIslam Rustamov\nPerseus the Cat",
	"Special thanks for testing:\nDashechka\namicabledisaster\nmrjajakes\nReyDahlia",
	"Onorable menciones",
	"Numero uno",
	"well420\n(because he is\nfrom Philippines :fire_emoji:)",
	"the end :3c"
]

var current_text_index = 0

func _ready():
	timer.one_shot = true
	
	timer.wait_time = 3
	
	
	player.play()
	
	label.text = texts[current_text_index]
	
	var tween = get_tree().create_tween()
	
	tween.tween_property(label, "self_modulate:a", 1, 2)
	tween.tween_interval(2)
	tween.chain().tween_property(label, "self_modulate:a", 0, 2)
	tween.tween_callback(go_to_next_text)

	tween.play()

func go_to_next_text():
	current_text_index += 1
	
	if current_text_index > texts.size() - 1:
		timer.start()
		return
	
	label.text = texts[current_text_index]

	var tween = get_tree().create_tween()
	
	tween.tween_property(label, "self_modulate:a", 1, 2)
	tween.tween_interval(2)
	tween.chain().tween_property(label, "self_modulate:a", 0, 2)
	tween.tween_callback(go_to_next_text)

	tween.play()

func _on_timer_timeout():
	get_tree().change_scene_to_file("res://levels/intro/intro.tscn")
