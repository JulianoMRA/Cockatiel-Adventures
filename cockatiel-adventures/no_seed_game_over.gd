extends Control

@onready var btn_menu = $VBoxContainer/Menu
@onready var btn_restart = $VBoxContainer/Restart

func _ready():
	btn_menu.pressed.connect(_on_menu_pressed)
	btn_restart.pressed.connect(_on_restart_pressed)
	get_tree().paused = true

func _on_menu_pressed():
	get_tree().paused = false
	get_tree().change_scene_to_file("res://Scenes/MainMenu.tscn")

func _on_restart_pressed():
	get_tree().paused = false
	get_tree().reload_current_scene()
