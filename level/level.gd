extends Control
class_name Level

var arrow = load("res://assets/sprites/cursor/cursor_default.png")
var pointer = load("res://assets/sprites/cursor/cursor_pointer.png")

var loss_scene: PackedScene = load("res://components/loss/loss.tscn")
var loss: Loss

@onready var bar: Bar = $Bar
@onready var countdowner: Countdowner = $Countdowner

var store = Store.new()

func _ready():
	Input.set_custom_mouse_cursor(arrow, Input.CURSOR_ARROW, Vector2(50, 0))
	Input.set_custom_mouse_cursor(pointer, Input.CURSOR_POINTING_HAND, Vector2(50, 0))
	
	countdowner.start_countdown()

func _on_panel_gui_input(event):
	if event.is_action_pressed("left_click"):
		bar.add_progress(randi_range(1, 10))

func _on_bar_bar_filled():
	print("you won")

func _on_countdowner_time_out():
	store.set_state(store.GAME_STATE.LOSS)
	
	loss = loss_scene.instantiate()
	
	loss.connect("restart", _on_restart)
	
	add_child(loss)
	
func _on_restart():
	loss.queue_free()
	
	countdowner.reset_countdown()
	countdowner.start_countdown()
	
	bar.reset_progress()
