extends Node2D
class_name Mosquito

const SPEED = 1500

@onready var timer = $Timer
@onready var sprite = $Sprite2D
@onready var animated_sprite = $AnimatedSprite2D
@onready var player = $AudioStreamPlayer2D
@onready var player_explosion = $AudioStreamPlayer2D2

var mosquito_sound_one = preload("res://assets/sounds/mosquito.mp3")
var mosquito_sound_two = preload("res://assets/sounds/mosquito_2.mp3")

var state = "alive"
var life_time: int = randi_range(5, 10)
var next_position: Vector2 = Vector2(randi_range(100, 1800), randi_range(110, 1800))

func _ready():
	position = Vector2(randi_range(100, 1800), randi_range(110, 1800))

	timer.wait_time = life_time
	
	animated_sprite.hide()
	animated_sprite.pause()
	
	timer.start()
	
	player.stream = [mosquito_sound_one, mosquito_sound_two].pick_random()
	
	player.volume_db = -10
	
	player.play()

func _process(delta):
	if state != "alive":
		return

	position += position.direction_to(next_position) * SPEED * delta
	
	if position.distance_to(next_position) < 50:
		next_position = Vector2(randi_range(100, 1800), randi_range(110, 1800))

func _on_timer_timeout():
	sprite.hide()

	player.stop()
	
	state = "dead"
	
	animated_sprite.show()
	animated_sprite.play("default")
	
	player_explosion.play()
	
func _on_animated_sprite_2d_animation_finished():
	queue_free()
