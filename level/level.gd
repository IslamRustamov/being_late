extends Control
class_name Level

var arrow = load("res://assets/sprites/cursor/cursor_default.png")
var pointer = load("res://assets/sprites/cursor/cursor_pointer.png")

var loss_scene: PackedScene = load("res://components/loss/loss.tscn")
var loss_node: Loss

var mosquito_scene: PackedScene = load("res://components/mosquito/mosquito.tscn")

var mosquito_spawner_scene: PackedScene = load("res://components/mosquito_spawner/mosquito_spawner.tscn")
var mosquito_spawner_node: MosquitoSpawner

@onready var bar: Bar = $Bar
@onready var countdowner: Countdowner = $Countdowner
@onready var left_eye: LeftEye = $LeftEye
@onready var right_eye: RightEye = $RightEye
@onready var mosquito_counter_timer: Timer = $MosquitoCounterTimer
@onready var mosquito_button_spawner_timer: Timer = $MosquitoButtonSpawnerTimer

var store = Store.new()

func _ready():
	Input.set_custom_mouse_cursor(arrow, Input.CURSOR_ARROW, Vector2(50, 0))
	Input.set_custom_mouse_cursor(pointer, Input.CURSOR_POINTING_HAND, Vector2(50, 0))
	
	mosquito_counter_timer.wait_time = 0.2
	mosquito_button_spawner_timer.wait_time = [6, 9].pick_random()
	
	countdowner.start_countdown()
	left_eye.start_timer()
	right_eye.start_timer()
	
	mosquito_counter_timer.start()
	mosquito_button_spawner_timer.start()

func _on_panel_gui_input(event):
	if event.is_action_pressed("left_click"):
		bar.add_progress(randi_range(1, 10))

func _on_bar_bar_filled():
	countdowner.stop_countdown()
	
	left_eye.stop_timer()
	right_eye.stop_timer()
	mosquito_counter_timer.stop()
	mosquito_button_spawner_timer.stop()

func _on_countdowner_time_out():
	store.set_state(store.GAME_STATE.LOSS)
	
	loss_node = loss_scene.instantiate()
	
	loss_node.connect("restart", _on_restart)
	
	add_child(loss_node)
	
	left_eye.stop_timer()
	right_eye.stop_timer()
	mosquito_counter_timer.stop()
	mosquito_button_spawner_timer.stop()
	
func _on_restart():
	loss_node.queue_free()
	
	countdowner.reset_countdown()
	countdowner.start_countdown()
	
	bar.reset_progress()

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
