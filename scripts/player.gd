extends CharacterBody2D

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var raycast: RayCast2D = $RayCast2D

const SPEED = 80
var can_move = true
var is_moving = false
var last_direction = "down"

func _ready() -> void:
	Dialogic.timeline_started.connect(_on_timeline_started)
	Dialogic.timeline_ended.connect(_on_timeline_ended)

	Dialogic.start("player_should_go_to_witch")

func _physics_process(delta):
	if can_move:
		var input_direction = get_input()
		animate(input_direction)
		change_raycast_direction(input_direction)
		move_and_slide()

func _on_timeline_started():
	can_move = false
	animate(Vector2.ZERO)

func _on_timeline_ended():
	can_move = true

func get_input():
	var input_direction = Input.get_vector("left", "right", "up", "down")
	input_direction = input_direction.normalized()

	if can_move:
		velocity = input_direction * SPEED

	return input_direction

func animate(input_direction):
	if !can_move:
		if last_direction == "right":
			animated_sprite.play("idle_right")
			animated_sprite.flip_h = false
		elif last_direction == "left":
			animated_sprite.play("idle_right")
			animated_sprite.flip_h = true
		elif last_direction == "down":
			animated_sprite.play("idle_down")
		elif last_direction == "up":
			animated_sprite.play("idle_up")
		return

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

func change_raycast_direction(input_direction):
	if is_moving:
		var input_angle = atan2(-input_direction.x, input_direction.y)
		raycast.global_rotation = input_angle
