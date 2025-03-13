extends Control
class_name Bar

signal bar_filled

@onready var progress_bar: ProgressBar = $MarginContainer/PanelContainer/MarginContainer/ProgressBar

func reset_progress():
	progress_bar.value = 0

func add_progress(value: int):
	progress_bar.value += value

func _on_progress_bar_value_changed(value):
	if (value == 100):
		bar_filled.emit()
