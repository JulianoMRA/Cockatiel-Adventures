extends Area2D

@export var target_platform: NodePath
@export var texture_normal: Texture2D
@export var texture_pressed: Texture2D

@onready var sprite = $Sprite2D
var _is_pressed = false
var is_animating = false
var _should_release_after_anim = false

func _ready():
	set_pressed(false)
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)

func _on_body_entered(body):
	if not _is_body_player(body):
		return
	# Se já está pressionado ou animando, só atualiza o sprite do botão
	if _is_pressed or is_animating:
		set_button_sprite(true)
		return

	_is_pressed = true
	is_animating = true
	set_button_sprite(true)

	var platform = get_node(target_platform)
	platform.get_node("Sprite2D").visible = false
	platform.get_node("AnimatedSprite2D").visible = true
	platform.get_node("AnimatedSprite2D").play("Desativando")
	await platform.get_node("AnimatedSprite2D").animation_finished
	platform.get_node("CollisionShape2D").disabled = true

	is_animating = false

	# Se alguém saiu durante a animação, resolve imediatamente
	if _should_release_after_anim:
		_should_release_after_anim = false
		_on_body_exited(body)

func _on_body_exited(body):
	await get_tree().process_frame
	# Só desativa se não houver mais jogadores
	if get_overlapping_bodies().any(_is_body_player):
		return

	if is_animating:
		_should_release_after_anim = true
		return

	_is_pressed = false
	is_animating = true
	set_button_sprite(false)

	var platform = get_node(target_platform)
	platform.get_node("AnimatedSprite2D").play("Ativando")
	await platform.get_node("AnimatedSprite2D").animation_finished

	platform.get_node("AnimatedSprite2D").visible = false
	platform.get_node("Sprite2D").visible = true
	platform.get_node("CollisionShape2D").disabled = false

	is_animating = false

func set_button_sprite(pressed: bool):
	sprite.texture = texture_pressed if pressed else texture_normal

func set_pressed(pressed: bool):
	_is_pressed = pressed
	set_button_sprite(pressed)

func _is_body_player(body):
	# Ajuste para seu jogo: reconhece o player pelo nome ou grupo
	return body.name.begins_with("Player")
