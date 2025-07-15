extends Control

func _on_play_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/level_1.tscn")

func _on_quit_pressed() -> void:
	get_tree().quit()

func _on_config_pressed() -> void:
	print("Abrir painel de configurações")
