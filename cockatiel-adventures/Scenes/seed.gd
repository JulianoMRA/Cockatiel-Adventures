extends Area2D

signal collected

@onready var anim = $AnimatedSprite2D
@onready var pickup_sound = $PickupSound
@onready var collision = $CollisionShape2D

func _ready():
	anim.play("Idle")
	body_entered.connect(_on_body_entered)

func _on_body_entered(body):
	if body.name.begins_with("Player"):
		anim.visible = false
		collision.call_deferred("set_disabled", true)
		emit_signal("collected")
		pickup_sound.play()
		await pickup_sound.finished
		queue_free()
