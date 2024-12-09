extends CharacterBody2D

const SPEED = 80
var last_direction = "down"

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

var is_moving = false

func get_input():
	var input_direction = Input.get_vector("left", "right", "up", "down")
	input_direction = input_direction.normalized()

	velocity = input_direction * SPEED

	return input_direction

func animate(input_direction):
	is_moving = input_direction != Vector2.ZERO

	if is_moving:
		if input_direction.x == 1:
			animated_sprite.play("walk_right")
			animated_sprite.flip_h = false
			last_direction = "right"
		elif input_direction.x == -1:
			animated_sprite.play("walk_right")
			animated_sprite.flip_h = true
			last_direction = "left"

		if input_direction.y == 1:
			animated_sprite.play("walk_down")
			last_direction = "down"
		elif input_direction.y == -1:
			animated_sprite.play("walk_up")
			last_direction = "up"
	else:
		if last_direction == "right":
			animated_sprite.play("idle_right")
			animated_sprite.flip_h = false
		elif last_direction == "left":
			animated_sprite.play("idle_right")
			animated_sprite.flip_h = true

		if last_direction == "down":
			animated_sprite.play("idle_down")
		elif last_direction == "up":
			animated_sprite.play("idle_up")

func _physics_process(delta):
	var input_direction = get_input()
	animate(input_direction)
	move_and_slide()
