extends Area2D

@onready var anim = $AnimatedSprite2D
@onready var pickup_sound = $PickupSound
@onready var collision = $CollisionShape2D

func _ready():
	anim.play("Idle")
	body_entered.connect(_on_body_entered)

func _on_body_entered(body):
	if body.name.begins_with("Player"):
		# Esconde a semente e desabilita a colisão imediatamente
		anim.visible = false
		collision.disabled = true

		pickup_sound.play()
		await pickup_sound.finished
		queue_free()
