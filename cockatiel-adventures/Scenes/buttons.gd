extends Node2D

@onready var area = $Area2D
@onready var sprite = $Area2D/Sprite2D
@onready var animation_player = $AnimationPlayer

func _ready():
	area.body_entered.connect(_on_body_entered)
	area.body_exited.connect(_on_body_exited)

func _on_body_entered(body):
	if body.name.begins_with("Player"):
		animation_player.play("Press")

func _on_body_exited(body):
	if body.name.begins_with("Player"):
		animation_player.play("Release")
