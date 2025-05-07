extends Area2D

@onready var anim = $AnimationPlayer
@export var target_platform: NodePath

var _is_pressed = false
var is_animating = false
var _should_release_after_anim = false

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

	# Se o player saiu durante a animação, reativa imediatamente
	if _should_release_after_anim:
		_should_release_after_anim = false
		_on_body_exited(body)

func _on_body_exited(body):
	if is_animating:
		_should_release_after_anim = true
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
