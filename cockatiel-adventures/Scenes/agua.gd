extends Area2D

signal player_entered_water(body)

func _ready():
	body_entered.connect(_on_body_entered)

func _on_body_entered(body):
	if body.name.begins_with("Player"):
		emit_signal("player_entered_water", body)
