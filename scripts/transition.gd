extends CanvasLayer

signal on_transition_finished

@onready var panel = $Panel
@onready var animation_player = $AnimationPlayer

func _ready() -> void:
	panel.visible = false
	animation_player.animation_finished.connect(_on_animation_finished)

func _on_animation_finished(animation_name: String):
	if animation_name == "fade_in":
		on_transition_finished.emit()
		animation_player.play("fade_out")
	elif animation_name == "fade_out":
		panel.visible = false

func transition():
	panel.visible = true
	animation_player.play("fade_in")
