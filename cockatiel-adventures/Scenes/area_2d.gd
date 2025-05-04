extends Area2D

@onready var anim = $AnimationPlayer
@onready var sprite = $Sprite2D

func _ready():
	monitoring = true
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)

func _on_body_entered(body):
	if body.name.begins_with("Player"):
		anim.play("Press")

func _on_body_exited(body):
	if body.name.begins_with("Player"):
		anim.play("Release")
