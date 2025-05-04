extends Area2D

@onready var anim = $AnimationPlayer
@export var target_platform: NodePath

var _is_pressed = false

func _ready():
	# Garante que a animação começa solta
	anim.play("Release")
	
	# Garante que a plataforma começa ativa
	var platform = get_node(target_platform)
	platform.get_node("AnimatedSprite2D").visible = false
	platform.get_node("Sprite2D").visible = true
	platform.get_node("CollisionShape2D").disabled = false

	# Aguarda um frame antes de ativar o monitoring, evitando detectar o player no início
	await get_tree().process_frame
	monitoring = true

	# Conecta os sinais
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)

func _on_body_entered(body):
	if _is_pressed:
		return

	_is_pressed = true
	anim.play("Press")
	var platform = get_node(target_platform)

	platform.get_node("Sprite2D").visible = false
	platform.get_node("AnimatedSprite2D").visible = true
	platform.get_node("AnimatedSprite2D").play("Desativando")

	await platform.get_node("AnimatedSprite2D").animation_finished
	platform.get_node("CollisionShape2D").disabled = true

func _on_body_exited(body):
	_is_pressed = false
	anim.play("Release")
	var platform = get_node(target_platform)

	platform.get_node("AnimatedSprite2D").play("Ativando")

	await platform.get_node("AnimatedSprite2D").animation_finished
	platform.get_node("AnimatedSprite2D").visible = false
	platform.get_node("Sprite2D").visible = true
	platform.get_node("CollisionShape2D").disabled = false
