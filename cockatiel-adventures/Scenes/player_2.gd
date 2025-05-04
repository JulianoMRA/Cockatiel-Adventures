extends CharacterBody2D

const SPEED = 150
const JUMP_VELOCITY = -240
const GRAVITY = 600

@onready var sprite = $AnimatedSprite2D

func _physics_process(delta):
	if not is_on_floor():
		velocity.y += GRAVITY * delta

	var direction = Input.get_action_strength("ui_right2") - Input.get_action_strength("ui_left2")
	velocity.x = direction * SPEED

	if is_on_floor() and Input.is_action_just_pressed("ui_up2"):
		velocity.y = JUMP_VELOCITY

	move_and_slide()

	if direction != 0:
		sprite.play("walk")
		sprite.flip_h = direction < 0
	else:
		sprite.play("Idle2")
