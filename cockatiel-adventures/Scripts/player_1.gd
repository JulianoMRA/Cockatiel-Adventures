extends CharacterBody2D

const SPEED = 150
const JUMP_VELOCITY = -300
const GRAVITY = 600

@onready var sprite = $AnimatedSprite2D

func _physics_process(delta):
	# Aplica gravidade
	if not is_on_floor():
		velocity.y += GRAVITY * delta

	# Movimento lateral
	var direction = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	velocity.x = direction * SPEED

	# Pulo
	if is_on_floor() and Input.is_action_just_pressed("ui_up"):
		velocity.y = JUMP_VELOCITY

	# MOVIMENTO: aplicar velocidade
	move_and_slide()

	# Animação
	if direction != 0:
		sprite.play("walk")
		sprite.flip_h = direction < 0
	else:
		sprite.play("Idle1")
