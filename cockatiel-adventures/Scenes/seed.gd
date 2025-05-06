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

		# Atualiza o contador da HUD
		var hud = get_tree().current_scene.get_node("HUD")
		hud.update_seed_count(hud.collected + 1)

		# Toca o som e libera o nó depois
		pickup_sound.play()
		await pickup_sound.finished
		queue_free()
