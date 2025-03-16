extends Control
class_name PreEnd

@onready var timer = $Timer
@onready var printing_timer = $PrintingTimer
@onready var container = $Panel/VBoxContainer
@onready var arrow = $Panel/Arrow
@onready var text_label = $Panel/VBoxContainer/MarginContainer/Panel/MarginContainer/TextLabel
@onready var name_label = $Panel/VBoxContainer/MarginContainer2/Panel/MarginContainer/NameLabel
@onready var sprite = $Panel/VBoxContainer/MarginContainer3/Control/CharacterSprite
@onready var inner_sprite = $Panel/VBoxContainer/MarginContainer3/Control/CharacterSprite2
@onready var babash_player = $BabashPlayer
@onready var moan_player = $AudioStreamPlayer2D

var arrow_cursor = load("res://assets/sprites/cursor/cursor_default.png")
var pointer_cursor = load("res://assets/sprites/cursor/cursor_pointer.png")

var babash = preload("res://assets/sprites/babash_face.png")
var plankton = preload("res://assets/sprites/plankton.png")

var sound_playing = false

var current_text_index = -1

var current_char_index = 0

var texts = [
	{
		"character": "Babash",
		"text": "Phew, just in time babeeeey"
	},
	{
		"character": "Babash",
		"text": "..."
	},
	{
		"character": "Babash",
		"text": "Where's everyone?"
	},
	{
		"character": "Babash",
		"text": "Maybe I came too early? Lemme check..."
	},
	{
		"character": "Babash",
		"text": "..."
	},
	{
		"character": "Babash",
		"text": "......"
	},
	{
		"character": "Babash",
		"text": ".........."
	},
	{
		"character": "Babash",
		"text": "It's..."
	},
	{
		"character": "Babash",
		"text": "..."
	},
	{
		"character": "Babash",
		"text": "It's Sunday..."
	},
]

func _ready():
	Input.set_custom_mouse_cursor(arrow_cursor, Input.CURSOR_ARROW, Vector2(25, 0))
	Input.set_custom_mouse_cursor(pointer_cursor, Input.CURSOR_POINTING_HAND, Vector2(25, 0))
	
	container.hide()
	arrow.hide()
	
	timer.one_shot = true
	timer.wait_time = 1
	
	timer.start()
	
	printing_timer.wait_time = 0.02

func _on_arrow_gui_input(event):
	if event.is_action_pressed("left_click"):
		process_text()

func _on_timer_timeout():
	container.show()
	
	process_text()
	
func process_text():
	arrow.hide()
	
	current_text_index += 1
	
	if current_text_index > texts.size() - 1 || current_text_index < 0:
		var tween = get_tree().create_tween().set_parallel(true)
	
		moan_player.play()
	
		tween.tween_property(sprite, "self_modulate:a", 0, 5)
		tween.tween_property(inner_sprite, "self_modulate:a", 1, 5)
		tween.chain().tween_callback(go_to_next_text)
		return
	
	var text = texts[current_text_index]
	
	name_label.text = text["character"]
	
	sprite.texture = babash
	
	printing_timer.start()

func _on_printing_timer_timeout():
	var text = texts[current_text_index]
	
	text_label.text = text["text"].substr(0, current_char_index)
	
	current_char_index += 1
	
	if !sound_playing:
		sound_playing = true
		
		babash_player.play()
	
	if current_char_index == text["text"].length() + 1:
		printing_timer.stop()
		current_char_index = 0
		arrow.show()

func _on_babash_player_finished():
	sound_playing = false

func _on_papash_player_finished():
	sound_playing = false

func go_to_next_text():
	get_tree().change_scene_to_file("res://levels/end/end.tscn")
