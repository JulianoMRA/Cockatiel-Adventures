extends CanvasLayer

@onready var digit = $HBoxContainer/Digit1

var number_textures = []
var collected = 0
const MAX_SEEDS = 9

func _ready():
	# Carrega os números de 0 a 9
	number_textures = [
		preload("res://number0.tres"),
		preload("res://number1.tres"),
		preload("res://number2.tres"),
		preload("res://number3.tres"),
		preload("res://number4.tres"),
		preload("res://number5.tres"),
		preload("res://number6.tres"),
		preload("res://number7.tres"),
		preload("res://number8.tres"),
		preload("res://number9.tres"),
	]

	update_seed_count(0)

func update_seed_count(count: int):
	collected = clamp(count, 0, MAX_SEEDS)
	digit.texture = number_textures[collected]
