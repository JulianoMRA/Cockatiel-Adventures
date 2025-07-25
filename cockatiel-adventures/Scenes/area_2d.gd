extends Area2D

@onready var anim = $AnimationPlayer
@export var target_platform: NodePath

var _is_pressed = false
var is_animating = false

func _ready():
	anim.play("Release")

	var platform = get_node(target_platform)
	platform.get_node("AnimatedSprite2D").visible = false
	platform.get_node("Sprite2D").visible = true
	platform.get_node("CollisionShape2D").disabled = false

	await get_tree().process_frame
	monitoring = true

	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)

func _on_body_entered(body):
	if _is_pressed or is_animating:
		return

	_is_pressed = true
	is_animating = true

	anim.play("Press")
	var platform = get_node(target_platform)

	platform.get_node("Sprite2D").visible = false
	platform.get_node("AnimatedSprite2D").visible = true
	platform.get_node("AnimatedSprite2D").play("Desativando")
	await platform.get_node("AnimatedSprite2D").animation_finished

	platform.get_node("CollisionShape2D").disabled = true
	is_animating = false

func _on_body_exited(body):
	# Aguarda a próxima frame para garantir que todos os corpos já saíram
	await get_tree().process_frame

	# Verifica se ainda há algum corpo dentro
	if get_overlapping_bodies().size() > 0:
		return

	_is_pressed = false
	is_animating = true

	anim.play("Release")
	var platform = get_node(target_platform)

	platform.get_node("AnimatedSprite2D").play("Ativando")
	await platform.get_node("AnimatedSprite2D").animation_finished

	platform.get_node("AnimatedSprite2D").visible = false
	platform.get_node("Sprite2D").visible = true
	platform.get_node("CollisionShape2D").disabled = false
	is_animating = false
