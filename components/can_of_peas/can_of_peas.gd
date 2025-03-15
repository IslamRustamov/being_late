extends Control
class_name CanOfPeas

signal throw_can_of_peas

func _on_button_pressed():
	throw_can_of_peas.emit()
