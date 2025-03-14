extends Control
class_name MosquitoSpawner

signal spawn_mosquito

func _on_button_pressed():
	spawn_mosquito.emit()
