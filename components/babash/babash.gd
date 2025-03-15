extends Control
class_name Babash

@onready var sprite = $Sprite2D

var default = preload("res://assets/sprites/babash/babash.png")
var peas = preload("res://assets/sprites/babash/babash_peas.png")
var angry = preload("res://assets/sprites/babash/babash_angry.png")

func show_default():
	sprite.texture = default

func show_peas():
	sprite.texture = peas

func show_angry():
	sprite.texture = angry
