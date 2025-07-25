extends Control

@onready var btn_play = $MarginContainer/VBoxContainer/Play
@onready var btn_voltar = $MarginContainer/VBoxContainer/Voltar

func _ready():
	btn_play.pressed.connect(_on_play_pressed)
	btn_voltar.pressed.connect(_on_back_pressed)

func _on_play_pressed():
	get_tree().change_scene_to_file("res://Scenes/level_1.tscn") 

func _on_back_pressed():
	get_tree().change_scene_to_file("res://Scenes/MainMenu.tscn") 
