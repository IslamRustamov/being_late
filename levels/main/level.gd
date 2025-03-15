extends Control
class_name Level

var arrow = load("res://assets/sprites/cursor/cursor_default.png")
var pointer = load("res://assets/sprites/cursor/cursor_pointer.png")

var loss_scene: PackedScene = load("res://components/loss/loss.tscn")
var loss_node: Loss

var mosquito_scene: PackedScene = load("res://components/mosquito/mosquito.tscn")

var mosquito_spawner_scene: PackedScene = load("res://components/mosquito_spawner/mosquito_spawner.tscn")
var mosquito_spawner_node: MosquitoSpawner

var can_of_peas_scene: PackedScene = load("res://components/can_of_peas/can_of_peas.tscn")
var can_of_peas_node: CanOfPeas

var radio_scene: PackedScene = load("res://components/radio/radio.tscn")
var radio_node: Radio

var hell_scene: PackedScene = load("res://components/hell/hell.tscn")
var hell_node: Hell

var win_scene: PackedScene = load("res://components/win/win.tscn")
var win_node: Win

@onready var bar: Bar = $Bar
@onready var countdowner: Countdowner = $Countdowner
@onready var left_eye: LeftEye = $LeftEye
@onready var right_eye: RightEye = $RightEye
@onready var mosquito_counter_timer: Timer = $MosquitoCounterTimer
@onready var mosquito_button_spawner_timer: Timer = $MosquitoButtonSpawnerTimer
@onready var can_of_peas_timer: Timer = $CanOfPeasTimer
@onready var babash: Babash = $Babash
@onready var babash_peas_timer: Timer = $BabashPeasTimer
@onready var radio_appearance_timer: Timer = $RadioAppearanceTimer
@onready var babash_angry_timer: Timer = $BabashAngryTimer
@onready var hell_timer: Timer = $HellTimer
@onready var main_theme_player: AudioStreamPlayer2D = $AudioStreamPlayer2D

var store = Store.new()

func _ready():
	Input.set_custom_mouse_cursor(arrow, Input.CURSOR_ARROW, Vector2(25, 0))
	Input.set_custom_mouse_cursor(pointer, Input.CURSOR_POINTING_HAND, Vector2(25, 0))
	
	mosquito_counter_timer.wait_time = 0.2

	mosquito_button_spawner_timer.wait_time = [6, 9].pick_random()
	
	can_of_peas_timer.wait_time = 15
	can_of_peas_timer.one_shot = true
	
	babash_peas_timer.wait_time = 2
	babash_peas_timer.one_shot = true
	
	radio_appearance_timer.wait_time = 30
	radio_appearance_timer.one_shot = true
	
	babash_angry_timer.wait_time = 0.2
	babash_angry_timer.one_shot = true
	
	hell_timer.wait_time = 45
	hell_timer.one_shot = true
	
	start_all_timers()
	
	main_theme_player.play()
	
func start_all_timers():
	countdowner.start_countdown()
	left_eye.start_timer()
	right_eye.start_timer()
	
	mosquito_counter_timer.start()
	mosquito_button_spawner_timer.start()
	can_of_peas_timer.start()
	radio_appearance_timer.start()
	hell_timer.start()

func stop_all_timers():
	countdowner.stop_countdown()
	
	left_eye.stop_timer()
	right_eye.stop_timer()
	mosquito_counter_timer.stop()
	mosquito_button_spawner_timer.stop()
	can_of_peas_timer.stop()
	radio_appearance_timer.stop()
	hell_timer.stop()

func _on_panel_gui_input(event):
	if event.is_action_pressed("left_click"):
		bar.add_progress(randi_range(1, 10))

func _on_bar_bar_filled():
	stop_all_timers()
	
	win_node = win_scene.instantiate()
	
	win_node.connect("restart", _on_restart)
	
	add_child(win_node)

func _on_countdowner_time_out():
	store.set_state(store.GAME_STATE.LOSS)
	
	loss_node = loss_scene.instantiate()
	
	loss_node.connect("restart", _on_restart)
	
	add_child(loss_node)
	
	stop_all_timers()
	
func _on_restart():
	get_tree().reload_current_scene()

func _on_left_eye_left_eye_clicked():
	bar.add_progress(randf_range(0, 0.5))

func _on_right_eye_right_eye_clicked():
	bar.add_progress(randf_range(0, 0.5))

func _on_mosquito_timer_timeout():
	bar.add_progress(get_tree().get_nodes_in_group("mosquitos").size() * 0.05)

func _on_mosquito_button_spawner_timer_timeout():
	if mosquito_spawner_node != null:
		return
	
	mosquito_spawner_node = mosquito_spawner_scene.instantiate()
	
	mosquito_spawner_node.connect("spawn_mosquito", _spawn_mosquito)
	
	add_child(mosquito_spawner_node)
	
	mosquito_button_spawner_timer.stop()

func _spawn_mosquito():
	mosquito_spawner_node.queue_free()
	mosquito_spawner_node = null
	
	var mosquito_node = mosquito_scene.instantiate()
	
	add_child(mosquito_node)
	
	mosquito_button_spawner_timer.wait_time = [6, 12].pick_random()
	mosquito_button_spawner_timer.start()

func _on_can_of_peas_timer_timeout():
	can_of_peas_node = can_of_peas_scene.instantiate()
	
	can_of_peas_node.connect("throw_can_of_peas", _throw_can_of_peas)
	
	add_child(can_of_peas_node)

func _throw_can_of_peas():
	left_eye.hide()
	right_eye.hide()
	
	babash.show_peas()
	babash_peas_timer.start()
	
	bar.add_progress(5)

func _on_babash_peas_timer_timeout():
	babash.show_default()
	
	left_eye.show()
	right_eye.show()

func _on_radio_appearance_timer_timeout():
	radio_node = radio_scene.instantiate()
	
	radio_node.connect("drake_played", _drake_played)
	
	add_child(radio_node)
	
func _drake_played():
	left_eye.hide()
	right_eye.hide()
	
	babash.show_angry()
	babash_angry_timer.start()
	
	bar.add_progress(5)

func _on_babash_angry_timer_timeout():
	babash.show_default()
	
	left_eye.show()
	right_eye.show()

func _on_nipple_nipple_pressed():
	bar.add_progress(0.2)

func _on_hell_timer_timeout():
	hell_node = hell_scene.instantiate()
	
	hell_node.connect("summon_sbeve", _summon_sbeve)
	
	add_child(hell_node)

func _summon_sbeve():
	bar.add_progress(5)
