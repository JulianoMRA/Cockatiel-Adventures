extends Control

@onready var btn_menu = $VBoxContainer/Menu
@onready var btn_quit = $VBoxContainer/Fechar

func _ready():
	btn_menu.pressed.connect(_on_menu_pressed)
	btn_quit.pressed.connect(_on_quit_pressed)
	get_tree().paused = true

func _on_menu_pressed():
	get_tree().paused = false
	get_tree().change_scene_to_file("res://Scenes/MainMenu.tscn")

func _on_quit_pressed():
	get_tree().paused = false
	get_tree().quit()
