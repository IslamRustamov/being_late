extends Control
class_name Intro

@onready var timer = $Timer
@onready var printing_timer = $PrintingTimer
@onready var container = $Panel/VBoxContainer
@onready var arrow = $Panel/Arrow
@onready var text_label = $Panel/VBoxContainer/MarginContainer/Panel/MarginContainer/TextLabel
@onready var name_label = $Panel/VBoxContainer/MarginContainer2/Panel/MarginContainer/NameLabel
@onready var sprite = $Panel/VBoxContainer/MarginContainer3/Control/CharacterSprite
@onready var papash_player = $PapashPlayer
@onready var babash_player = $BabashPlayer

var arrow_cursor = load("res://assets/sprites/cursor/cursor_default.png")
var pointer_cursor = load("res://assets/sprites/cursor/cursor_pointer.png")

var babash = preload("res://assets/sprites/babash_face.png")
var papash = preload("res://assets/sprites/papash_face.png")

var sound_playing = false

var current_text_index = -1

var current_char_index = 0

var texts = [
	{
		"character": "Babash",
		"text": "I've been having troubles sleeping for quite some time now..."
	},
	{
		"character": "Babash",
		"text": "It all started when my father and I encountered a bear in the forest"
	},
	{
		"character": "Babash",
		"text": "I will never forget his last words..."
	},
	{
		"character": "Papash",
		"text": "Don't worry, son, I've played Baldur's Gate"
	},
	{
		"character": "Papash",
		"text": "I know how to *licks his lips* tame this beast"
	},
	{
		"character": "Babash",
		"text": "Needless to say my father got baldursgated by that bear"
	},
	{
		"character": "Babash",
		"text": "Nevermind, I've been skipping classes because I can't wake up like a normal person"
	},
	{
		"character": "Babash",
		"text": "The worst part is that I am THE TEACHER"
	},
	{
		"character": "Babash",
		"text": "If I skip one more class like that, I'm definitely going to get the ass beating of my life"
	},
	{
		"character": "Babash",
		"text": "If only there was SOMEONE who could CLICK on my EYES and NIPPLES and do whatever the bullshit possible to wake me up..."
	},
	{
		"character": "Babash",
		"text": "Okay, here we go"
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
		get_tree().change_scene_to_file("res://levels/main/level.tscn")
		return
	
	var text = texts[current_text_index]
	
	name_label.text = text["character"]
	
	if  text["character"] == "Babash":
		sprite.texture = babash
	else:
		sprite.texture = papash
	
	printing_timer.start()

func _on_printing_timer_timeout():
	var text = texts[current_text_index]
	
	text_label.text = text["text"].substr(0, current_char_index)
	
	current_char_index += 1
	
	if !sound_playing:
		sound_playing = true
		
		if text["character"] == "Babash":
			babash_player.play()
		else:
			papash_player.play()
	
	if current_char_index == text["text"].length() + 1:
		printing_timer.stop()
		current_char_index = 0
		arrow.show()

func _on_babash_player_finished():
	sound_playing = false

func _on_papash_player_finished():
	sound_playing = false
